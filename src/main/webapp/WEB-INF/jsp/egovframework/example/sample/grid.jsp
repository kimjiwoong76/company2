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
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/jquery-ui.min.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/jqgrid/css/ui.jqgrid.css'/>"/>
    
    <script src="<c:url value="/jqgrid/js/jquery-1.11.0.min.js" />"></script>
    <script src="<c:url value="/js/jquery-ui.min.js" />"></script>
    <script src="<c:url value="/jqgrid/js/jquery.jqGrid.min.js" />"></script>
    <script src="<c:url value="/jqgrid/js/i18n/grid.locale-kr.js" />"></script>
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
		<form:form commandName="searchVO" id="listForm" name="listForm" method="get">
		<input type="hidden" name="selectedId" />
		<div id="search" style="position:relative; z-index:999; right:20px;">
        		<ul>
        			<li>
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="1" label="카테고리명" />
        					<form:option value="0" label="설명" />
        				</form:select>
        			</li>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt" onkeypress="JavaScript:if(event.keyCode == 13){fn_egov_selectList();}"  />
                    </li>
        			<li>
        	            <span class="btn_blue_l">
        	                <a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
        	            </span>
        	        </li>
                </ul>
        	</div>
		<table id="list"></table>
		<div id="pager"></div>
		</form:form>
	</div>
	<script>

	
	/* 글 수정 function */
    function fn_egov_modify() {
    	
    	var formData = $("#listForm").serialize();
    	
    	$.ajax({
    		url: "/grid.do",
    		data: formData,
    		success : function(item){
    			var jqdata = {data:item};
    			$("#list").jqGrid("clearGridData", true);
    			$("#list").setGridParam(jqdata).trigger("reloadGrid");
    		}
    	});
    }
	
	
	
    /* 글 목록 화면 function */
    function fn_egov_selectList() {
    	
    	var formData = $("#listForm").serialize();
    	
    	$.ajax({
    		url: "/grid.do",
    		data: formData,
    		success : function(item){
    			var jqdata = {data:item};
    			$("#list").jqGrid("clearGridData", true);
    			$("#list").setGridParam(jqdata).trigger("reloadGrid");
    		}
    	});
    }
    
    /* 글 상세 화면 function */
    function fn_egov_select(id) {
    	document.listForm.selectedId.value = id;
       	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
       	document.listForm.submit();
    }
    /* 글 삭제 function */
    
    
	
	
	
	
	$(function(){
		var searchResultColNames =  ['수정/삭제', 'ID','NAME', 'DESCRIPTION', 'useYn', 'regUser'];
		var searchResultColModel =  [
			{ name:'myac', width: 70, fixed:true, sortable : false, formatter:'actions', formatoptions:{keys:true, delbutton:true}},
			{name:'id',       	index:'id',      	width: '15%', align:'center'},
		    {name:'name',       index:'name',       width: '15%', align:'center', editable : true},
		    {name:'description',index:'description',width: '40%', align:'center', editable : true},
		    {name:'useYn',      index:'useYn',      width: '10%', align:'center', editable : true,  edittype:'select', editoptions: {value:'Y:Y;N:N'}},
		    {name:'regUser',    index:'regUser',    width: '20%', align:'center', editable : true}
		];
		$("#list").jqGrid({
			url: "/grid3.do",
			datatype : "json",
			mtype: 'get',
		   	colNames:searchResultColNames,
		   	colModel:searchResultColModel,
		    caption:"JSON Example",
		    pager: "#pager",
            rowNum: 10,
            viewrecords: true, // 그리드가 보여줄 총 페이지 현재 페이지등의 정보를 노출 ex) 보기 1-10 / 33
            height:300,
            width: 1000,
            multiselect: true,
            editurl: "/oper.do", // 셀 수정 요청 보낼 컨트롤러
	        cellEdit:false,
            cellsubmit:'remote',
            cellurl:'/grid.do', // 셀이 수정된 후 이동할 url
            ondblClickRow: function(rowid, iRow, iCol){
            	console.log(rowid);
            	document.listForm.selectedId.value = rowid;
            	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
            	document.listForm.submit();
            },
//             loadComplete: function(data){
//             	$("#next_pager").html("<i class='fas fa-angle-right'></i>");
//             	$("#last_pager").html("<i class='fas fa-angle-double-right'></i>");
//             	$("#prev_pager").html("<i class='fas fa-angle-left'></i>");
//             	$("#first_pager").html("<i class='fas fa-angle-double-left'></i>");
//             },
            //그리드 수정시 submit 후
            afterSubmitCell : function(res) {    
                var aResult = $.parseJSON(res.responseText);
                var userMsg = "수정시 오류가 발생되었습니다.";
 				if((aResult.jqResult == "1")) {
					userMsg = "수정되었습니다.";
                    alert(userMsg);
                }
                return [(aResult.jqResult == "1") ? true : false, userMsg];
 			}
		}).navGrid('#pager', { edit: true, add: true, del: true,search : false},
			    //edit options
			    { url: '/updateSample.do' },
			    //add options
			    { url: '/addSample.do' },
			    //delete options
			    { url: '/deleteSample.do' }
			);
	}).trigger('reloadGrid');
		
	</script>
</body>
</html>
