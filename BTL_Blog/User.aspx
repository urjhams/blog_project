<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="BTL_Blog.User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

        /*-------- cover trang chủ ---------*/
        #bg {
            background-image:url('/assets/img/freelance.jpg');
            background-position: center top;
            background-size: cover;
            padding: 120px 120px 80px 120px;
            background-repeat:no-repeat;
        }
        #box {
            padding: 20px 100px 10px 100px;
            background:rgb(34,34,34);
            background:rgba(34, 34, 34, 0.75);
        }
        #box h2, #box h5, #box h4, #box h5 a {
            text-align:center;
            color:#fefefe;
            font-weight:normal;
            font-family:Arial, Helvetica, sans-serif;
        }
        #box h2 {
            margin-bottom:30px;
        }
        #box h5 {
            margin-top: 50px;
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

        /*------------------- hiệu ứng hiện lên khi cuộn lần đầu--------------------*/
  		.slideShow {visibility: hidden;}
  		.slider {
  			animation-name: slide;
  			-webkit-animation-name: slide;
  			animation-duration: 1s;
  			-webkit-animation-duration: 1s;	
  			visibility: visible;
  		}
  		@keyframes slide {
  			0% {
  				opacity: 0;
  				transform: translateY(70%);
  			}
  			100% {
  				opacity: 1;
  				transform: translateY(0%);
  			}
  		}
  		@-webkit-keyframes slide {
  			0% {
  				opacity: 0;
  				-webkit-transform: translateY(70%);
  			}
  			100% {
  				opacity: 1;
  				-webkit-transform: translateY(0%);
  			}
  		}
        .avatar {
            height:25px;
            width:25px;
            margin-top:12px;
        }
        .authorAvatar {
            height:60px;
            width:60px;
        }

        .pretitle {
            font-family:Arial, Helvetica, sans-serif;
            font-style:oblique;
            padding-left:10px;
            padding-right:10px;
            color:dimgray;
        }

        .hyperlink {
            font-family:Arial, Helvetica, sans-serif;
            color:black;
        }


        /*------nút thêm và xóa bạn-------*/
        .btnState {
            background-color: #4CAF50;
            border:none;
            color:white;
            padding: 2px 4px;
            text-align:center;
            text-decoration:none;
            display:inline-block;
            font-size:10px;
            margin:4px 2px;
            -webkit-transition-duration: 0.4s;
            transition-duration:0.4s;
            cursor:pointer;
        }
        .btnStateAD {
            background-color:white;
            border: 2px solid #008CBA;
            color:#008CBA;
        }
        .btnStateAD:hover {
            background-color:#008CBA;
            color:white;
        }
        .btnStateRM {
            background-color:white;
            border: 2px solid #4CAF50;
            color:#4CAF50;
        }
        .btnStateRM:hover {
            background-color:#4CAF50;
            color:white;
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
                        <a href="#" onclick="openNav()"><asp:Image runat="server" ID="userAvatar" CssClass="avatar img-circle"/></a>
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
                                    <asp:Button runat="server" ID="btnLogin" Text="Đăng nhập" CssClass="btn btn-success btn-block" OnClick="btnLogin_Click" />
                                    <asp:Button runat="server" ID="forgotPwd" CssClass="btn btn-default btn-block" Text="Quên mật khẩu?" OnClick="forgotPwd_Click" />
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
                            <asp:Button runat="server" ID="signUp" CssClass="btn btn-info btn-block" Text="Đăng ký ngay!!!" OnClick="signUp_Click" />
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
            <div class="media">
                <div class="media-middle media-left">
                    <asp:Image runat="server" ID ="thisUserAvtar" CssClass="authorAvatar media-object img-circle" />
                </div>
                <div class="media-body">
                    <h4 class="media-heading"><asp:Label runat="server" ID="thisUserName"></asp:Label></h4>
                    <p><asp:Label runat="server" ID="thisUserInfo"></asp:Label></p>
                </div>
            </div>
            <div style="padding-left:70px;">
                    <% if (Session["Username"] != null && Convert.ToBoolean(ViewState["myFriend"]) == true && ViewState["thisUsername"].ToString() != Session["Username"].ToString())
                        {%>
                    <asp:Button runat="server" ID="removeFriend" Text="Bạn bè" OnClick="removeFriend_Click" CssClass="btnState btnStateRM" OnClientClick='return confirm("Bạn chắc chứ?")'/>
                    <%} else if (Session["Username"] != null && Convert.ToBoolean(ViewState["myFriend"]) == false && ViewState["thisUsername"].ToString() != Session["Username"].ToString()) { %>
                    <asp:Button runat="server" ID="addFriend" Text="Thêm bạn bè" OnClick="addFriend_Click" CssClass="btnState btnStateAD" />
                    <%} %>
            </div>
            <asp:Repeater runat="server" ID="postList">
                <ItemTemplate>
                    <div>
                        <h3 style="padding-top:30px;"><asp:HyperLink runat="server" ID="postTitle" NavigateUrl='<%# Eval("postID","PostPage.aspx?postID={0}") %>' Text='<%# DataBinder.Eval(Container.DataItem,"postTitle") %>' CssClass="hyperlink" Font-Underline="false"></asp:HyperLink></h3>
                        <p><span class="glyphicon glyphicon-time"></span> đã đăng vào <%# DataBinder.Eval(Container.DataItem,"createDate") %></p>
                        <hr />
                        <div style='<%# "width:100%; height:250px; padding-bottom:20px; background-image:url(/assets/img/postCover/" + Eval("postCover") + ");background-position: center center; background-size: cover; background-repeat:no-repeat;" %>'></div>
                        <br />
                        <p class="pretitle"><%# DataBinder.Eval(Container.DataItem,"postPreContent") %></p>
                        <br />
                        <p><asp:HyperLink runat="server" ID="viewPost" NavigateUrl='<%# Eval("postID","PostPage.aspx?postID={0}") %>' Text="Xem bài viết..." CssClass="pretitle" Font-Underline="false"></asp:HyperLink></p>
                        <hr />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
    <br /><br />
    <footer class="container-fluid text-center slideShow" style="font-family:Arial, Helvetica, sans-serif; height:110px;">
        <p style="margin-top:30px;">Copyright © <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Quân Đinh</a>, <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Toàn Thắng</a>, and <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Lam Sơn</a></p>
        <p>Powered by <a href="getbootstrap.com" style="text-decoration:none;color:#4800ff">Boostrap</a></p>
    </footer>
</body>
</html>
