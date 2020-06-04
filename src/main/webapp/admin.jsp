<%@ page import="com.cykj.demo.entity.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cykj.demo.entity.Admin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	Admin loginAdmin = (Admin) request.getSession().getAttribute("admin");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Layui</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="/demo040111/static/layui/css/layui.css" media="all">
	<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
<form class="layui-form" lay-filter="component-form-group" id="search_submits" onsubmit="return false" style="margin-top: 15px">
	<div class="layui-form layui-card-header layuiadmin-card-header-auto" lay-filter="layadmin-useradmin-formlist">

		<div class="layui-inline">
			<label class="layui-form-label">姓名：</label>
			<div class="layui-input-block">
				<input type="text" name="trueName" id="trueName" placeholder="请输入姓名" class="layui-input">
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">账号：</label>
			<div class="layui-input-block">
				<input type="text" name="adminName" id="adminName" placeholder="请输入账号" class="layui-input">
			</div>
		</div>
		<div class="layui-inline">
			<button class="layui-btn" lay-submit="search_submits" lay-filter="search">查询</button>
		</div>
	</div>
</form>
<table class="layui-hide" id="test" lay-filter="test"></table>

<%--添加管理员表单--%>
<form action="" method="" class="layui-form" style="display: none" id="regForm">
	<div class="layui-form-item">
		<label class="layui-form-label">名称</label>
		<div class="layui-input-inline">
			<input type="text" name="adminName" id="name" lay-verify="required" placeholder="请输入名字" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">账号</label>
		<div class="layui-input-inline">
			<input type="text" name="adminAccount" id="adminAccount" lay-verify="required" placeholder="请输入账号" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">密码</label>
		<div class="layui-input-inline">
			<input type="password" name="adminPassword" id="adminPassword" lay-verify="required" placeholder="请输入密码" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">确认密码</label>
		<div class="layui-input-inline">
			<input type="password" name="confirmPassword" lay-verify="required|confirmPassword" placeholder="请再次输入密码"
				   autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">角色</label>
		<div class="layui-input-inline">
			<select name="roleId" lay-verify="required" id="roleId">
				<option value=""></option>
				<option value="1">超级管理员</option>
				<option value="2">普通管理员</option>
				<option value="3">文档审核员</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit lay-filter="formDemo">确定</button>
			<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		</div>
	</div>
</form>

<%--表头工具栏--%>
<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="addNew">新增管理员</button>
	</div>
</script>


<%--<%--表格行内工具栏--%>
<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-xs" lay-event="edit">重置密码</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="/demo040111/static/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

<script>
	layui.use(['form','table','jquery'], function(){
		var table = layui.table;
		var form = layui.form;
		var $ = layui.jquery;
		var tableinf = table.render({
			elem: '#test'
			,url:'/demo040111/adminControl/userList'
			,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
			,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
				title: '提示'
				,layEvent: 'LAYTABLE_TIPS'
				,icon: 'layui-icon-tips'
			}]
			,title: '用户数据表'
			,cols: [[
				{type: 'checkbox', fixed: 'left'}
				,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
				,{field:'adminName', title:'用户名', width:120, edit: 'text'}
				,{field:'role.roleName', title:'管理员角色', width:120, edit: 'text'}
				,{field:'trueName', title:'姓名', width:200, edit: 'text', sort: true}
				,{field:'createTime', title:'注册时间', width:200}
				,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
			]]
			,page: true
		});

		//头工具栏事件
		table.on('toolbar(test)', function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'getCheckData':
					var data = checkStatus.data;
					layer.alert(JSON.stringify(data));
					break;
				case 'getCheckLength':
					var data = checkStatus.data;
					layer.msg('选中了：'+ data.length + ' 个');
					break;
				case 'isAll':
					layer.msg(checkStatus.isAll ? '全选': '未全选');
					break;
				//自定义头工具栏右侧图标 - 提示
				case 'LAYTABLE_TIPS':
					layer.alert('这是工具栏右侧自定义的一个图标按钮');
					break;
				case "addNew":
					layer.open({
						title: ['新增管理员', 'font-size:20px;'],
						type: 1,//基本层类型  类型：Number，默认：0  可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）。
						skin: 'layui-layer-rim', //样式名称  skin不仅允许你传入layer内置的样式class名，还可以传入您自定义的class名
						area: ['350px', '370px'], //宽高  类型：String/Array，默认：'auto'
						shadeClose: true,//点击其他地方关闭
						//类型：String/DOM/Array，默认：''
						content: $("#regForm"),
						cancel: function (index, layero) {
							layer.close(index)
						}
					});
					break;
			};
		});


		//监听行工具事件
		table.on('tool(test)', function(obj){
			var data = obj.data;
			//console.log(obj)
			//删除监听
			if(obj.event === 'del'){
				if (data.id == <%=loginAdmin.getId()%>){
					layer.msg("不能删除自己！")
				}else{
					layer.confirm('确定删除当前行吗？', function(index){
						$.ajax({
							url: "<%=path%>/adminControl/deleteAdmin/"+data.id,
							type: "POST",
							dataType: 'json',//预期服务器返回的数据类型text、json
							data: {},
							success: function (msg) {
								if (msg > 0) {
									layer.msg("新增成功！",{icon: 1})
									window.location.reload(true);
								} else {
									msg.show(data.message);
								}
							}
						});

						obj.del();
						layer.close(index);
					});
				}
			} else if(obj.event === 'edit'){
				layer.prompt({
					formType: 2
					,value: data.email
				}, function(value, index){
					obj.update({
						email: value
					});
					layer.close(index);
				});
			}
		});

		form.on('submit(search)',function (data) {
			var trueName = $("#trueName").val();
			var adminName = $("#adminName").val();
			var roleId = $("#roleId option:selected").val();
			tableinf.reload({
				url:'<%=path%>/adminControl/getAdminList',
				page: {
					curr: 1 //重新从第 1 页开始
				},
				where:{
					adminName:adminName, adminAccount:adminAccount,roleId:roleId
				}
			});

		});

		layui.use(['layer','form'],function () {
			var layer = layui.layer,
					form = layui.form;
			var $ = layui.jquery;
			form.verify({
				confirmPassword: function (value) {
					if ($('#adminPassword').val() !== value){
						return '两次密码输入不一致！';
					}
				}
			});

			form.on('submit(formDemo)',function (data) {
				$.ajax({
					url: "<%=path%>/adminControl/addAdmin",
					type: "POST",
					dataType: 'json',//预期服务器返回的数据类型text、json
					data: {
						adminName: $("#name").val(),
						adminAccount: $("#adminAccount").val(),
						adminPassword: $("#adminPassword").val(),
						roleId: $("#roleId option:selected").val()
					},
					success: function (data, textStatus, xhr) {
						if (data.code == "00") {
							layer.msg("新增成功！",{icon: 1})
							window.location.reload(true);
						} else {
							msg.show(data.message);
						}
					}
				});
				layer.close(layer.index);
				return false;
			});
		});
	});
</script>

</body>
</html>