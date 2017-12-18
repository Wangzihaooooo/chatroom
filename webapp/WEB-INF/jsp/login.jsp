<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/favicon.png">

    <title>登录界面</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />

    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href="../assets/img/favicon.png" />

    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

    <!-- CSS Files -->
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../assets/css/material-bootstrap-wizard.css" rel="stylesheet" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="../assets/css/demo.css" rel="stylesheet" />
    <!--   Core JS Files   -->
    <script src="../js/jquery-2.2.4.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../js/jquery.bootstrap.js" type="text/javascript"></script>

    <!--  Plugin for the Wizard -->
    <script src="../assets/js/material-bootstrap-wizard.js"></script>

    <!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
    <script src="../js/jquery.validate.min.js"></script>
</head>
<script>
    $(function(){
        $("#btn_login").click(function () {
            var uid = $("#username").val();
            var passwd = $("#password").val();
            var loginform=$("#loginform").serialize();
            if ("" === uid ) {
                alert("用户名不能为空");
                return;
            }else if("" === passwd){
                alert("密码不能为空");
                return;
            }
            $.ajax({
                type : "POST",
                url: "checklogin",
                async: false,
                data: loginform,
                success: function (result) {
                    if(result["status"]==="1"){
                        window.location.href = 'home'
                    }else {
                        alert(result["message"]);
                    }
                }
            });

            //$("#loginform").submit();

        });
    });

    function register() {
        window.location.href = 'register'
    }
</script>
<body>
<div class="image-container set-full-height" style="background-image: url('../assets/img/login_bg.jpg')">

    <!--  Made With Material Kit  -->
    <a class="made-with-mk">
        <div class="brand">WZ</div>
        <div class="made-with">Made with <strong>wangzi</strong></div>
    </a>

    <!--   Big container   -->
    <div class="container">
        <div class="row">
            <div class="col-sm-8 col-sm-offset-2">
                <!--      Wizard container        -->
                <div class="wizard-container">
                    <div class="card wizard-card" data-color="green" id="wizardProfile">
                        <form action="checklogin" method="post" id="loginform">
                            <!--        You can switch " data-color="purple" "  with one of the next bright colors: "green", "orange", "red", "blue"       -->
                            <div class="wizard-header">
                                <h3 class="wizard-title">
                                    请登录
                                </h3>
                                <h5>Please complete this information</h5>
                            </div>
                            <div class="wizard-navigation">
                                <ul >
                                    <li><a href="#about" data-toggle="tab">WELCOME   TO   HOME</a></li>
                                </ul>
                            </div>

                            <div class="tab-content">
                                <div class="tab-pane" id="about">
                                    <div class="row" style="padding: 50px 160px 0 170px">
                                        <div class="col-sm-12">
                                            <div class="input-group">
													<span class="input-group-addon">
														<i class="material-icons">account_circle</i>
													</span>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">请输入账户名 <small>(required)</small></label>
                                                    <input title="username" type="text" class="form-control" name="username" id="username"/>
                                                </div>
                                            </div>

                                            <div class="input-group">
													<span class="input-group-addon">
														<i class="material-icons">lock_outline</i>
													</span>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">请输入密码<small>(required)</small></label>
                                                    <input title="password" type="password" class="form-control" name="password" id="password"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="wizard-footer" style=" margin-top: -20px;margin-left: 30px">
                                <div class="pull-left" >
                                    <input type='button' class='btn btn-finish btn-fill btn-success btn-wd' name='btn_register' value='注册' onclick="register()" />
                                </div>
                                <div class="pull-right">
                                    <input type="button" class='btn btn-finish btn-fill btn-success btn-wd' name='btn_login' id='btn_login' value="登录"/>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </form>
                    </div>
                </div> <!-- wizard container -->
            </div>
        </div><!-- end row -->
    </div> <!--  big container -->
</div>
</body>
</html>
