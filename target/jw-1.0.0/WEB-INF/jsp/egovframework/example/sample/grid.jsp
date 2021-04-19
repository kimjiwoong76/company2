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
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/jqgrid/css/ui.jqgrid.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/jqgrid/css/ui.jqgrid-bootstrap-ui.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/jqgrid/css/ui.jqgrid-bootstrap.css'/>"/>
    <script src="<c:url value="/jqgrid/js/jquery-1.11.0.min.js" />"></script>
    <script src="<c:url value="/jqgrid/js/i18n/grid.locale-kr.js" />"></script>
    <script src="<c:url value="/jqgrid/js/jquery.jqGrid.min.js" />"></script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	<table id="list2"></table>
	<div id="pager2"></div>
	<script>
	var searchResultColNames =  ['NAME', 'DESCRIPTION', 'useYn', 'regUser', 'rNum'];
	var searchResultColModel =         
	                [{name:'id',       index:'id',      align:'center', hidden:true},
	                {name:'name',         index:'name',        align:'left',   width:'12%'},
	                {name:'description',       index:'description',      align:'center', width:'50%'},
	                {name:'useYn',      index:'regUser',     align:'center', width:'14%'},
	                {name:'rNum',        index:'rNum',       align:'center', width:'12%'}
	                ];
	$(function(){
		jQuery("#list2").jqGrid({
		   	colNames:searchResultColNames,
		   	colModel:searchResultColModel,
		    caption:"JSON Example",
		    height: 261,
            width: 1019
		});
		
		function searchData(mode) {
			 
	    
	        $("#list2").jqGrid({
	        	url : "/grid.do",
	            datatype : "JSON",
	            colNames: searchResultColNames,
	            colModel: searchResultColModel,
	            rowNum : 10,
	            height: 261,
	            width: 1019,
	            caption : "게시글 목록"
	        });
	    }

	});
		
	</script>
</body>
</html>
