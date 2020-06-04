<%--
  Created by IntelliJ IDEA.
  User: MSI
  Date: 2020/3/25
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <title>欢迎注册账户</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/zui/1.9.1/css/zui.min.css">
    <link rel="stylesheet" href=<%=path+"/css/regPage.css"%>>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"> </script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"> </script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/zui/1.9.1/js/zui.min.js"></script>
<%--    <script type="text/javascript" src=<%=path+"/front/js/regPage.js"%>></script>--%>
    <script type="text/javascript">

        var msg=new $.zui.Messager('这是一个浮动消息。', {
            icon: 'bell', // 定义消息图标
            placement: 'center' // 定义显示位置
        });
        $(document).ready(function(){
            $("#gotoReg").click(function () {
                if (!validate()) {
                    return;
                }
                $.ajax({
                    url: "userControl/reg",
                    type: 'POST',
                    dataType: 'json',//预期服务器返回的数据类型text、json
                    data: {
                        loginName: $("#loginName").val(),
                        pwd: $("#pwd").val(),
                        trueName: $("#trueName").val()
                    },
                    success: function (data, textStatus, xhr) {
                        if (data.code == "00") {
                           alert("注册成功，即将跳转到登录界面");
                            window.location.href = "${pageContext.request.contextPath}/userlogin.jsp";
                        } else {
                            msg.show("注册失败");
                        }
                    },
                    beforeSend: function(){
                        $('#gotoReg').attr("disabled","disabled");

                    },
                    error: function (xhr, textStatus, errorThrown) {
                        alert("Ajax繁忙！")
                    },
                    complete: function () {
                        $('#gotoReg').removeAttr("disabled");
                    }
                });
            })});
        function validate() {
            return $("#formReg").validate({
                //把错误信息统一放在一个容器里面。
                errorLabelContainer: "#messageBox",
                //用什么标签再把上边的 errorELement 包起来。
                wrapper: "li",
                rules: {
                    loginName: {
                        required: true,
                        rangelength: [2, 8]
                    },
                    pwd: {
                        required: true,
                        rangelength: [2, 8]
                    },
                    trueName: {
                        required: true,
                        rangelength: [2, 8]
                    }
                },
                messages: {
                    loginName: {
                        required: "请输入用户名",
                        rangelength: "长度2到8个字符"
                    }, pwd: {
                        required: "请输入密码",
                        rangelength: "长度2到8个字符"
                    }, trueName: {
                        required: "请输入用户名",
                        rangelength: "长度2到8个字符"
                    }
                }
            }).form();
            // if(formReg.username.value.length==0) {
            //     alert("请输入用户名！");
            //     formReg.username.focus();
            //     return false;
            // }
            // if(formReg.password.value.length==0) {
            //     alert("请输入密码！");
            //     formReg.password.focus();
            //     return false;
            // }
            // if(formReg.phone.value.length==0) {
            //     alert("请输入手机号码！");
            //     formReg.phone.focus();
            //     return false;
            // }
            // if(formReg.repass.value.length==0) {
            //     alert("请再次输入密码！");
            //     formReg.repass.focus();
            //     return false;
            // }
            // if(formReg.repass.value != formReg.password.value) {
            //     alert("两次输入的密码必须一致！");
            //     formReg.repass.focus();
            //     return false;
            // }
            // return true;
        }
    </script>
</head>
<body>
<div id="main">
    <form action="" method="post" id="formReg" >
<%--    <form action="regServlet" method="post">--%>
        <h1>欢迎您注册网站会员，如果您已拥有账户，则可在此
            <a href=<%=path+"/front/jsp/LoginPage.jsp"%>>登录</a>
        </h1>
        <label for="loginName">&nbsp;&nbsp;&nbsp;&nbsp;账号：</label><input type="text" name="loginName" id="loginName"/><br />
        <label for="pwd">设置密码：</label><input type="password" name="pwd" id="pwd"/><br />
        <label for="repass">确认密码：</label><input type="password" name="repass" id="repass"/><br />
        <label for="trueName">&nbsp;&nbsp;用户名：</label><input type="text" name="trueName" id="trueName"/><br />
        <input type="button" id="gotoReg"  value="立即注册">
    </form>
</div>
<div id="messageBox"></div>
</body>
</html>
