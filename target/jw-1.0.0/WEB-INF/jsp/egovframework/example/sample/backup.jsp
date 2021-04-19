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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        
        
        function checkIndex(){
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
        }
        
        var checkArr = [];     // 배열 생성 및 초기화
        function checkboxArr() {
        	var inputCheck = $("input[name='selectItem']");
        	var chkData = $.trim($("#chkVal").val()); // hidden chkVal에 값 저장
            $("input[name='selectItem']").each(function() { // input selectItem 중 선택된 checkbox checkArr 담기
            	var val = $(this).val();
            	if(this.checked){
            		checkArr.push(val);     // 체크된 것만 값을 뽑아서 배열에 push
            		console.log("if 내체크 시 배열 값 " + checkArr);
                } else {
                	checkArr.splice(checkArr.indexOf(val), 1);
                }
            	console.log("배열값 체크" + checkArr);
            	$("#chkVal").val(checkArr);
            });
            if(chkData){   // hidden chkVal 에 값이 있다면
            	
        		var checkArrMore = splitFunction(chkData);
        		for(let i=0; i<checkArrMore.length; i++){
            		checkArr.push(checkArrMore[i]);
            	}
        		$("#chkVal").val(checkArr);
        	}
            
        }
        

        
        
        
        function splitFunction(value){
       		var arrSplitTrans = value.split(",");
           	return arrSplitTrans;	
        }
        
        $(function(){
        	$("input:checkbox[name='selectItem']").change(function(){
            	checkboxArr();
            });
        	
        });
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.searchKeyword.value = '';
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
        	if(document.listForm.searchKeyword.value != ''){
        		document.listForm.pageIndex.value = 1;	
        	}
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        /* 전체 선택 checkbox 클릭 */
        function fn_ego_allCk(objCheck){
	    	var checks = document.getElementsByName('selectItem');
	    	for( var i = 0; i < checks.length; i++ ){
		       checks[i].checked = objCheck;
	    	}
	    	checkboxArr();
        }
		/* 선택된 게시물을  삭제하기 */
        function fn_ego_selct_delete(){ //
			var elements = document.getElementsByName('selectItem');
        	var cnt = 0;
        	console.log(elements);
        	for(var i=0; i<elements.length; i++){
        		if(elements[i].checked == true){
        			cnt++;
        			console.log(cnt);
        		}
        	}
        	if(cnt > 0){
				let cf = confirm('정말로 삭제 하시겠습니까?');
				if(cf == true){
					listForm.action = "<c:url value='/deleteSampleAll.do' />";
		       		listForm.submit();		
				}
        	} else {
        		alert('선택한 내용이 없습니다');
        		return false;
        	}
        }         

        -->
    </script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;" onload="checkIndex();">
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
        					<form:option value="1" label="Name" />
        					<form:option value="0" label="ID" />
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
        		<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="40" />
        				<col width="40"/>
        				<col width="100"/>
        				<col width="250"/>
        				<col width="80"/>
        				<col width="?"/>
        				<col width="60"/>
        			</colgroup>
        			<tr>
        				<th align="center">선택  <input type="checkbox" name="selectAll" id="selectAll" onclick="fn_ego_allCk(this.checked)" /></th>
        				<th align="center">No</th>
        				<th align="center"><spring:message code="title.sample.id" /></th>
        				<th align="center"><spring:message code="title.sample.name" /></th>
        				<th align="center"><spring:message code="title.sample.useYn" /></th>
        				<th align="center"><spring:message code="title.sample.description" /></th>
        				<th align="center"><spring:message code="title.sample.regUser" /></th>
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<td align="center" class="listtd" style="vertical-align:middle;">
            					<input type="checkbox" name="selectItem" value="<c:out value="${result.id}"/>" />
            				</td>
							<td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((paginationInfo.currentPageNo-1) * searchVO.pageSize + status.count)}"/></td>
            				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.id}"/>')"><c:out value="${result.id}"/></a></td>
            				<td align="left" class="listtd"><c:out value="${result.name}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.useYn}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.description}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.regUser}"/>&nbsp;</td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        		<c:choose>
        			<c:when test="${paginationInfo.totalRecordCount == 0 }">
     					<p>검색 결과가 없습니다.</p>
     				</c:when>
     				<c:otherwise>
		        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
		        		<form:hidden path="pageIndex" />
	        		</c:otherwise>
        		</c:choose>
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
        <input type="text" id="chkVal" name="chkVal" value="${param.chkVal}" />
    </form:form>
</body>
</html>
