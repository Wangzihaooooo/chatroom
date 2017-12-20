<%--
  Created by IntelliJ IDEA.
  User: wangzi
  Date: 2017/12/13
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!--jquery一定要放在bootstrap的js前面-->
    <script language="javascript" src="../js/jquery-1.11.3.min.js"></script>
    <script language="javascript" src="../js/bootstrap.min.js"></script>
    <style type="text/css">
        * {
            box-sizing: border-box;
        }

        body {
            background-color: #edeff2;
            font-family: "Calibri", "Roboto", sans-serif;
        }

        .chat_window {
            position: absolute;
            width: calc(100% - 20px);
            max-width: 800px;
            height: 500px;
            border-radius: 10px;
            background-color: #fff;
            left: 50%;
            top: 50%;
            transform: translateX(-50%) translateY(-50%);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        .top_menu {
            background-color: #fff;
            width: 100%;
            padding: 20px 0 15px;
            box-shadow: 0 1px 30px rgba(0, 0, 0, 0.1);
        }
        .top_menu .buttons {
            margin: 3px 0 0 20px;
            position: absolute;
        }
        .top_menu .buttons .button {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 10px;
            position: relative;
        }
        .top_menu .buttons .button.close {
            background-color: #f5886e;
        }
        .top_menu .buttons .button.minimize {
            background-color: #fdbf68;
        }
        .top_menu .buttons .button.maximize {
            background-color: #a3d063;
        }
        .top_menu .title {
            text-align: center;
            color: #bcbdc0;
            font-size: 20px;
        }

        .messages {
            position: relative;
            list-style: none;
            padding: 20px 10px 0 10px;
            margin-left: 200px;
            height: 347px;
            overflow: scroll;
        }
        .messages .message {
            clear: both;
            overflow: hidden;
            margin-bottom: 20px;
            transition: all 0.5s linear;
            opacity: 0;
        }
        .messages .message.left .avatar {
            background-color: #f5886e;
            float: left;
        }
        .messages .message.left .text_wrapper {
            background-color: #ffe6cb;
            margin-left: 20px;
        }
        .messages .message.left .text_wrapper::after, .messages .message.left .text_wrapper::before {
            right: 100%;
            border-right-color: #ffe6cb;
        }
        .messages .message.left .text {
            color: #c48843;
        }
        .messages .message.right .avatar {
            background-color: #fdbf68;
            float: right;
        }
        .messages .message.right .text_wrapper {
            background-color: #c7eafc;
            margin-right: 20px;
            float: right;
        }
        .messages .message.right .text_wrapper::after, .messages .message.right .text_wrapper::before {
            left: 100%;
            border-left-color: #c7eafc;
        }
        .messages .message.right .text {
            color: #45829b;
        }
        .messages .message.appeared {
            opacity: 1;
        }
        .messages .message .avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: inline-block;
        }
        .messages .message .text_wrapper {
            display: inline-block;
            padding: 20px;
            border-radius: 6px;
            width: calc(100% - 85px);
            min-width: 100px;
            position: relative;
        }
        .messages .message .text_wrapper::after, .messages .message .text_wrapper:before {
            top: 18px;
            border: solid transparent;
            content: " ";
            height: 0;
            width: 0;
            position: absolute;
            pointer-events: none;
        }
        .messages .message .text_wrapper::after {
            border-width: 13px;
            margin-top: 0;
        }
        .messages .message .text_wrapper::before {
            border-width: 15px;
            margin-top: -2px;
        }
        .messages .message .text_wrapper .text {
            font-size: 18px;
            font-weight: 300;
        }

        .bottom_wrapper {
            position: relative;
            width: 100%;
            background-color: #fff;
            padding: 0 10px;
            bottom: 0;
        }
        .bottom_wrapper .message_input_wrapper {
            display: inline-block;
            height: 50px;
            border-radius: 25px;
            border: 1px solid #bcbdc0;
            width: calc(100% - 160px);
            position: relative;
            padding: 0 20px;
        }
        .bottom_wrapper .message_input_wrapper .message_input {
            border: none;
            height: 100%;
            box-sizing: border-box;
            width: calc(100% - 40px);
            position: absolute;
            outline-width: 0;
            color: gray;
        }
        .bottom_wrapper .send_message {
            width: 140px;
            height: 50px;
            display: inline-block;
            border-radius: 50px;
            background-color: #a3d063;
            border: 2px solid #a3d063;
            color: #fff;
            cursor: pointer;
            transition: all 0.2s linear;
            text-align: center;
            float: right;
        }
        .bottom_wrapper .send_message:hover {
            color: #a3d063;
            background-color: #fff;
        }
        .bottom_wrapper .send_message .text {
            font-size: 18px;
            font-weight: 300;
            display: inline-block;
            line-height: 48px;
        }
        .member_list {
            height: 345px;
            overflow-x: hidden;
            overflow-y: auto;
        }
        .member_list .chat-body {
            margin-left: 47px;
            margin-top: 0;
        }
        .member_list .contact_sec {
            margin-top: 3px;
        }
        .member_list li {
            padding: 6px;
        }
        .member_list ul {
            border: 1px solid #dddddd;
        }
        .chat-img img {
            height: 34px;
            width: 34px;
        }
        .member_list li {
            border-bottom: 1px solid #dddddd;
            padding: 6px;
        }
        .member_list li:last-child {
            border-bottom:none;
        }
        .new_message_head button {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            border: medium none;
        }
        .chat_area li {
            padding: 14px 14px 0;
        }
        .chat_area li .chat-img1 img {
            height: 40px;
            width: 40px;
        }
        .chat_area .chat-body1 {
            margin-left: 50px;
        }
        .chat-body1 p {
            background: #fbf9fa none repeat scroll 0 0;
            padding: 10px;
        }
        .chat_area .admin_chat .chat-body1 {
            margin-left: 0;
            margin-right: 50px;
        }
        .chat_area li:last-child {
            padding-bottom: 10px;
        }
        .message_write textarea.form-control {
            height: 70px;
            padding: 10px;
        }

        .sub_menu_ > li a, .sub_menu_ > li {
            float: left;
            width:100%;
        }
        .member_list li:hover {
            background: #428bca none repeat scroll 0 0;
            color: #fff;
            cursor:pointer;
        }

    </style>
    <script language="JavaScript">
        (function () {
            var Message;
            var userList;
            Message = function (arg) {
                this.text = arg.text;
                this.username=arg.username;
                this.image=arg.image;
                this.message_side = arg.message_side;
                this.draw = function (_this) {
                    return function () {
                        var $message;
                        $message = $($('.message_template').clone().html());
                        $message.addClass(_this.message_side).find('.text').html(_this.text);
                        if(_this.image!=="") {
                            $message.find('.img-circle').attr("src",_this.image);
                        }
                        $message.find('#message_username').html(_this.username);
                        $('.messages').append($message);
                        return setTimeout(function () {
                            return $message.addClass('appeared');
                        }, 0);
                    };
                }(this);
                return this;
            };
            $(function () {
                var getMessageText, message_side, sendMessage;
                getMessageText = function () {
                    var $message_input;
                    $message_input = $('.message_input');
                    return $message_input.val();
                };
                sendMessage = function (text,username,image,message_side) {
                    var $messages, message;
                    if (text.trim() === '') {
                        return;
                    }
                    $messages = $('.messages');
                    message = new Message({
                        text: text,
                        username:username,
                        image:image,
                        message_side: message_side
                    });
                    message.draw();
                    return $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 0);
                };
                $('.send_message').click(function (e) {
                    var message = $("#message_input").val();
                    var list_username=$("#chat_title").text();
                    var to = list_username.trim() === "全体成员"? "": list_username;
                    ws.send(JSON.stringify({
                        message : {
                            content : message,//输入框的内容
                            from : '${user.username}',//'{user.getUsername()}',//登录成功后保存在Session.attribute中的username
                            to : to      //接收人,如果没有则置空,如果有多个接收人则用,分隔
                        },
                        type : "message"
                    }));
                    $('.message_input').val('');
                });
                $('.message_input').keyup(function (e) {
                    if (e.which === 13) {
                        $('.send_message').trigger("click");
                    }
                });
            });
            var imgData =null;   //base64类型的图片数据
            var ws = null;
            //判断当前浏览器是否支持WebSocket
            if ('WebSocket' in window) {
                ws = new WebSocket("ws://" + location.host+"${pageContext.request.contextPath}" + "/chatcontroller");
            } else {
                alert("对不起！你的浏览器不支持webSocket")
            }

            //连接成功建立的回调方法
            ws.onopen = function (event) {
                setMessageInnerHTML("系统消息：加入连接");
            };
            ws.onmessage = function (evt) {
                analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
            };
            //连接关闭的回调方法
            ws.onclose = function () {
                setMessageInnerHTML("系统消息：断开连接");
            };
            //连接发生错误的回调方法
            ws.onerror = function () {
                setMessageInnerHTML("系统消息：error");
            };

            /**
             *监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，
             *防止连接还没断开就关闭窗口，server端会抛异常。
             */
            window.onbeforeunload = function () {
                var is = confirm("确定关闭窗口？");
                if (is){
                    ws.close();
                }
            };
            //关闭连接
            function closeWebSocket() {
                ws.close();
            }

            /**
             * 检查连接
             */
            function checkConnection(){
                if(ws !== null){
                    alert(ws.readyState === 0? "连接异常":"连接正常", { offset: 0});
                }else{
                    alert("连接未开启!", { offset: 0, shift: 6 });
                }
            }

            function analysisMessage(message){
                message = JSON.parse(message);
                if(message.type === "message"){      //会话消息
                    showChat(message.message);
                }
                if(message.type === "record"){      //会话消息
                    showRecord(message.recordList);
                }
                if(message.type === "image"){        //图片消息
                    showImage(message.message);
                }
                if(message.userList !== null && message.userList !== undefined){      //在线列表
                    userList=message.userList;
                    showOnline(message.userList);
                }
            }

            /**
             * 展示会话信息
             */
            function showChat(message){
                var message_side='right';
                var message_user_image='${user.image}';
                var message_to=message.to.trim();
                if(message.to.trim()===""){
                    message_to="全体成员"
                }
                if(message.from.trim()==='${user.username}'.trim()){
                    $messages = $('.messages');
                    _message = new Message({
                        text: message.content,
                        username:'${user.username}',
                        image:message_user_image,
                        message_side: message_side
                    });
                    _message.draw();
                    $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 0);
                }else if($('#chat_title').text().trim()===message_to){
                    message_side='left';
                    $.each(userList,function(i,item){
                        if(message.from.trim()===item.username) {
                            message_user_image=item.image;
                        }
                    });
                    $messages = $('.messages');
                    _message = new Message({
                        text: message.content,
                        username:'${user.username}',
                        image:message_user_image,
                        message_side: message_side
                    });
                    _message.draw();
                    $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 0);
                }

                }

                function showRecord(message){
                    var message_side;
                    var message_user_image;
                    $('.messages').empty();
                    $.each(message,function(i,item){
                        if(item.sender=== '${user.username}'){
                            message_side='right';
                        }else {
                            message_side='left';
                        }

                        var $messages, _message;
                        if (item.text.trim() === '') {
                            return;
                        }
                        $.each(userList,function(i1,item1){
                            if(item.sender===item1.username) {
                                message_user_image=item1.image;
                            }
                        });

                        $messages = $('.messages');
                        _message = new Message({
                            text: item.text,
                            username:item.sender,
                            image:message_user_image,
                            message_side:  message_side
                        });
                        _message.draw();
                        $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 0);
                    });
                }
                /**
                 * 展示在线列表
                 */
                function showOnline(list){
                    $(".list-unstyled").html("");    //清空在线列表
                    $.each(list, function(index, item){     //添加私聊按钮
                        var li ="";
                        var image=item.image;
                        var username=item.username;
                        if(username==="全体成员"){
                            image="../img/all.png"
                        }
                        if('${user.username}'!==item.username){    //排除自己
                            li = "<li class=\"left clearfix\" >\n" +
                                " <span class=\"chat-img pull-left\">\n" +
                                " <img src="+'"'+image+'"'+" alt=\"User Avatar\" class=\"img-circle\"></span>\n" +
                                " <div class=\"chat-body clearfix\">\n" +
                                " <div class=\"header_sec\">\n" +
                                " <strong class=\"primary-font\" >"+username+
                                " </strong> <strong class=\"pull-right\">09:45</strong></div>\n" +
                                " <div class=\"contact_sec\">\n" +
                                " <span class=\"primary-font\" style=\"font-weight: normal\"></span></div></div></li>";
                        }
                        $(".list-unstyled").append(li);
                    });
                    $('.member_list .list-unstyled li').on('click',function(){
                        $("#message_input").removeAttr("readonly");
                        $("#message_input").removeAttr("placeholder");
                        var list_username=$(this).find('.primary-font').text();
                        var to = list_username.trim() === "全体成员"? "": list_username;
                        $("#chat_title").text(list_username);
                        ws.send(JSON.stringify({
                            message : {
                                content : "",//输入框的内容
                                from : '${user.username}',//'{user.getUsername()}',//登录成功后保存在Session.attribute中的username
                                to : to      //接收人,如果没有则置空,如果有多个接收人则用,分隔
                            },
                            type : "record"
                        }));
                    });
                }

                /**
                 * 添加接收人
                 */
                function addChat(user){
                    var sendto = $("#sendto");
                    var receive = sendto.text().trim() == "全体成员" ? "" : sendto.text() + ",";
                    if(receive.indexOf(user) == -1){    //排除重复
                        sendto.text(receive + user);
                    }
                }

                /**
                 * 发送系统消息
                 * @param innerHTML
                 */
                function setMessageInnerHTML(innerHTML) {
                    $("#sys_notice").append(innerHTML+"<br/>")
                };
                function uploadImage() {

                    var img = document.getElementById('img')
                        , imgShow = document.getElementById('imgShow')
                        , message = document.getElementById('message')
                    var imgFile = new FileReader();
                    imgFile.readAsDataURL(img.files[0]);
                    imgFile.onload = function () {
                        imgData = this.result; //base64数据
                        imgShow.setAttribute('src', imgData);
                    }
                }

            }.call(this));


    </script>
</head>
<body>
<div class="chat_window">
    <div class="top_menu">
        <div class="buttons">
            <div class="button close"></div>
            <div class="button minimize"></div>
            <div class="button maximize"></div>
        </div>
        <div class="title">
            <strong style="margin-left: 120px" id="chat_title">Chat</strong>
            <span id="sys_notice"  class="title" style="font-size: 12px;margin-top:5px;margin-right: 10px;float:right "></span>
        </div>
    </div>
    <div class="col-sm-3 chat_sidebar">
        <div class="row">
            <div class="member_list">
                <ul class="list-unstyled">

                </ul>
            </div>
        </div>
    </div>
    <ul class="messages"></ul>
    <div class="bottom_wrapper clearfix">
        <div class="message_input_wrapper">
            <input class="message_input" id="message_input"  readonly = "readonly" placeholder="choose friend you would chat in the left userList..." />
        </div>
        <div class="send_message">
            <div class="icon"></div>
            <div class="text">Send</div>
        </div>
    </div>
    <div class="message_template">
        <li class="message">
            <div class="avatar"><img  style="max-width:100%;height:100%;object-fit:cover;" class="img-circle"/></div>
            <div class="text_wrapper">
                <span id="message_username"></span>
                <div class="text" id="chat_text"></div>
            </div>
        </li>
    </div>
</div>
</body>
</html>
