<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostPage.aspx.cs" Inherits="BTL_Blog.PostPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bài viết <%//Response.Write(""); %></title>
    <meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
  	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        /*------- navbar ---------*/
        .navbar {
  			margin-bottom: 0;
  			border: 0;
  			opacity: 0.95;
  		}
  		.navbar-default .navbar-toogle {
  			border-color: transparent;
  		}
  		.navbar li a, .navbar .navbar-brand {
  			color: rgb(0, 0, 0);
            background-color: #fff ;
  		}
        .navbar li a:hover {
            background-color: #fff;
  		}

        .specialLi a {
            color:#006dcc  !important;
        }
        .specialLi a:hover {
            color:#0044cc  !important;
        }
        .navbar-default {
            background-color:#fff;
        }

        /*------overlay on click-------*/
        .overlay {
            height:0%;
            width:100%;
            position:fixed;
            z-index: 1;
            top:0;
            left:0;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.9);
            overflow-y: hidden;
            transition:0.5s;
        }
        .overlay-content {
            position:relative;
            top:25%;
            width:100%;
            text-align: center;
            margin-top:30px;
        }
        .overlay a {
            padding:8px;
            text-decoration: none;
            font-size: 36px;
            color:#818181;
            display:block;
            transition:0.3s;
        }
        .overlay a:hover, .overlay a:focus {
            color: #f1f1f1;;
        }
        .overlay .closebtn {
            position: absolute;
            top:20px;
            right:45px;
            font-size:60px;
        }
        @media screen and (max-height:450px) {
            .overlay {overflow-y: auto;}
            .overlay a {font-size: 20px;}
            .overlay .closebtn {
                font-size: 40px;
                top: 15px;
                right: 35px;
            }
        }


        /*---------main containt--------*/
        .textContent {
            font-family:Arial, Helvetica, sans-serif;
            text-align:justify;
        }

        .avatar {
            height:30px;
            width:30px;
        }
        .coverBackgroundParallax {
            width:100%;
            height:500px;
            background-attachment:fixed;
            background-position: center top;
            background-size: cover;
            background-repeat:no-repeat;
        }
        @media only screen and (max-device-width:1024px) {
            .coverBackgroundParallax {
                background-attachment:scroll;
            }
        }

        /*--- user avatar trên navbar--*/
        .myAvatar {
            height:25px;
            width:25px;
            margin-top:12px;
        }

        .delBtn {
            float:right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!--------      overlay navbar     -------->
        <div id="userNav" class="overlay">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <div class="overlay-content">
                <asp:LinkButton runat="server" ID="myInfor" Text="Tài khoản" Font-Underline="false" OnClick="myInfor_Click"></asp:LinkButton>
                <asp:LinkButton runat="server" ID="changePwd" Text="Đổi mật khẩu" Font-Underline="false"></asp:LinkButton>
                <asp:LinkButton runat="server" ID="logOut" Text="Đăng xuất" Font-Underline="false" OnClick="logOut_Click"></asp:LinkButton>
            </div>
        </div>
        <script type="text/javascript">
            function openNav() {
                document.getElementById("userNav").style.height = "100%";
            }
            function closeNav() {
                document.getElementById("userNav").style.height = "0%";
            }
        </script>

        <!-----   thanh navbar     ------>
         <div class="navbar navbar-default navbar-fixed-top" style="display: block;color: rgb(0, 0, 0);">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"  data-target="#theNavBar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand"  href="HomePage.aspx">Blog</a>
                </div>
                <div class="collapse navbar-collapse" id="theNavBar">
                    <%if (Session["Username"] == null || Session["Username"].ToString() == "")
                        {%>
                    <ul class="nav navbar-nav navbar-right">
                        <li style='left: 0px; top: 0px;' class='specialLi'><a href='#loginModal' data-target='#loginModal' data-toggle='modal'>Đăng nhập/Đăng ký</a></li>
                    </ul>
                    <%}
                    else
                    { %>
                    <div class="navbar-right">
                        <ul class="nav navbar-nav">
                            <li style='left: 0px; top: 0px;'>
                                <asp:LinkButton runat="server" ID="createPost" Text="Viết bài" Font-Underline="false" OnClick="createPost_Click"></asp:LinkButton>
                            </li>
				        </ul>
                        <a href="#" onclick="openNav()"><asp:Image runat="server" ID="userAvatar" CssClass="myAvatar img-circle"/></a>
                    </div>
                    <%} %> 
                </div>
		    </div>
        </div>

        <!-----   Top cover     ------>

        <div id="loginModal" class="modal fade" role="dialog"><div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="loginLabel">Đăng nhập</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="well"><!-- cái này tạo thêm 1 boder xung quanh-->
                                <div id="loginForm">
                                    <div class="form-group">
                                        <label for="username" class="control-label">Tài khoản</label>
                                        <asp:TextBox CssClass="form-control" ID="acc" runat="server" placeholder="nhập tài khoản"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="pass" class="control-label">Mật khẩu</label>
                                        <asp:TextBox runat="server" ID="pwd" CssClass=" form-control" TextMode="Password" placeholder="nhập mật khẩu"></asp:TextBox>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <asp:CheckBox runat="server" ID="remember" Text="" CssClass="text-left" />Giữ tôi luôn đăng nhập
                                        </label>
                                    </div>
                                    <asp:Button runat="server" ID="btnLogin" Text="Đăng nhập" CssClass="btn btn-success btn-block" OnClick="btnLogin_Click"/>
                                    <asp:Button runat="server" ID="forgotPwd" CssClass="btn btn-default btn-block" Text="Quên mật khẩu?" OnClick="forgotPwd_Click"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <p class="lead"> hoặc đăng ký <span class="text-success">MIỄN PHÍ</span></p>
                            <ul class="list-unstyled" style="line-height:2; color:black">
                                <li><span class="glyphicon glyphicon-ok text-success"></span>  Tạo và quản lý blog cá nhân</li>
                                <li><span class="glyphicon glyphicon-ok text-success"></span>  Dễ dàng sao lưu bài viết</li>
                                <li><span class="glyphicon glyphicon-ok text-success"></span>  Chia sẻ với bạn bè</li>
                                <li><span class="glyphicon glyphicon-ok text-success"></span>  Và nhiều tính năng nữa...</li>
                                <li><a href="#">Về chúng tôi</a></li>
                            </ul>
                            <asp:Button runat="server" ID="signUp" CssClass="btn btn-info btn-block" Text="Đăng ký ngay!!!" OnClick="signUp_Click"/>
                        </div>
                    </div>
                </div>
            </div>
        </div></div>
        <script type="text/javascript">
            function closeModal() {
                $('#loginModal').modal('hide');
            }
        </script>

        <!-----    page content     ------>

        <div id="Title" class="container" style="padding-top:100px; padding-bottom:10px; padding-left:150px; padding-right:150px;">
            <div class="row">
                <div class="col-lg-8 textContent">
                    <div class="media">
                        <div class="media-left">
                            <asp:Image CssClass="avatar media-object img-circle" runat="server" ID="authorAvatar" />
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading" style="font-weight:bold"><asp:HyperLink runat="server" ID="postAuthorLink" ForeColor="Black" Font-Underline="false"></asp:HyperLink></h4>
                            <p style="font-size:10px;">Đã đăng vào <asp:Label runat="server" ID="postTime"></asp:Label></p>
                        </div>
                    </div>
                    <h1><asp:Label runat="server" ID="postTitle"></asp:Label></h1>
                    <br />
                    <!--<p><span class="glyphicon glyphicon-time"></span> Posted on August 24, 2013 at 9:00 PM</p>-->
                    <asp:Label runat="server" Visible="false" ID="AuthorUsername"></asp:Label>
                </div>
            </div>
        </div>

        <div id="Cover">
            <% if (Session["coverImage"] != null)
                {
                    Response.Write("<div id='coverIMG' class='coverBackgroundParallax' style='background-image:url(/assets/img/postCover/" + Session["coverImage"].ToString() + ")'></div>");
                }
                else
                {
                    Response.Write("<div id='coverIMG' class='coverBackgroundParallax' style='background-image:url(/assets/img/postCover/showIMG1.jpg)'></div>");
                }%>     
        </div>
        <div id="Content" class="container" style="padding-top:60px; padding-bottom:20px; padding-left:150px; padding-right:150px;">
            <div class="row">
                <div class="col-lg-8">
                    <div id="introduce" style="font-style:italic; padding-left:20px; padding-bottom:20px;" class="textContent">
                        <p><asp:Label runat="server" ID="postPreContent"></asp:Label></p>
                    </div>
                    <div id="content" class=" textContent">
                        <p><asp:Label runat="server" ID="postContent"></asp:Label></p>
                    </div>
                </div>
            </div>
            <hr />
        </div>
        <div id="configBtn" class="container" style="padding-left:120px; padding-right:120px;">
            <div class="row" style="padding-bottom:30px;">
                <div class="col-md-8"></div>
                <div class="col-sm-2">
                    
                </div>
                <div class="col-sm-2">
                    <%if (Session["USername"] != null && Session["Username"].ToString() == ViewState["authorUsername"].ToString())
                        { %>
                    <asp:Button runat="server" ID="alter" Text="Sửa bài viết" CssClass="btn btn-default btn-sm" OnClick="alter_Click" />
                    <%} %>
                </div>
            </div>
        </div>
        <div class="container" style="padding-right:200px; padding-left:200px;">
            <div id="commentArea">
                <h4>Phản hồi</h4>
                <div class="form-group" style="padding-bottom:0px;">
                    <asp:Textbox runat="server" ID="writeComment" CssClass="form-control inputField" placeholder="Để lại nhận xét của bạn..." TextMode="MultiLine" Height="50px"></asp:Textbox>
                    <br />
                    <div id="commentBtn">
                        <asp:Button runat="server" ID="submitComment" CssClass="btn btn-success btn-sm" Text="Đăng Phản hồi" OnClick="submitComment_Click" />
                    </div>
                </div>
            </div>
            <script>
                $(document).ready(function () {
                    $('.inputField').height(50);
                    $('.inputField').focus(function () {
                        $(this).animate({
                            height: 200
                        })
                    });
                    $('.inputField').blur(function () {
                        $(this).animate({
                            height: 50
                        })
                    });
                });
            </script>
            <div id="commentList" style="padding-top:25px; padding-bottom:30px;">
                
                <asp:Repeater runat="server" ID="commentsList" OnItemDataBound="commentsList_ItemDataBound" OnItemCommand="commentsList_ItemCommand">
                    <ItemTemplate>
                        <div class="media">
                            <a class="pull-left" href="#">
                                <img class="img-circle img-responsive avatar" src='/assets/img/userAvatar/<%# DataBinder.Eval(Container.DataItem,"avatar") %>' alt='' />
                            </a>
                            <div class="media-body">
                                <h4 class="media-heading">
                                    <asp:HyperLink runat="server" ID="anotherUser" Text='<%# DataBinder.Eval(Container.DataItem,"name") %>' NavigateUrl='<%# Eval("userName","User.aspx?user={0}") %>' ForeColor="Black" Font-Underline="false"></asp:HyperLink>
                                    <small><%# Eval("createDate") %></small>
                                </h4>
                                <%# Eval("commentContent") %>
                            </div>
                        </div>
                        <asp:LinkButton runat="server" ID="deleteComment" Text="Xóa" CssClass="delBtn" Visible='<%# (Session["Username"] != null && Eval("userName").ToString() == Session["Username"].ToString()) ? true : false %>' CommandName="Delete" CommandArgument='<%# Eval("commentID") %>' Font-Underline="false" ForeColor="DarkSlateGray" OnClientClick='return confirm("Bạn chắc chắn muốn xóa?")'></asp:LinkButton>
                        <hr />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
    <br /><br />
    <footer class="container-fluid text-center" style="font-family:Arial, Helvetica, sans-serif; height:110px;">
        <p style="margin-top:30px;">Copyright © <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Quân Đinh</a>, <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Toàn Thắng</a>, and <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Lam Sơn</a></p>
        <p>Powered by <a href="getbootstrap.com" style="text-decoration:none;color:#4800ff">Boostrap</a></p>
    </footer>
</body>
</html>
