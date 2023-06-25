<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="medesignsoft.signin" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AYUTTHAYA | Log in</title>
    <%--<link rel="shortcut icon" href="../../ayutthayaland/icon.ico" type="image/x-icon">--%>
    <link rel="icon" type="image/png" href="../../ayutthayaland/logo-ayl-icon.png" />

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="../../ayutthayaland/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../ayutthayaland/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="../../ayutthayaland/bower_components/Ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../ayutthayaland/dist/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="../../ayutthayaland/plugins/iCheck/square/blue.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <link href="https://fonts.googleapis.com/css?family=Athiti" rel="stylesheet">

    <style>
        .txtLabel {
            font-family: 'Athiti', sans-serif;
            font-size: 14px;
            font-weight: normal;
        }

        .txtHeader {
            font-family: 'Athiti', sans-serif;
            font-size: 18px;
            font-weight: bold;
        }

        .table-condensed {
            font-size: 12px;
        }

    </style>

    <style>
        .alert {
            height: 10%;
        }
    </style>
</head>
<body class="hold-transition login-page"  >
    <div class="login-box" >
        <div class="login-logo">
        </div>


        


        <!-- /.login-logo -->
        <div class="login-box-body">
           
            <p class="login-box-msg">
                <img src="../../ayutthayaland/image/logo-ayl.jpg" width="250" />
            </p>

             <%--<p class="login-box-msg" style="padding-top: 0px;">--%>
            <%--<span class="txtHeader">บริษัท อยุธยาแลนด์ 2016 จำกัด</span>--%>
                
        <%--</p>--%>

            <%--<p class="login-box-msg">Sign in to start your session</p>--%>

            <form id="frmLogin" runat="server">


                <div class="form-group has-feedback">
                    <input type="text" class="form-control txtLabel" id="inpUserName" name="UserName" runat="server" placeholder="Username" autocomplete="off">
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input type="password" class="form-control txtLabel" id="inpPassWord" name="PassWord" runat="server" placeholder="Password">
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <button type="button" id="btnHome" runat="server" class="btn btn-warning btn-block btn-flat hidden">Home</button>
                        <a href="#"  class="btn btn-warning btn-block btn-flat" > HOME</a>
                    </div>

                    <div class="col-xs-4">
                        <%--<a href="#" >Register</a>--%>
                    </div>
                    <!-- /.col -->
                    <div class="col-xs-4">
                        <button type="button" id="btnLogin" runat="server" onserverclick="btnLogin_click" class="btn btn-primary btn-block btn-flat">Sign In</button>
                    </div>
                    <!-- /.col -->

                    <%--<asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>--%>
                </div>
            </form>


        </div>
        <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->

    <!-- jQuery 3 -->
    <script src="../../ayutthayaland/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="../../ayutthayaland/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="../../ayutthayaland/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });
        });

        $("#inpPassWord").keypress(function (e) {
            if (e.which == 13) {
                //onSignIn();
                $('#btnLogin').click();
            }
        });

        function screenZoom() {
            var x = screen.width;
            if (x <= 1366) {
                //document.body.style.zoom = "80%"
                window.parent.document.body.style.zoom = 0.9;
                //myIframeZoom();             
            }
        };

        function myIframeZoom() {
            var x = document.getElementById("ifmBody");
            var y = (x.contentWindow || x.contentDocument);
            if (y.document) y = y.document;
            y.body.style.zoom = 0.9;
        };

    </script>
</body>
</html>
