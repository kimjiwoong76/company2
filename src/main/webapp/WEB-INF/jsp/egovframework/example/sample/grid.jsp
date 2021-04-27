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
		<div id="pageCustom"></div>
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
            loadComplete: function(data){
        		// 현재 표시 되고 있는 갯수를 가져옴('getGridParam', 'records')는 필수
        		var rowGrid = $("#list").jqGrid('getGridParam', 'records');
            	console.log(data);
              	initPage("list", rowGrid, "");
          	},
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
			    { url: '/gridDelete.do' }
			);
	}).trigger('reloadGrid');
	
	
	// 그리드 첫페이지로 이동
	function firstPage(){
		$("#list").jqGrid('setGridParam',{
			page:1
		}).trigger("reloadGrid");
	}
	
	// 그리드 이전 페이지로 이동
	function prePage(totalSize){
		var currentPage = $("#list").getGridParam('page');
		var pageCount = 10;
		
		currentPage-=pageCount;
		pageList = Math.ceil(currentPage/pageCount);
		currentPage = (pageList-1)*pageCount+pageCount;
		
		initPage("list", totalSize, currentPage);
		
		$("#list").jqGrid('setGridParam',{
			page:currentPage
		}).trigger("reloadGrid");
	}
	
	// 그리드 다음페이지 이동
	function nextPage(totalSize){
		var currentPage = $("#list").getGridParam('page');
		var pageCount = 10;
		
		currentPage+=pageCount;
		pageList = Math.ceil(currentPage/pageCount);
		currentPage = (pageList-1)*pageCount+1;
		initPage("list", totalSize, currentPage);
		
		$("#list").jqGrid('setGridParam',{
			page:currentPage
		}).trigger("reloadGrid");
	}
	
	// 마지막페이지로 이동
	function lastPage(totalSize){
		$("#list").jqGrid('setGridParam',{
			page:totalSize
		}).trigger("reloadGrid");
	}

<!-- 그리드 페이징 시작 -->
	function goPage(num){
		$("#list").jqGrid('setGridParam',{
			page:num
		}).trigger("reloadGrid");
	}
	// 페이징을 위한 함수
	// 변수로 그리드아이디, 총 데이터 수 , 현재 페이지 받음
	function initPage(gridId, totalSize, currentPage){
		
		if(currentPage == ""){
			var currentPage = $("#" + gridId).getGridParam('page');
			console.log("currentPage " + currentPage);
		}
		
		// 한 페이지에 보여줄 페이지 수 (ex 1 2 3 4 5)
		var pageCount= 10;
		
		// 그리드 데이터 전체의 페이지 수
		var totalPage = Math.ceil(totalSize/$("#"+gridId).getGridParam('rowNum'));
		
		// 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
		var totalPageList = Math.ceil(totalPage/pageCount);
		
		// 페이지 리스트가 몇번째 리스트인지
		var pageList = Math.ceil(currentPage/pageCount);
		
		// 페이지 리스트가 1보다 작으면 1로 초기화
		if(pageList<1) pageList=1;
		
		// 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
		if(pageList>totalPageList) pageList = totalPageList;
		
		// 시작 페이지
		var startPageList = ((pageList-1)*pageCount)+1;
		
		var endPageList = startPageList+pageCount-1;
		
		if(startPageList<1) startPageList=1;
		if(endPageList>totalPage) endPageList=totalPage;
		if(endPageList<1) endPageList=1;
		
		var pageInner = "";
		// 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
		for(var i=startPageList; i<=endPageList; i++){
			if(i==currentPage){
				pageInner = pageInner + "<a href='javascript:goPage("+(i)+")' id='"+(i)+"'><strong>"+(i)+"</strong></a>";
			} else {
				pageInner = pageInner + "<a href='javascript:goPage("+(i)+")' id='"+(i)+"'>"+(i)+"</a>";
			}
		}
		
		// 다음 페이지 리스트가 있을 경우
		if(totalPageList > pageList){
			pageInner += pageInner + "<a href='javascript:goPage("+totalSize+")'>&rt;</a>";
			pageInner += pageInner + "<a href='javascript:goPage("+totalPage+")'>&rt;&rt;</a>";
		}
		
		$("#pageCustom").html("");
		$("#pageCustom").append(pageInner);
		
	}
		
	</script>
</body>
</html>
