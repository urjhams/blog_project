using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace BTL_Blog
{
    public partial class HomePage : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);

        int num = 0;

        public void makeDialog(string content)
        {
            Response.Write("<script>alert('" + content + "')</script>");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    this.userAvatar.ImageUrl = UserAvatarUrl();
                    num = 4;
                    ViewState["numOfRecentPost"] = num;
                    BindRepeater(num);
                    LoadRandomUser();
                }
            }
            
        }

        private void LoadRandomUser()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd;
            SqlDataAdapter da;
            using (cmd = new SqlCommand("getRandomUser", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName", Session["Username"].ToString());
                try
                {
                    da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        this.randomUser.DataSource = dt;
                        this.randomUser.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    cmd.Dispose();
                }
            }
        }

        private void BindRepeater(int numofRows)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd;
            SqlDataAdapter da;
            try
            {
                int totalRows = rowCount();
                if (numofRows > totalRows)
                {
                    this.loadMore.Visible = false;
                }
                using (cmd = new SqlCommand("topPost", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@top", numofRows);
                    cmd.Parameters.AddWithValue("@username",Session["Username"].ToString());
                    da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        this.recentPost.DataSource = dt;
                        this.recentPost.DataBind();
                    } else
                    {
                        this.recentPost.DataSource = null;
                        this.recentPost.DataBind();
                    }
                    cmd.Dispose();
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
            }
            finally
            {
                con.Close();
                da = null;
                dt.Clear();
                dt.Dispose();
            }
        }

        protected int rowCount()
        {
            int rows = 0;
            using (SqlCommand cmd = new SqlCommand("countPost", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@username",Session["Username"].ToString());
                try
                {
                    con.Open();
                    rows = Convert.ToInt32(cmd.ExecuteScalar());
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                }
            }
            return rows;
        }

        private string UserAvatarUrl()
        {
            if (Session["Username"] != null)
            {
                using (SqlCommand cmd = new SqlCommand("prc_getAvatar", con))
                {
                    string avatarName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userName", Session["Username"].ToString());
                    con.Open();
                    avatarName = cmd.ExecuteScalar().ToString();
                    con.Close();
                    return "/assets/img/userAvatar/" + avatarName;
                }
            } else
            {
                return "/assets/img/userAvatar/unknownuser.png";
            }
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (this.acc.Text == "")
            {
                makeDialog("Vui lòng nhập tài khoản và mật khẩu");
            } else
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
                                Session["UserAvatar"] = UserAvatarUrl();

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

        protected void forgotPwd_Click(object sender, EventArgs e)
        {

        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            Session["link"] = Request.Path.ToString();
            Response.Redirect("~/SignUpPage.aspx");
        }

        protected void createPost_Click(object sender, EventArgs e)
        {
            Session["link"] = Request.Path.ToString();
            Session["alterPost"] = null;
            Response.Redirect("~/CreateConfigPost.aspx");
        }

        protected void recentPost_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (this.recentPost.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    Label footer = (Label)e.Item.FindControl("NoRecentPost");
                    footer.Visible = true;
                }
            }
        }

        protected void loadMore_Click(object sender, EventArgs e)
        {
            int numVar = Convert.ToInt32(ViewState["numOfRecentPost"]) + 4;

            BindRepeater(numVar);

            ViewState["numOfRecentPost"] = numVar;
        }

        protected void myFriends_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Response.Redirect("FriendList.aspx");
            } else
            {
                Response.Redirect("ErrorPage.aspx");
            }
            
        }

        protected void myInfor_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Session["link"] = Request.Path.ToString();
                Response.Redirect("~/Account.aspx");
            }
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }
    }
}