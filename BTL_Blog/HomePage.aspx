<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="BTL_Blog.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Blog</title>
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

        /*---cover 1---*/
        .bg-1 {
            background-image:url('/assets/img/coverIMG.jpg');
            background-position: center top;
            background-size: cover;
            background-repeat:no-repeat;
        }
        .bg-1-layer {
            padding: 70px 100px 60px 100px;
            background:rgb(34,34,34);
            background:rgba(34, 34, 34, 0.75);
        }
         .bg-1-layer h3, .bg-1-layer p, .bg-1-layer h4, .bg-1-layer h5 {
            color:#fefefe;
            font-weight:normal;
            font-family:Arial, Helvetica, sans-serif;
        }
        .bg-1-layer h3 {
            margin-top:120px;
        }
        .showImg {
            margin-top:100px;
            margin-bottom:100px;
            height:auto;
            width:auto;
            max-height:400px;
            margin-left:auto;
            margin-right:auto;
            display:block;
        }
        /*---cover 3----*/
        .bg-3 {
            background-image:url('/assets/img/blurred/7.jpg');
            background-position: center top;
            background-size: cover;
            background-repeat:no-repeat;
        }
        .bg-3 h3, .bg-3 p {
            color:#fefefe;
            font-weight:normal;
            font-family:Arial, Helvetica, sans-serif;
        }
        .bg-3 h3 {
            margin-top:120px;
        }
        /*---cover 2---*/
        .bg-2 {
            background-image:url('/assets/img/blurred/bg8.jpg');
            background-position: center bottom;
            background-size: cover;
        }
        .bg-2 h3, .bg-2 p {
            color:#fefefe;
            font-weight:normal;
            font-family:Arial, Helvetica, sans-serif;
            margin-bottom:25px;
        }
        .bg-2 h3 {
            margin-top:100px;
        }
        .bg-2 a {
            margin-bottom:60px;
        }


        /*--- user avatar trên navbar--*/
        .avatar {
            height:25px;
            width:25px;
            margin-top:12px;
        }

        .menuAvatar {
            height:20px;
            width:20px;
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


        <!-----   body content     ------>

        <div id="bg">
            <div id="box">
                <h2>CHÀO MỪNG ĐẾN VỚI BLOG</h2>
                <h5>Chia sẻ câu chuyện của bạn cho bạn bè ngay hôm nay, hoàn toàn miễn phí</h5>
                <%if (Session["Username"] == null || Session["Username"].ToString() == "")
                    {%><h5>Tìm hiểu thêm <br /><br /><span class="glyphicon glyphicon-chevron-down" style="font-size:12px"></span></h5> <%}
                else
                { %><h5>Xin chào <%Response.Write(Session["Username"].ToString()); %> <br /><br /><span class="glyphicon glyphicon-chevron-down" style="font-size:12px"></span></h5> <%} %>
            </div>
        </div>

        <%
    if (Session["Username"] == null || Session["Username"].ToString() == "")    //khi người dùng chưa đăng nhập:
            {%>
        <div class="container text-center" style="padding:80px 120px;">
            <h3>BLOG</h3><div class="slideShow">
            <p><em>Nơi chia sẻ câu chuyện của bạn</em></p>
            <p>Chúng tôi tạo ra nơi để bạn có thể tự do chia sẻ câu chuyện của bản thân với thế giới...</p></div>
        </div>


        <div class="bg-1">
            <div class="bg-1-layer">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4" style="min-height:1px;">
                            <img class="img-rounded img-responsive slideShow showImg" src="/assets/img/bg1Test.png" alt="ex"/>
                        </div>
                        <div class="col-md-8" style="min-height: 1px;">
				            <h3 style="display: block;">
					            THỎA SỨC THỂ HIỆN BẢN THÂN
				            </h3>
				            <p style="display: block;">
					            còn gì tuyệt vời hơn một công cụ đơn giản và hiệu quả cho bạn chia sẻ nhiều thứ...<br />
                                với Blog, chúng tôi tạo ra một công cụ cực đơn giản để tạo bài viết của bạn.<br />
                                tất cả đề cao sự tinh tế, tối giản và tiện lợi hết mức có thể cho bạn....
				            </p> 
			            </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container text-center slideShow" style="padding:80px 120px;">
            <h3>TRẢI NGHIỆM</h3>
            <p><em>BLOG sẽ luôn đổi mới, luôn là như vây, vì trải nghiệm của bạn là điều quan trọng với chúng tôi</em></p>
        </div>
        <div class="bg-3">
        <div class="container">
            <div class="row">
                <div class="col-md-8" style="min-height: 1px;">
				    <h3 style="display: block;">
					    GIAO DIỆN ĐƠN GIẢN VÀ BẮT MẮT
				    </h3>
				    <p style="display: block;">
					    thứ đội ngũ phát triển luôn hướng tới là sự hài hòa giữa nội dung cũng như chức năng của website...<br />
                        chúng tôi luôn cố gắng hết mình để đem đến cho bạn trải nghiệm tốt nhất.<br />
                        hãy cùng đồng hành cùng chúng tôi....
				    </p> 
		        </div>
                <div class="col-md-4" style="min-height:1px;">
                    <img class="img-rounded img-responsive slideShow showImg" src="/assets/img/thisSite.png" alt="ex"/>
                </div>
            </div>
        </div></div>
        <div class="container">
            <div class="text-center" style="margin-top:80px;">
                <h3 class="slideShow" style="font-family:Arial, Helvetica, sans-serif; margin-bottom:0px;">VỀ CHÚNG TÔI</h3>
            </div>
            <div class="row" style="margin-bottom:100px; margin-top:0px;">
                <div class="col-xs-10 col-xs-offset-1" style="min-height:1px;">
                    <div class="row" style="margin-top:30px;">
                        <div class="col-md-4" style="min-height:1px;">
                            <div class="row" style="margin-top:30px;">
                                <div class="col-xs-3" style="min-height:1px;">
                                    <img class="img-circle img-responsive slideShow"  src="/assets/img/founder/quan.jpg" alt="thumb" style="box-shadow:0px 4px 8px #888888"/>
                                </div>
                                <div class="col-xs-9" style="min-height:1px;">
                                    <h4>
                                        Quân Đinh<br /><small class="text-muted">tutor &amp; designer</small>
                                    </h4>
                                </div>
                                <div class="col-xs-12" style="min-height:1px; margin-top:20px;font-size:small;">
                                    <p style="display:block; color:darkgrey">Yêu màu xanh của biển<br />Ghét màu hường của các gái<br />Thích bít coin :v</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4" style="min-height:1px;">
                            <div class="row" style="margin-top:30px;">
                                <div class="col-xs-3" style="min-height:1px;">
                                    <img class="img-circle img-responsive slideShow" src="/assets/img/founder/songay.png"" alt="thumb" style="box-shadow:0px 4px 8px #888888"/>
                                </div>
                                <div class="col-xs-9" style="min-height:1px;">
                                    <h4>
                                        Lam Sơn<br /><small class="text-muted">analysis &amp coding</small>
                                    </h4>
                                </div>
                                <div class="col-xs-12" style="min-height:1px; margin-top:20px;font-size:small;">
                                    <p style="display:block; color:darkgrey">Yêu màu tím mộng mơ<br />Ghét màu hồng của sữa<br />Thích tiền mặt</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4" style="min-height:1px;">
                            <div class="row" style="margin-top:30px;">
                                <div class="col-xs-3" style="min-height:1px;">
                                    <img class="img-circle img-responsive slideShow" src="/assets/img/founder/thang.jpg"" alt="thumb" style="box-shadow:0px 4px 8px #888888"/>
                                </div>
                                <div class="col-xs-9" style="min-height:1px;">
                                    <h4>
                                        Toàn Thắng<br /><small class="text-muted">coding &amp; paper work</small>
                                    </h4>
                                </div>
                                <div class="col-xs-12" style="min-height:1px; margin-top:20px;font-size:small;">
                                    <p style="display:block; color:darkgrey;">Yêu màu xanh nõn chuối<br />Ghét màu đỏ của máu<br />Thích ngân phiếu</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-2 container-fluid text-center">
            <h3>THAM GIA NGAY CÙNG CHÚNG TÔI</h3>
            <p>Cùng trải nghiệm những điều thú vị với BLOG<br />Chia sẻ nội dung của bạn mọi lúc, mọi nơi và nhiều hơn nữa...</p>
            <a href="#" class="btn btn-default btn-lg slideShow">Tham gia ngay!</a>
        </div>
        <%}
    else
    {//khi người dùng đăng nhâp: %>
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="page-header">
                        Bài viết mới nhất
                        <!--<small>Secondary Text</small>-->
                    </h1>

                    <!-- nhét vào repeater -->
                    <asp:Repeater runat="server" ID="recentPost" OnItemDataBound="recentPost_ItemDataBound">
                        <ItemTemplate>
                            <h3><asp:HyperLink runat="server" ID="postTitle" NavigateUrl='<%# Eval("postID","PostPage.aspx?postID={0}") %>' Text='<%# DataBinder.Eval(Container.DataItem,"postTitle") %>' CssClass="hyperlink" Font-Underline="false"></asp:HyperLink></h3>
                            <p><span class="glyphicon glyphicon-time"></span> đã đăng vào <%# DataBinder.Eval(Container.DataItem,"createDate") %></p>
                            <hr />
                            <div style='<%# "width:100%; height:250px; padding-bottom:20px; background-image:url(/assets/img/postCover/" + Eval("postCover") + ");background-position: center center; background-size: cover; background-repeat:no-repeat;" %>'></div>
                            <br />
                            <p class="slideShow pretitle"><%# DataBinder.Eval(Container.DataItem,"postPreContent") %></p>
                            <br />
                            <p><asp:HyperLink runat="server" ID="viewPost" NavigateUrl='<%# Eval("postID","PostPage.aspx?postID={0}") %>' Text="Xem bài viết..." CssClass="pretitle slideShow" Font-Underline="false"></asp:HyperLink></p>
                            <hr />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label runat="server" Visible="false" ID="NoRecentPost" Text="Ồ, xem ra bạn chưa có bài viết nào"></asp:Label>
                        </FooterTemplate>
                    </asp:Repeater>
                    <br /><br /><br />
                    <asp:Button runat="server" ID="loadMore"  CssClass="btn btn-block btn-primary btn-md slideShow" Text="Bài viết cũ hơn..." OnClick="loadMore_Click"/>
                </div>
                
                <div class="col-md-4">
                    <br />
                    <br />

                    <div class="well">
                        <h6>Có thể bạn biết những người này:</h6>
                        <div class="row" style="padding-left:10px;">
                            <div class="col-lg-6">
                                <asp:Repeater runat="server" ID="randomUser">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <img class="img-circle img-responsive menuAvatar" src='/assets/img/userAvatar/<%# DataBinder.Eval(Container.DataItem,"avatar") %>' alt='' />
                                                </td>
                                                <td>
                                                    <p style="padding-top:8px;padding-left:10px;"><asp:HyperLink runat="server" ID="anotherUser" Text='<%# DataBinder.Eval(Container.DataItem,"name") %>' NavigateUrl='<%# Eval("userName","User.aspx?user={0}") %>' ForeColor="Black" Font-Underline="false"></asp:HyperLink></p>
                                                </td>
                                            </tr>
                                        </table>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <div style="padding-left:10px;">
                                            <asp:LinkButton runat="server" ForeColor="Black" ID="myFriends" Text="Bạn bè" OnClick="myFriends_Click"></asp:LinkButton>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%} %>
        <script type="text/javascript">
            $(window).scroll(function () {
                //hàm animation hiện lên
                $(".slideShow").each(function () {
                    var pos = $(this).offset().top;

                    var winTop = $(window).scrollTop();
                    if (pos < winTop + 600) {
                        $(this).addClass("slider");
                    }
                });
            });
        </script>
    </form>
    <br /><br />
    <footer class="container-fluid text-center slideShow" style="font-family:Arial, Helvetica, sans-serif; height:110px;">
        <p style="margin-top:30px;">Copyright © <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Quân Đinh</a>, <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Toàn Thắng</a>, and <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Lam Sơn</a></p>
        <p>Powered by <a href="getbootstrap.com" style="text-decoration:none;color:#4800ff">Boostrap</a></p>
    </footer>
</body>
</html>

