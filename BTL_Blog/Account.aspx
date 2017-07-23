<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="BTL_Blog.Account" %>

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

        /*------- upload button------*/
        label.uploadFile input[type="file"] {
            position:fixed;
            top: -1000px;
        }

        .uploadFile {
            border: 2px solid #fff;
            border-radius:50%;
            text-align:center;
            display:inline-block;
            background:#DDD;
            width:35px;
            height:35px;
        }
        .uploadFile:hover {
            background:#CCC;
        }
        .uploadFile:active {
            background:#CCF;
        }
        .uploadFile:invalid + span {
            color:#A44;
        }
        .uploadFile:valid + span {
            color:#4A4;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">  <!--set enctype để truy cập được uploader thông qua httpRequest.Files-->

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

        <!---------- content ----------->
        <div id="Title" class="container" style="padding-top:100px; padding-bottom:10px; padding-left:150px; padding-right:150px;">
            <div class="row">
                <div class="col-md-4">
                    <h3>Ảnh đại diện</h3>
                    <br />
                    <img id="avatarImg" runat="server" src="#" class="img-circle" style="width:100px; height:100px;"/>
                    <br />
                    <label class="uploadFile">
                        <input type="file" id="browser" onchange="readFile(this)" accept="image/png, image/jpg" name="uploadAvatar"/>
                        <span class="glyphicon glyphicon-camera small" style="padding-top:7px; padding-left:1px;"></span>
                    </label>
                    <script type="text/javascript">
                        function readFile(input) {
                            if (input.files && input.files[0]) {
                                var reader = new FileReader();

                                reader.onload = function (e) {
                                    $('#avatarImg').attr('src', e.target.result);
                                };

                                reader.readAsDataURL(input.files[0]);
                            }
                        }
                    </script> 
                </div>
                <div class="col-md-6" style="padding-left:70px;">
                    <h3 style="padding-bottom:16px;">Thông tin cá nhân</h3>
                    <div class="form-group">
                        <label class="control-label">Tài khoản:  <asp:Label runat="server" ID="userName" CssClass="control-label"></asp:Label></label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Tên:</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Name" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Email:</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Email" TextMode="Email"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div style=" padding-top:20px; padding-bottom:100px">
                <asp:Button runat="server" CssClass="btn btn-md btn-success" ID="alter" Text="Cập nhật thông tin" OnClick="alter_Click" />
            </div>
        </div>
    </form>
    <footer class="container-fluid text-center" style="font-family:Arial, Helvetica, sans-serif; height:110px;">
        <p style="margin-top:30px;">Copyright © <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Quân Đinh</a>, <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Toàn Thắng</a>, and <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Lam Sơn</a></p>
        <p>Powered by <a href="getbootstrap.com" style="text-decoration:none;color:#4800ff">Boostrap</a></p>
    </footer>
</body>
</html>
