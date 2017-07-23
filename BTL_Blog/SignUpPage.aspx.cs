using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BTL_Blog
{
    public partial class SignUpPage : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Username"] != null)
            {
                Response.Redirect("Hompage.aspx");
            }
        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            if (this.pass.Text != this.passAgain.Text)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Nhập lại mật khẩu không chính xác')", true);
                return;
            }
            
            using (SqlCommand cmd = new SqlCommand("checkExist", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName", this.userName.Text);
                try
                {
                    con.Open();
                    if (Convert.ToInt16(cmd.ExecuteScalar()) == 0)
                    {
                        using (SqlCommand com = new SqlCommand("createUser", con))
                        {
                            com.CommandType = CommandType.StoredProcedure;
                            com.Parameters.AddWithValue("@userName", this.userName.Text);
                            com.Parameters.AddWithValue("@pass", this.passAgain.Text);
                            com.Parameters.AddWithValue("@name", this.name.Text);
                            com.Parameters.AddWithValue("@email",this.email.Text);
                            try
                            {
                                com.ExecuteScalar();
                                Session["Username"] = this.userName.Text;
                                Response.Redirect("HomePage.aspx");
                            }
                            catch (Exception ex)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Opps! Có lỗi:" + ex.ToString() + "')", true);
                            }
                            finally
                            {
                                com.Dispose();
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Tài khoản đã tồn tại rồi)", true);
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
                    Response.Redirect(Session["link"].ToString());
                }
            }
        }

        protected void back_Click(object sender, EventArgs e)
        {
            if (Session["link"] != null)
            {
                Response.Redirect(Session["link"].ToString());
            }
        }
    }
}