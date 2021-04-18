<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><spring:message code="title.sample" /></title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/all.min.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/ui.jqgrid-bootstrap4.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/jquery-ui.min.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/jquery-ui.theme.min.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/jquery-ui.structure.min.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/jqgrid/css/ui.jqgrid.css'/>"/>
    
    <script src="<c:url value="/jqgrid/js/jquery-1.11.0.min.js" />"></script>
    <script src="<c:url value="/js/jquery-ui.min.js" />"></script>
    <script src="<c:url value="/jqgrid/js/i18n/grid.locale-kr.js" />"></script>
    <script src="<c:url value="/jqgrid/js/jquery.jqGrid.min.js" />"></script>
    <style>
    	header{
    		padding:20px 0;
    	}
    	.table-wrap{
    		margin:auto;
    		width:1000px;
    	}
    	#pageCustom{
    		margin-top:30px;
    	}
    	#pageCustom a{
    		margin:0 5px;
    		font-size:14px;
    	}
    </style>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	<header>
		<h1>게시판</h1>
	</header>
	<div class="table-wrap">
		<table id="list"></table>
		<div id="pager"></div>
		<div id="pageCustom"></div>
	</div>
	<script>
	var searchResultColNames =  ['ID','NAME', 'DESCRIPTION', 'useYn', 'regUser'];
	var searchResultColModel =  [
		{name:'id',       	index:'id',      	width: '15%', align:'center'},
	    {name:'name',       index:'name',       width: '15%', align:'center'},
	    {name:'description',index:'description',width: '40%', align:'center'},
	    {name:'useYn',      index:'useYn',      width: '10%', align:'center'},
	    {name:'regUser',    index:'regUser',    width: '20%', align:'center'},
	];
	

	
	
	
	<!-- 그리드 페이징 종료 -->
	
	$(function(){
		
		
		
		$("#list").jqGrid({
			url: "/grid.do",
			datatype: "json",
		   	colNames:searchResultColNames,
		   	colModel:searchResultColModel,
		    caption:"JSON Example",
            pager: "#pager",
            rowNum: 10,
            viewrecords: true,
            height:300,
            width: 1000,
            pgbuttons: true,
            pginput : true,
            shrinkToFit: true,
            sortable: false,
            loadonce: true,
            loadComplete: function(data){
            	$("#next_pager").html("<i class='fas fa-angle-right'></i>");
            	$("#last_pager").html("<i class='fas fa-angle-double-right'></i>");
            	$("#prev_pager").html("<i class='fas fa-angle-left'></i>");
            	$("#first_pager").html("<i class='fas fa-angle-double-left'></i>");
            }
            
		});
		
		
		
		
		
		
		
		
		
	});
		
	</script>
</body>
</html>
