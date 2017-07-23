<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FriendList.aspx.cs" Inherits="BTL_Blog.FriendList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
  	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
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
            color: #f1f1f1;
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
          /*--- user avatar trên navbar--*/
        .avatar {
            height:25px;
            width:25px;
            margin-top:12px;
        }

        .thisUserAvatar {
            height:60px;
            width:60px;
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
                    <div class="navbar-right">
                        <ul class="nav navbar-nav">
                            <li style='left: 0px; top: 0px;'>
                                <asp:LinkButton runat="server" ID="createPost" Text="Viết bài" Font-Underline="false" OnClick="createPost_Click"></asp:LinkButton>
                            </li>
				        </ul>
                        <a href="#" onclick="openNav()"><asp:Image runat="server" ID="userAvatar" CssClass="avatar img-circle"/></a>
                    </div>
                </div>
		    </div>
        </div>

        <!-----    page content     ------>

        <div id="Title" class="container" style="padding-top:30px; padding-bottom:10px; padding-left:150px; padding-right:150px;">
            <div style="padding: 30px 40px 30px 40px">
                <h2 style="padding-bottom:50px; font-family:Arial, Helvetica, sans-serif;color:dimgray">Bạn bè</h2>
                <asp:Repeater runat="server" ID="friendList" OnItemDataBound="friendList_ItemDataBound">
                    <ItemTemplate>
                        <div class="media" style="padding-top:10px; padding-left:0px;">
                            <div class="media-middle media-left">
                                <img class="thisUserAvatar media-object img-circle" src='/assets/img/userAvatar/<%# DataBinder.Eval(Container.DataItem,"avatar") %>' alt='' />
                            </div>
                            <div class="media-body" style="padding-top:10px;">
                                <h4 class="media-heading"><asp:HyperLink runat="server" ID="anotherUser" Text='<%# DataBinder.Eval(Container.DataItem,"name") %>' NavigateUrl='<%# Eval("userName","User.aspx?user={0}") %>' ForeColor="DimGray" Font-Underline="false"></asp:HyperLink></h4>
                                <p><%# DataBinder.Eval(Container.DataItem,"email") %></p>
                            </div>
                        </div>
                        <hr />
                    </ItemTemplate>
                    <FooterTemplate>
                        <h4 style="padding-top:20px; color:dimgray"><asp:Label runat="server" Visible="false" ID="NoFriend" Text="Ồ, xem ra bạn chưa kết bạn với ai"></asp:Label></h4>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>
