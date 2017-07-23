<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="BTL_Blog.ErrorPage" %>

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
        .navbar {
  			margin-bottom: 0;
  			border: 0;
  			opacity: 0.7;
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
            background-color: #fff;
        }

         body {
            background-image:url('/assets/img/404-Not-Found.png');
            background-position: center top;
            background-size: cover;
            background-repeat:no-repeat;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar navbar-default navbar-fixed-top" style="display: block;color: rgb(0, 0, 0);">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"  data-target="#theNavBar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand"  href="HomePage.aspx"><span class="glyphicon glyphicon-chevron-left"></span> Blog</a>
                </div>
		    </div>
        </div>
    </form>
    <footer class="container-fluid text-center slideShow" style="font-family:Arial, Helvetica, sans-serif; height:110px; padding-top:500px">
        <p style="margin-top:30px;">Copyright © <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Quân Đinh</a>, <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Toàn Thắng</a>, and <a href="#" style="color:rgba(34, 34, 34, 0.75);text-decoration:none">Lam Sơn</a></p>
        <p>Powered by <a href="getbootstrap.com" style="text-decoration:none;color:#4800ff">Boostrap</a></p><br /><br />
    </footer>
</body>
</html>
