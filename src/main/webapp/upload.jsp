<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/26
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Layui</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="static/layui/css/layui.css"  media="all">
	<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
	<legend>选完文件后不自动上传</legend>
</fieldset>

<div class="layui-upload">
	<button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button>
	<button type="button" class="layui-btn" id="test9">开始上传</button>
</div>

<script src="static/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
	layui.use('upload', function(){
		var $ = layui.jquery
			,upload = layui.upload;

		//选完文件后不自动上传
		upload.render({
			elem: '#test8'
			,url: 'https://httpbin.org/post' //改成您自己的上传接口
			,auto: false
			//,multiple: true
			,bindAction: '#test9'
			,done: function(res){
				layer.msg('上传成功');
				console.log(res)
			}
		});

	});
</script>

</body>
</html>
