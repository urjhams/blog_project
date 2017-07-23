<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUpPage.aspx.cs" Inherits="BTL_Blog.SignUpPage" %>

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
        body {
            background-image:url('/assets/img/bg.png');
            background-position: center top;
            background-size: cover;
            background-repeat:no-repeat;
        }
        #box {
            background:rgb(34,34,34);
            background:rgba(34, 34, 34, 0.75);
        }
        .customText {
            color:#fefefe;
            font-weight:normal;
            font-family:Arial, Helvetica, sans-serif;
        }
        .center {
            width: 40%;
            top: 25%;
            left: 50%;
            padding: 20px;
            margin-left:30%;
            margin-top:30px;
            margin-bottom:40px;
            border-radius:5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="box" class="center customText">
            <div class="text-center">
                <h2>BLOG</h2>
            </div>
            <div class="customText" style="padding-left:20px; padding-right:20px;">
                <div class="form-group">
                    <label>Tài khoản:</label>
                    <asp:TextBox runat="server" ID="userName" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mật Khẩu:</label>
                    <asp:TextBox runat="server" ID="pass" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Nhập lại mật Khẩu:</label>
                    <asp:TextBox runat="server" ID="passAgain" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Tên:</label>
                    <asp:TextBox runat="server" ID="name" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox runat="server" ID="email" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>
            </div>
            <div style="padding-right:20px; padding-left:20px; padding-top:20px;">
                <asp:Button runat="server" ID="signUp" Text="Đăng Ký" CssClass="btn btn-block btn-success" OnClick="signUp_Click"/>
            </div>
            <div style="padding-right:20px; padding-left:20px; padding-top:20px; padding-bottom:10px;">
                <asp:Button runat="server" ID="back" Text="Trở về" CssClass =" btn btn-block btn-default" OnClick="back_Click" />
            </div>
        </div>
    </form>
    <footer class="container-fluid text-center customText" style="font-family:Arial, Helvetica, sans-serif; height:110px;">
        <p style="margin-top:30px;">Copyright © <a href="#" style="color:antiquewhite;text-decoration:none">Quân Đinh</a>, <a href="#" style="color:antiquewhite;text-decoration:none">Toàn Thắng</a>, and <a href="#" style="color:antiquewhite;text-decoration:none">Lam Sơn</a></p>
        <p>Powered by <a href="getbootstrap.com" style="text-decoration:none;color:azure">Boostrap</a></p>
    </footer>
</body>
</html>
