<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="../common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>角色管理</title>
    
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ss }/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ss }/css/jquery.dataTables.min.css" /> 
<link rel="stylesheet" href="${ss }/css/matrix-style.css" />
<link rel="stylesheet" href="${ss }/css/matrix-media.css" />
<link rel="stylesheet" href="${ss }/css/metroStyle.css" type="text/css">
<link href="${ss }/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<meta name="_csrf" content="${_csrf.token}"/><meta name="_csrf_header" content="${_csrf.headerName}"/>

  </head>
  
  <body>
	
	<!--Header-part-->
	<div id="header">
	  <h1><a href="dashboard.html">Matrix Admin</a></h1>
	</div>
	<!--close-Header-part--> 
	
	<!--top-Header-menu-->
	<%@include file="../common/top.jsp"%>
	<%@include file="../common/menu.jsp"%>
	
	<div id="content">
	  <div id="content-header">
	    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Tables</a> </div>
	    <h1>Tables</h1>
	  </div>
	  <div class="container-fluid">
	    <hr>
	    <div class="row-fluid">
	      <div class="span12">
	        
	        <div class="widget-box">
	          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
	            <h5>角色列表</h5>
	          </div>
	          	<form class="form-inline">
	          	 <security:authorize buttonUrl="/role/addRole.do">
			          <button type="button" id="btn_search" onclick="$('#addRole').modal();" class="btn btn-info" style="float: right; margin-right: 1;">新增</button>
				</security:authorize>
				</form>
				<div class="widget-content nopadding">
	            <table class="table table-bordered data-table" id="datatable" >
	              <thead>
	              	<tr>
	                  <th>ID</th>
	                  <th>角色key</th>
	                  <th>角色名称</th>
                   	  <th>操作</th>
	                </tr>
	              </thead>
	            </table>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%--弹框--%>
			<div class="modal fade bs-example-modal-sm"  id="selectResources" tabindex="-1" role="dialog" aria-labelledby="selectRoleLabel">
			  <div class="modal-dialog modal-sm" role="document" style="height: 600px; "  >
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="selectRoleLabel">分配权限</h4>
			      </div>
			      <div class="modal-body">
			        <form id="boxRoleForm" >
			          <ul id="treeDemo" class="ztree"></ul>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" onclick="saveRoleResources();" class="btn btn-primary">Save</button>
			      </div>
			    </div>
			  </div>
			</div>
			<%----/弹框--%>
			
			
		<!--添加弹框-->
				<div class="modal fade" id="addRole" tabindex="-1" role="dialog" aria-labelledby="addroleLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="addroleLabel">添加角色</h4>
				      </div>
				      <div class="modal-body">
				        <form id="roleForm">
				          <div class="form-group">
				            <label for="recipient-name" class="control-label">角色名称:</label>
				            <input type="text" class="form-control" name="roleDesc" id="roleDesc" placeholder="请输入角色名称"/>
				          </div>
				          <div class="form-group">
				            <label for="recipient-name" class="control-label">角色key:</label>
				            <input type="text" class="form-control" id="roleKey" name="roleKey"  placeholder="请输入角色key">
				          </div>
				        </form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        <button type="button" onclick="addRole();" class="btn btn-primary">Save</button>
				      </div>
				    </div>
				  </div>
				</div>
			<!--/添加弹框-->
	
	
	
	<!--Footer-part-->
	<div class="row-fluid">
	  <div id="footer" class="span12"> 2017 &copy; yqj <a href="http://themedesigner.in/">Themedesigner.in</a> </div>
	</div>
	<!--end-Footer-part-->
	<script src="${ss }/js/jquery-1.11.2.min.js"></script> 
	<script src="${ss }/js/bootstrap.min.js"></script> 
	<script src="${ss }/js/jquery.dataTables.min.js"></script> 
	<script src="${ss }/js/layer.js"></script> 
 	<script type="text/javascript" src="${ss }/js/jquery.ztree.core.js"></script>
 	<script type="text/javascript" src="${ss }/js/jquery.ztree.excheck.js"></script>
	
	<script type="text/javascript">
	//_csrf参数设置
  	var header = $("meta[name='_csrf_header']").attr("content");  
     var token = $("meta[name='_csrf']").attr("content");  
     var table;
     $(document).ready(function() {
		table = $('#datatable').DataTable( {
				"dom": '<"top"i>rt<"bottom"flp><"clear">',
			  	 "searching" : false,
			  	"bJQueryUI": true,
				"sPaginationType": "full_numbers",
			  	"serverSide": true,//开启服务器模式，使用服务器端处理配置datatable
			  	"processing": true,//开启读取服务器数据时显示正在加载中……特别是大数据量的时候，开启此功能比较好
			  	
			  	"ajax": '${ss}/role/roleList.do', 
			  	"columns": [
		            { "data": "id" },
		            { "data": "roleKey" },
		            { "data": "roleDesc" },
		            {data: null}
		        ],
			columnDefs:[{
                targets: 3,
                render: function (data, type, row, meta) {
                    return '<p><security:authorize buttonUrl='/role/delRole.do'><a type="button" class="btn btn-danger  btn-default" href="javascrip:;" onclick=delById(' + row.id + ') >删除</a></security:authorize> '+
                    '<security:authorize buttonUrl='/role/saveRoleResources.do'><a type="button" class="btn btn-success btn-default" href="javascrip:;" onclick=allotResources(' + row.id + ') >分配权限</a></security:authorize></p>';
                }
            },
                { "orderable": false, "targets": 0 },
                { "orderable": false, "targets": 1 },
                { "orderable": false, "targets": 2 },
            ],
                
		    } );
			
			
			
	} );
	
	function search(){
		table.ajax.reload();
	}
	//弹出选择角色的框
	var roleId;
	function allotResources(rid){
		roleId = rid;  
		var setting = {
				check: {
					enable: true,
					chkboxType:  { "Y" : "p", "N" : "s" }
				},
				data: {
					simpleData: {
						enable: true,
						idKey: "id",
						pIdKey: "parentId",
					}
				}
			};
		
		$.ajax({
			async:false,
			type : "POST",
			data:{rid:rid},
			url: "${ss}/resources/resourcesListWithRole.do",
			dataType:'json',
			beforeSend: function(xhr){  
                xhr.setRequestHeader(header, token);  
            },
			success: function(data){
				
				$.fn.zTree.init($("#treeDemo"), setting, data);
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.expandAll(true); 
				$('#selectResources').modal();		
			  }
		    });   
		
	}
	
	//保存权限的选择
	function saveRoleResources() {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		checkNode= zTree.getCheckedNodes(true);
		var ids = new Array();
		for(var i=0;i<checkNode.length;i++){
			ids.push(checkNode[i].id);
		}
		$.ajax({
			async:false,
			type : "POST",
			data:{roleId:roleId,resourcesId:ids.join(",")},
			url: "${ss}/role/saveRoleResources.do",
			dataType:'json',
			beforeSend: function(xhr){  
                xhr.setRequestHeader(header, token);  
            },
			success: function(data){
				if(data=="success"){
					layer.msg('保存成功');
					 $('#selectResources').modal('hide');
				}else{
					layer.msg('保存失败');
					 $('#selectResources').modal('hide');
				}	
			  }
		    });   
	}
	//添加用户
	function addRole() {
		var roleKey = $("#roleKey").val();
		var roleDesc = $("#roleDesc").val();
		if(roleKey == "" || roleKey == undefined || roleKey == null){
			return layer.msg('角色key不能为空', function(){
				//关闭后的操作
			});
		}
		if(roleDesc == "" || roleDesc == undefined || roleDesc == null){
			return layer.msg('角色名称不能为空', function(){
				//关闭后的操作
			});
		}
		
		$.ajax({
			cache: true,
			type: "POST",
			url:'${ss}/role/addRole.do',
			data:$('#roleForm').serialize(),// 你的formid
			async: false,
			dataType:"json",
			beforeSend: function(xhr){  
                xhr.setRequestHeader(header, token);  
            },
		    success: function(data) {
		    	if(data=="success"){
					layer.msg('保存成功');
					table.ajax.reload();
					 $('#addRole').modal('hide');
				}else{
					layer.msg('保存失败');
					 $('#addRole').modal('hide');
				}
		    }
		});
	}
	
	
	function delById(id) {
		layer.confirm('您确定要删除该角色吗？', {
			  btn: ['确认','取消'] //按钮
			}, function(){
				$.ajax({
					cache: true,
					type: "POST",
					url:'${ss}/role/delRole.do',
					data:{id:id},
					async: false,
					dataType:"json",
					beforeSend: function(xhr){  
		                xhr.setRequestHeader(header, token);  
		            },
				    success: function(data) {
				    	if(data=="success"){
							layer.msg('删除成功');
							table.ajax.reload();
						}else{
							layer.msg('删除失败');
						}
				    }
				});
			});
		
		
	}
	</script>

  </body>
</html>
