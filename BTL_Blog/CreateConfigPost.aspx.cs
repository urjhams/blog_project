using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;

namespace BTL_Blog
{
    public partial class CreatePost : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                this.userAvatar.ImageUrl = Session["UserAvatar"].ToString();
                this.authorAvatar.ImageUrl = Session["UserAvatar"].ToString();

                if (Session["alterPost"] != null)   //Sesion này chứa id của bài post
                {
                    // load lại dữ liệu
                    if (!IsPostBack)
                    {
                        getContent(Session["alterPost"].ToString());
                    }
                }   // nếu là null thì là tạo bài viết
            }
            
        }

        private void getContent(string postId)
        {
            using (SqlCommand cmd = new SqlCommand("getPostContent", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@postID", postId);
                System.Data.DataTable dt = new System.Data.DataTable();
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    da.Dispose();

                    if (dt.Rows.Count == 1)
                    {
                        Session["coverImage"] = dt.Rows[0]["postCover"].ToString();
                        this.titleArea.Text = dt.Rows[0]["postTitle"].ToString();
                        this.preContentArea.Text = dt.Rows[0]["postPreContent"].ToString();
                        this.contentArea.Text = dt.Rows[0]["postContent"].ToString();
                        this.authorAvatar.ImageUrl = "/assets/img/userAvatar/" + dt.Rows[0]["avatar"].ToString();
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

        protected void CreatePost_Click(object sender, EventArgs e)
        {
            HttpPostedFile imageFile = Request.Files["uploadImage"];
            string fileName;
            if (imageFile.ContentLength > 0 && imageFile != null)   //check có file chưa
            {
                //thay tên file ảnh
                fileName = Session["Username"].ToString() + "_cover_" + DateTime.Now.ToShortDateString() + Path.GetFileName(imageFile.FileName);

                //check tên file ảnh, nếu có, xóa
                if (File.Exists(Server.MapPath("~/assets/img/postCover/" + fileName)))
                {
                    File.Delete(Server.MapPath("~/assets/img/postCover/" + fileName));
                }

                //lưu file ảnh
                imageFile.SaveAs(Server.MapPath(Path.Combine("~/assets/img/postCover", fileName)));
            } else
            {
                fileName = "default.jpg";
            }
            //tạo bài viết
            using (SqlCommand cmd = new SqlCommand("prc_createPost", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@title", this.titleArea.Text);
                cmd.Parameters.AddWithValue("@content", this.contentArea.Text);
                cmd.Parameters.AddWithValue("@cover", fileName);
                cmd.Parameters.AddWithValue("@username",Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@date", DateTime.Now);
                cmd.Parameters.AddWithValue("@preTitle", this.preContentArea.Text);
                con.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Redirect(Session["link"].ToString());
                }
                catch (Exception ex)
                {

                }
                con.Close();
            }
        }

        protected void CancelPost_Click(object sender, EventArgs e)
        {
            if (Session["alterPost"] == null)
            {
                Response.Redirect(Session["link"].ToString());
            } else
            {
                string back = Session["link"].ToString() + "?postID=" + Session["alterPost"].ToString();
                Response.Redirect(back);
            } 
        }

        protected void alterPost_Click(object sender, EventArgs e)
        {
            HttpPostedFile imageFile = Request.Files["uploadImage"];
            string fileName;
            if (imageFile.ContentLength > 0 && imageFile != null)   //check có file chưa
            {
                //thay tên file ảnh
                fileName = Session["Username"].ToString() + "_cover_" + DateTime.Now.ToShortDateString() + Path.GetFileName(imageFile.FileName);

                //check tên file ảnh, nếu có, xóa
                if (File.Exists(Server.MapPath("~/assets/img/postCover/" + fileName)))
                {
                    File.Delete(Server.MapPath("~/assets/img/postCover/" + fileName));
                }
                // xóa ảnh cũ
                File.Delete(Server.MapPath("~/assets/img/postCover/" + Session["coverImage"].ToString()));
                //lưu file ảnh
                imageFile.SaveAs(Server.MapPath(Path.Combine("~/assets/img/postCover", fileName)));
            }
            else
            {
                fileName = Session["coverImage"].ToString();
            }

            //Lưu chỉnh sửa
            using (SqlCommand cmd = new SqlCommand("alterPost", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@postID", Session["alterPost"].ToString());
                cmd.Parameters.AddWithValue("@postTitle", this.titleArea.Text);
                cmd.Parameters.AddWithValue("@postContent", this.contentArea.Text);
                cmd.Parameters.AddWithValue("@postCover", fileName);
                cmd.Parameters.AddWithValue("@createDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@postPreContent", this.preContentArea.Text);
                cmd.Parameters.AddWithValue("@userName", Session["Username"].ToString());
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                } catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    string back = Session["link"].ToString() + "?postID=" + Session["alterPost"].ToString();
                    Session["alterPost"] = null;
                    Response.Redirect(back);
                }
            }
        }

        protected void logOut_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Session["link"] = null;
            Session["alterPost"] = null;
            Response.Redirect("~/HomePage.aspx");
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