<%--
  Created by IntelliJ IDEA.
  User: wangzi
  Date: 2017/12/13
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/favicon.png">

    <title>注册界面</title>

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
    <script src="../js/ajaxfileupload.js"></script>

    <!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
    <script src="../js/jquery.validate.min.js"></script>
    <script>
        $(function(){
            $("#finish").click(function () {
                var $valid = $('.wizard-card form').valid();

                var uid = $("#username").val();
                if ("" === uid ) {
                    alert("用户名不能为空");
                    return false;
                }
                var passwd = $("#password").val();
                if("" === passwd){
                    alert("密码不能为空");
                    return false;
                }
                if($("#password-concern").val()!==passwd){
                    alert("密码两次不一致");
                    return false;
                }

                var registerform=$("#registerform").serialize();
                $.ajax({
                    type : "POST",
                    url: "checkregister",
                    async: false,
                    data: registerform,
                    success: function (result) {
                        if(result["status"]==="1"){
                            window.location.href = 'home'
                        }else {
                            alert(result["message"]);
                        }
                    }
                })
                $.ajaxFileUpload({
                    url : "upload",
                    secureuri : false,
                    async:false,
                    fileElementId : "wizard-picture",
                    enctype:'multipart/form-data',//注意一定要有该参数
                    success : function(data) {
                    },
                    error : function(data) {
                        //上传失败
                    }
                });
            });
            function ajaxFileUpload() {

            }
        });
    </script>
</head>

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
                        <form action="register" method="post" id="registerform" enctype="multipart/form-data">
                            <!--        You can switch " data-color="purple" "  with one of the next bright colors: "green", "orange", "red", "blue"       -->
                            <div class="wizard-header">
                                <h3 class="wizard-title">
                                    请注册
                                </h3>
                                <h5>This information will let us know more about you.</h5>
                            </div>
                            <div class="wizard-navigation">
                                <ul>
                                    <li><a href="#about" data-toggle="tab">ACCOUT</a></li>

                                    <li><a href="#address" data-toggle="tab">INFORMATION</a></li>
                                </ul>
                            </div>

                            <div class="tab-content">
                                <div class="tab-pane" id="about">
                                    <div class="row">
                                        <h4 class="info-text"> Let's start with the basic information</h4>
                                            <div class="col-sm-4 col-sm-offset-1" style="padding-top: 55px;">
                                                <div class="picture-container">
                                                    <div class="picture">
                                                        <img src="../assets/img/default-avatar.png" class="picture-src" id="wizardPicturePreview" title=""/>
                                                        <input  name="file" type="file" id="wizard-picture" onchange="ajaxFileUpload();"/>
                                                    </div>
                                                    <h6>请选择头像</h6>
                                                </div>
                                            </div>
                                        <div class="col-sm-6">
                                            <div class="input-group">
													<span class="input-group-addon">
														<i class="material-icons">face</i>
													</span>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">请输入账户名 <small>(required)</small></label>
                                                    <input name="username" id="username" type="text" class="form-control">
                                                </div>
                                            </div>

                                            <div class="input-group">
													<span class="input-group-addon">
														<i class="material-icons">record_voice_over</i>
													</span>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">请输入密码<small>(required)</small></label>
                                                    <input name="password" id="password" type="text" class="form-control">
                                                </div>
                                            </div>

                                            <div class="input-group">
													<span class="input-group-addon">
														<i class="material-icons">record_voice_over</i>
													</span>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">请再次输入密码<small>(required)</small></label>
                                                    <input name="password-concern" id="password-concern" type="text" class="form-control">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="tab-pane" id="address">
                                    <div class="row" style="padding-left: 170px; padding-right: 170px;">
                                        <div class="col-sm-12" style="margin-bottom: 0px;">
                                            <h4 class="info-text"> 请完善你的个人信息 </h4>
                                        </div>
                                        <div class="col-sm-12" style="padding-top: 0px;">
                                            <div class="form-group label-floating">
                                                <label class="control-label">性別</label>
                                                <select name="sex" class="form-control" id="sex">
                                                    <option value="男"> 男 </option>
                                                    <option value="女"> 女 </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="form-group label-floating">
                                                <label class="control-label">年龄</label>
                                                <input type="text" class="form-control" name="age" id="age">
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="form-group label-floating">
                                                <label class="control-label">手机号码</label>
                                                <input type="text" class="form-control" name="phone" id="phone">
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="wizard-footer">
                                <div class="pull-right">
                                    <input type='button' class='btn btn-next btn-fill btn-success btn-wd' id="next" name='next' value='Next' />
                                    <input type='button' class='btn btn-finish btn-fill btn-success btn-wd' id='finish' name='finish' value='Finish' />
                                </div>

                                <div class="pull-left">
                                    <input type='button' class='btn btn-previous btn-fill btn-default btn-wd' name='previous' value='Previous' />
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

