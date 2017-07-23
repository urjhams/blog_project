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
    public partial class FriendList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["blogConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                if (!IsPostBack)
                {
                    LoadFriend(Session["Username"].ToString());

                    this.userAvatar.ImageUrl = UserAvatarUrl();
                }  
            } else
            {
                Response.Redirect("ErrorPage.aspx");
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
                    return "/assets/img/userAvatar/" + avatarName;
                }
            }
            else
            {
                return "/assets/img/userAvatar/unknownuser.png";
            }

        }

        private void LoadFriend(string username)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da;
            using (SqlCommand cmd = new SqlCommand("loadFriends", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userName", username);
                try
                {
                    da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        this.friendList.DataSource = dt;
                        this.friendList.DataBind();
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

        protected void logOut_Click(object sender, EventArgs e)
        {
            if(Session["Username"] != null)
            {
                Session["Username"] = null;
                Response.Redirect("HomePage.aspx");
            } else
            {
                Response.Redirect("ErrorPage.aspx");
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

        protected void friendList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (this.friendList.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    Label NoFriends = (Label)e.Item.FindControl("NoFriend");
                    NoFriends.Visible = true;
                }
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