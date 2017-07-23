using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace BTL_Blog
{
    public partial class Account : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {

                this.userName.Text = Session["Username"].ToString();

                if (!IsPostBack)
                {
                    this.userAvatar.ImageUrl = UserAvatarUrl();
                    avatarImg.Attributes["src"] = ResolveUrl(UserAvatarUrl());

                    fillMyInfo(Session["Username"].ToString());
                }
            }
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }

        private void fillMyInfo(string userName)
        {
            using (SqlCommand cmd = new SqlCommand("getMyInfo", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName",userName);
                DataTable dt = new DataTable();
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    da.Dispose();

                    if (dt.Rows.Count == 1)
                    {
                        this.Name.Text = dt.Rows[0]["name"].ToString();
                        this.Email.Text = dt.Rows[0]["email"].ToString();
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
                    Session["MyAvatar"] = avatarName;
                    return "/assets/img/userAvatar/" + avatarName;
                }
            }
            else
            {
                return "/assets/img/userAvatar/unknownuser.png";
            }

        }

        protected void createPost_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Session["link"] = Request.Path.ToString();
                Session["alterPost"] = null;
                Response.Redirect("~/CreateConfigPost.aspx");
            }
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }

        protected void logOut_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Session["Username"] = null;
                Response.Redirect("HomePage.aspx");
            } else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }

        protected void alter_Click(object sender, EventArgs e)
        {
            HttpPostedFile imageFile = Request.Files["uploadAvatar"];
            string fileName;
            if (imageFile.ContentLength > 0 && imageFile != null)   //check có file chưa
            {
                //thay tên file ảnh
                fileName = Session["Username"].ToString() + "_avatar_" + Path.GetFileName(imageFile.FileName);

                //check tên file ảnh, nếu có, xóa
                if (File.Exists(Server.MapPath("~/assets/img/userAvatar/" + fileName)))
                {
                    File.Delete(Server.MapPath("~/assets/img/userAvatar/" + fileName));
                }
                // xóa ảnh cũ
                File.Delete(Server.MapPath("~/assets/img/userAvatar/" + Session["MyAvatar"].ToString()));
                //lưu file ảnh
                imageFile.SaveAs(Server.MapPath(Path.Combine("~/assets/img/userAvatar/", fileName)));
            }
            else
            {
                fileName = Session["MyAvatar"].ToString();
            }

            //Lưu chỉnh sửa
            using (SqlCommand cmd = new SqlCommand("updateInfo", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName", Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@name", this.Name.Text);
                cmd.Parameters.AddWithValue("@email", this.Email.Text);
                cmd.Parameters.AddWithValue("@avatar", fileName);
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
                    string back = Session["link"].ToString();
                    Response.Redirect(back);
                }
            }
        }

        protected void myInfor_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.Path.ToString());
        }
    }
}