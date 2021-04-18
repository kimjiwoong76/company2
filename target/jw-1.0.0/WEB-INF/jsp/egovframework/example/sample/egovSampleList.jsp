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
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/jquery-ui.min.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/jqgrid/css/ui.jqgrid.css'/> "/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/jqgrid/css/ui.multiselect.css'/> "/>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
	    jQuery.browser = {};
	    (function () {
	         jQuery.browser.msie = false;
	         jQuery.browser.version = 0;
	         if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
	              jQuery.browser.msie = true;
	              jQuery.browser.version = RegExp.$1;
	         }
	    })();
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/i18n/grid.locale-en.js"></script>
	<script src="https://cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        
       
       
	    

        
        
        function splitFunction(value){
       		var arrSplitTrans = value.split(",");
           	return arrSplitTrans;	
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 수정 화면 function */
        function fn_egov_select(id) {
        	document.listForm.selectedId.value = id;
           	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addSample.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	fn_egov_link_page(1);
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        


        
        


        -->
    </script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
    <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
        <input type="hidden" name="selectedId" />
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="list.sample" /></li>
        		</ul>
        	</div>
        	<!-- // 타이틀 -->
        	<div id="search">
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
        	<!-- List -->
        	<div id="table">
        		<span style="font-size: 13px; padding-left: 5px;">(<c:out value='${paginationInfo.totalRecordCount}' />건)</span>

					<table id="jqgrid">
					</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        	</div>
        	<div id="sysbtn">
        	  <ul>
        	  	  <li>
        	          <span class="btn_blue_l">
        	              <a href="javascript:fn_ego_selct_delete();"><spring:message code="button.delete" /></a>
                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                      </span>
                  </li>
        	      <li>
        	          <span class="btn_blue_l">
        	              <a href="javascript:fn_egov_addView();"><spring:message code="button.create" /></a>
                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                      </span>
                  </li>
              </ul>
        	</div>
        </div>
        <input type="hidden" id="chkVal" name="chkVal" value="${param.chkVal}" />
        <input type="hidden" id="chkVal2" name="chkVal2" />
    </form:form>
    <script>
    
    
    <!--
    
    // 셀렉트 갯수가 체크박스 갯수에 따라 (전부체크하면) 전체선택 체크박스에 checked 표시
    function checkTest(){
    	
    	var inputCnt = $("input[name=selectItem]").length - 1;
    	var inputCntCheck = $("input[name=selectItem]:checked").length
		$("input[name=selectItem]:checked").each(function(index, item){
    		if(index >= inputCnt){
    			console.log("==== 실행 ====");
    			$("#selectAll").prop("checked", true);
    		} else {
    			$("#selectAll").prop("checked", false);
    		}
    	});
	}
    
    
    /* 전체 선택 checkbox 클릭 */
    
    // 전체 선택시 현재 체크된 것이 있다면 건너뛰고 값 담기
    function fn_ego_allCk(objCheck){
    	var all = document.getElementById("selectAll");
    	var checks = document.getElementsByName('selectItem');
    	console.log("objCheck 값 = " + objCheck);
    	for( var i = 0; i < checks.length; i++ ){
    		console.log("checks 값 = " + checks[i].checked);
    		if(checks[i].checked == objCheck){
    			continue;
    		}
	       checks[i].checked = objCheck;
	       checkboxArr(checks[i]);
    	}
    }
    
    // 페이지 불러올 시 hidden에 클래스 추가 배열에 담긴 값에 따른 check표시
    function checkIndex(){
    	if(!$("#chkVal").val()){
    		$("#chkVal").addClass("on");	
    	} else {
    		var chkArr = $("#chkVal").val();
        	chkArr = chkArr.split(',');
        	var chkCnt = chkArr.length;
        	for(var i=0; i<chkCnt; i++){
       		  $('input:checkbox[name=selectItem]').each(function(){
       		    if(this.value == chkArr[i]){
       		    	this.checked = true;
       		    }
       		  });
       		}
        	for(var i=0; i<chkArr.length; i++){
        		checkArr.push(chkArr[i]);	
        	}
    	}
    	checkTest();
    }
    
    // 가장 중요한 역활
    // checkbox 선택에 따른 기능 작성
    var checkArr = [];     // 배열 생성 및 초기화
    var hiddenItem = document.getElementById("chkVal");
    function checkboxArr(item) {
        var itemVal = item.value;
        var itemCheck = item.checked;
//         console.log("히든 선택값 : "+itemVal); 
//         console.log("선택여부 : "+itemCheck);
        // check true 
        if(itemCheck){ 
//         	console.log("check"); 
        	checkArr.push(itemVal);   
        	// check false 
        	
        } else {
        	checkArr.splice(checkArr.indexOf(itemVal), 1); // check value filter 배열내용 삭제
        	if(checkArr.length == 0){
        		checkArr = [];
        	}
    	}
        checkArr  = checkArr.filter(function(item) {
   		  return item !== null && item !== undefined && item !== '';
   		});
        console.log(checkArr);
        if($("#chkVal").hasClass("on")){
        	var chkData = $.trim($("#chkVal").val());
        	var checkArrMore = splitFunction(chkData);
    		for(let i=0; i<checkArrMore.length; i++){
        		checkArr.push(checkArrMore[i]);
        	}
    		$("#chkVal").removeClass("on");
    		hiddenItem.value = checkArr;
        }
        hiddenItem.value = checkArr;
    }
    
    
    /* 중복값 제거 함수  */
    function deleteArr(){
    	$('input:checkbox[name=selectItem]').each(function(){
    		checkArr.splice(checkArr.indexOf(this.value), 1); // check value filter 배열내용 삭제
        	if(checkArr.length == 0){
        		checkArr = [];
        	}
		});
    }
    
	/* 선택된 게시물을  삭제하기 */
    function fn_ego_selct_delete(){ //

    	var elements = checkArr;
    	var cnt = 0;
    	for(var i=0; i<elements.length; i++){
   			cnt++;
    	}
    	if(cnt > 0){
			let cf = confirm('정말로 삭제 하시겠습니까?');
			if(cf == true){
				hiddenItem.value = '';	
				document.listForm.chkVal2.value = elements;
				listForm.action = "<c:url value='/deleteSampleAll.do' />";
	       		listForm.submit();		
			}
    	} else {
   			alert('선택한 내용이 없습니다');
       		return false;	
    	}
    }    
	
	// checkbox 실행 제이쿼리 
	$(function(){
		$("input[name=selectItem]").on("change", function(){
			checkboxArr(this);
			checkTest();
		});
	});
	
	//최종 완료 버전
	
	$(function(){
// 		function makeTable(id, array){
// 		    var cnames = ['#', 'NAME', 'DESCRIPTION', 'USE_YN', 'REG_USER'];
// 		    console.log(jsListParse);
// 		    $("#"+id).jqGrid({
// 		    	url: '/egovSampleList.do',
// 		        datatype: "local",
// 		        colNames: cnames,
// 		        height: 380,
// 		        rowNum: 2,
// 		        rownumbers  : true,
// 		        rowList: [10,20,30],
// 		        colModel:[
// 	                {name:'id', index: 'id',  align:'right'},
// 	                {name:'name', index: 'name',  align:'right'},
// 	                {name:'description', index: 'description', align:'right'},
// 	                {name:'useYn', index: 'useYn',  align:'right'},
// 	                {name:'regUser', index: 'regData',  align:'right'}
// 	            ],
// 	            multiselect : true,
// 	            viewrecords : true,
	            
// 		        caption:"JQGRID TABLE"
// 		        });
// 		}
		
		var jsList = '${jsList}';
		var jsListParse = JSON.parse(jsList);
		console.log(jsListParse);
		
// 		makeTable('jqgrid', jsListParse);
		
		
		
		
	});
	$(function() {
		var searchResultColNames =  ['게시글관리번호', '번호', '제목', '작성자', '날짜', '조회수'];
	
		               
        $("#jqgrid").jqGrid({
        	datatype: 'local',
            height: 261,
            width: 1019,
            colNames: searchResultColNames,
            colModel:  [
            	{name:'bbsMgtNo',       index:'bbsMgtNo',      align:'center', hidden:true},
                {name:'bbsNum',         index:'bbsNum',        align:'left',   width:'12%'},
                {name:'bbsTitle',       index:'bbsTitle',      align:'center', width:'50%'},
                {name:'bbsWriter',      index:'bbsWriter',     align:'center', width:'14%'},
                {name:'bbsDate',        index:'bbsDate',       align:'center', width:'12%'},
                {name:'bbsHit',         index:'bbsHit',        align:'center', width:'12%'}
            ],
            
           
        });
    });
	

					-->
	</script>
</body>
</html>
