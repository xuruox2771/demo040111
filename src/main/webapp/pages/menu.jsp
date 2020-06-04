<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/28
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>共享平台管理中心</title>
	<link rel="stylesheet" href="../static/layui/css/layui.css">
	<script src="../static/layui/layui.js" charset="utf-8"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo">共享平台管理中心</div>
		<!-- 头部区域（可配合layui已有的水平导航） -->
		<ul class="layui-nav layui-layout-left">
			<li class="layui-nav-item"><a href="">控制台</a></li>
			<li class="layui-nav-item"><a href="">商品管理</a></li>
			<li class="layui-nav-item"><a href="">用户</a></li>
			<li class="layui-nav-item">
				<a href="javascript:;">其它系统</a>
				<dl class="layui-nav-child">
					<dd><a href="">邮件管理</a></dd>
					<dd><a href="">消息管理</a></dd>
					<dd><a href="">授权管理</a></dd>
				</dl>
			</li>
		</ul>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a href="javascript:;">
					<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
					贤心
				</a>
				<dl class="layui-nav-child">
					<dd><a href="">基本资料</a></dd>
					<dd><a href="">安全设置</a></dd>
				</dl>
			</li>
			<li class="layui-nav-item"><a href="">退了</a></li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<ul class="layui-nav layui-nav-tree"  lay-filter="test">
				<c:forEach var="i" step="1" begin="0" items="${sessionScope.list}">
				<li class="layui-nav-item">
					<a class="" href="#">${i.key}</a>
						<c:forEach var="j" step="1" begin="0" items="${i.value}">
						<dl class="layui-nav-child">
							<dd>
								<a href="<%=path%>/${j.menuUrl}" target="iframe_div_iframe">${j.menuName}</a>
							</dd>
						</dl>
						</c:forEach>
					</c:forEach>
			</ul>
		</div>
	</div>

	<div class="layui-body">
		<iframe id="iframe_div" style="width: 100%;height: 100%;" name="iframe_div_iframe" src="http://www.baidu.com" height="100%" width="100%" ></iframe>

	</div>

	<div class="layui-footer">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
<script src="../src/layui.js"></script>
<script>
	//JavaScript代码区域
	layui.use('element', function(){
		var element = layui.element;

	});
	function changePath(node) {
		var  divNode = document.getElementById("iframe_div");

		divNode.src = node.title;
	}
</script>


</body>
</html>
