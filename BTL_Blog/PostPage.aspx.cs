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
    public partial class PostPage : System.Web.UI.Page
    {
        string currentID = "";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Username"] != null)
            {
                this.userAvatar.ImageUrl = UserAvatarUrl();
            }


            if (Request.QueryString["PostID"] == null || Request.QueryString["PostID"].ToString() == "")
            {
                Response.Redirect("~/ErrorPage.aspx");
            }
            else
            {
                string id = Request.QueryString["postID"].ToString();
                getContent(id);
                getComments(id);
                currentID = id;
            }
        }

        private void getComments(string postId)
        {
            DataTable dt = new DataTable();
            using (SqlCommand cmd = new SqlCommand("getComments", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@postID", postId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                this.commentsList.DataSource = dt;
                this.commentsList.DataBind();
            }
        }

        private void getContent(string postId)
        {
            using (SqlCommand cmd = new SqlCommand("getPostContent", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@postID", postId);
                DataTable dt = new DataTable();
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    da.Dispose();

                    if (dt.Rows.Count == 1)
                    {
                        Session["coverImage"] = dt.Rows[0]["postCover"].ToString(); //dùng để kiểm tra xem có ảnh không và truyền sang trang sửa
                        this.postTitle.Text = dt.Rows[0]["postTitle"].ToString();
                        this.postAuthorLink.Text = dt.Rows[0]["name"].ToString();
                        this.postAuthorLink.NavigateUrl = "User.aspx?user=" + dt.Rows[0]["userName"].ToString();
                        this.postTime.Text = dt.Rows[0]["createDate"].ToString(); 
                        this.postPreContent.Text = dt.Rows[0]["postPreContent"].ToString();
                        this.postContent.Text = dt.Rows[0]["postContent"].ToString();
                        this.authorAvatar.ImageUrl = "/assets/img/userAvatar/" + dt.Rows[0]["avatar"].ToString();
                        ViewState["authorUsername"] = dt.Rows[0]["userName"].ToString();    //để so sánh username và authorname, nếu giống nhau thì hiện nút sửa
                    }
                    else
                    {
                        Response.Redirect("~/ErrorPage.aspx");
                    }
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
        }

        public void makeDialog(string content)
        {
            Response.Write("<script>alert('" + content + "')</script>");
        }

        private string UserAvatarUrl()
        {
            if (Session["Username"] != null)
            {
                using (SqlCommand cmd = new SqlCommand("prc_getAvatar", con))
                {
                    string avatarName;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userName", Session["Username"].ToString());
                    con.Open();
                    avatarName = cmd.ExecuteScalar().ToString();
                    con.Close();
                    return "/assets/img/userAvatar/" + avatarName;
                }
            }
            else
            {
                return "/assets/img/userAvatar/unknownuser.png";
            }

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

        protected void forgotPwd_Click(object sender, EventArgs e)
        {

        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            Session["link"] = Request.Path.ToString() + "?postID=" + Request.QueryString["PostID"].ToString();
            Response.Redirect("~/SignUpPage.aspx");
        }

        protected void logOut_Click(object sender, EventArgs e)
        {
            Response.Write("<script>closeNav()</script>");
            Session["Username"] = null;
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void createPost_Click(object sender, EventArgs e)
        {
            Session["link"] = Request.Path.ToString() + "?postID=" + Request.QueryString["PostID"].ToString();
            Session["alterPost"] = null;
            Response.Redirect("~/CreateConfigPost.aspx");
        }

        protected void alter_Click(object sender, EventArgs e)
        {
            Session["alterPost"] = Request.QueryString["PostID"].ToString();
            Session["link"] = Request.Path.ToString();
            Response.Redirect("~/CreateConfigPost.aspx");
        }

        protected void commentsList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void commentsList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                using (SqlCommand cmd = new SqlCommand("delComment", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@commentID",e.CommandArgument.ToString());
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
                        if (Page.IsPostBack)
                        {
                            getComments(currentID);
                        }
                        cmd.Dispose();
                    }
                }
            }
        }

        protected void submitComment_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                using (SqlCommand cmd = new SqlCommand("createComment", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@commentContent", this.writeComment.Text);
                    cmd.Parameters.AddWithValue("@userName", Session["Username"].ToString());
                    cmd.Parameters.AddWithValue("@postID", currentID);
                    cmd.Parameters.AddWithValue("@createDate", DateTime.Now);
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
                        this.writeComment.Text = "";
                        con.Close();
                        getComments(currentID);
                        cmd.Dispose();
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Bạn phải đăng nhập để gửi phản hồi')", true);

            }
        }

        protected void myInfor_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Session["link"] = Request.Path.ToString() + "?postID=" + Request.QueryString["PostID"].ToString();
                Response.Redirect("~/Account.aspx");
            }
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }
    }
}