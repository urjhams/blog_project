using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace BTL_Blog
{
    public partial class User : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    this.userAvatar.ImageUrl = UserAvatarUrl(Session["Username"].ToString());
                    ViewState["myFriend"] = checkFriendShip(Session["Username"].ToString());
                }
                if (Request.QueryString["user"] == null || Request.QueryString["user"].ToString() == "")
                {
                    Response.Redirect("~/ErrorPage.aspx");
                } else
                {
                    ViewState["thisUsername"] = Request.QueryString["user"].ToString();
                    BindRepeater();
                }
            }
            this.thisUserAvtar.ImageUrl = UserAvatarUrl(Request.QueryString["user"].ToString());
            getThisUserInfo(Request.QueryString["user"].ToString());
        }


        private void BindRepeater()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd;
            SqlDataAdapter da;
            using (cmd = new SqlCommand("allPost",con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@username",ViewState["thisUsername"].ToString());
                try
                {
                    da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        this.postList.DataSource = dt;
                        this.postList.DataBind();
                    }
                }
                catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    cmd.Dispose();
                }
            }
        }


        private bool checkFriendShip(string username)
        {
            bool rs = false;
            using (SqlCommand cmd = new SqlCommand("checkFriendship", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@username1", username);
                cmd.Parameters.AddWithValue("@username2", Request.QueryString["user"].ToString());
                try
                {
                    con.Open();
                    if (Convert.ToInt32(cmd.ExecuteScalar()) == 1)
                    {
                        rs = true;
                    } else
                    {
                        rs = false;
                    }
                }
                catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                }
            }
            return rs;
        }

        private void getThisUserInfo(string username)
        {
            
            SqlCommand cmd1 = new SqlCommand("numFriend", con);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@username", username);

            SqlCommand cmd2 = new SqlCommand("numPost", con);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.AddWithValue("@username", username);

            SqlCommand cmd3 = new SqlCommand("getName", con);
            cmd3.CommandType = CommandType.StoredProcedure;
            cmd3.Parameters.AddWithValue("@username", username);
            try
            {
                con.Open();
                this.thisUserInfo.Text = cmd1.ExecuteScalar().ToString() + " bạn   " + cmd2.ExecuteScalar().ToString() + " bài viết";
                this.thisUserName.Text = cmd3.ExecuteScalar().ToString();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
            }
            finally
            {
                con.Close();
                cmd1.Dispose();
                cmd2.Dispose();
                cmd3.Dispose();
            }
        }

        public void makeDialog(string content)
        {
            Response.Write("<script>alert('" + content + "')</script>");
        }

        private string UserAvatarUrl( string username)
        {
            using (SqlCommand cmd = new SqlCommand("prc_getAvatar", con))
            {
                string avatarName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName", username);
                con.Open();
                avatarName = cmd.ExecuteScalar().ToString();
                con.Close();
                return "/assets/img/userAvatar/" + avatarName;
            }

        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            Session["link"] = Request.Path.ToString() + "?user=" + ViewState["thisUsername"];
            Response.Redirect("~/SignUpPage.aspx");
        }

        protected void forgotPwd_Click(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (this.acc.Text == "")
            {
                makeDialog("Vui lòng nhập tài khoản và mật khẩu");
            }
            else
            {
                //check tk
                int exist;
                using (SqlCommand cmd = new SqlCommand("prc_checkExistUSer", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userName", this.acc.Text);
                    con.Open();
                    exist = Convert.ToInt16(cmd.ExecuteScalar());
                    con.Close();
                    if (exist == 1)
                    {
                        using (SqlCommand cmd2 = new SqlCommand("prc_login_userName", con))
                        {
                            cmd2.CommandType = CommandType.StoredProcedure;
                            cmd2.Parameters.AddWithValue("@userName", this.acc.Text);
                            cmd2.Parameters.AddWithValue("@pwd", this.pwd.Text);
                            con.Open();
                            int rs = (int)cmd2.ExecuteScalar();
                            con.Close();
                            if (rs == 1)
                            {
                                Session["Username"] = this.acc.Text;

                                // sau khi đăng nhập thành công:

                                // get sesson avatar
                                Session["UserAvatar"] = UserAvatarUrl(Session["Username"].ToString());

                                // đóng modal:
                                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "callFunc", "closeModal();", true);

                                // reload page
                                Page.Response.Redirect(Page.Request.Url.ToString(), true);
                            }
                            else
                            {
                                makeDialog("Sai mật khẩu!");
                                return;
                            }
                        }
                    }
                    else
                    {
                        makeDialog("Sai tài khoản!");
                        return;
                    }
                }
            }
        }

        protected void logOut_Click(object sender, EventArgs e)
        {
            Response.Write("<script>closeNav()</script>");
            Session["Username"] = null;
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void createPost_Click(object sender, EventArgs e)
        {
            Session["link"] = Request.Path.ToString();
            Session["alterPost"] = null;
            Response.Redirect("~/CreateConfigPost.aspx");
        }

        protected void removeFriend_Click(object sender, EventArgs e)
        {
            using (SqlCommand cmd = new SqlCommand("delFriend", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName1", Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@userName2", ViewState["thisUsername"].ToString());
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    Page.Response.Redirect(Page.Request.Url.ToString(), true);
                }
            }
                
        }

        protected void addFriend_Click(object sender, EventArgs e)
        {
            using (SqlCommand cmd = new SqlCommand("addFriend", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName1", Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@userName2", ViewState["thisUsername"].ToString());
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    Page.Response.Redirect(Page.Request.Url.ToString(), true);
                }
            }
        }

        protected void myInfor_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Session["link"] = Request.Path.ToString() + "?user=" + Session["Username"].ToString(); 
                Response.Redirect("~/Account.aspx");
            }
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }
    }
}