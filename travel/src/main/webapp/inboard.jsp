<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>국내 게시판</title>

<!-- 부트스트랩 사용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script type="text/javascript" src="./js/menu.js"></script>
</head>
<body>
	<header>
	<%@ include file="menu.jsp" %>
	</header>
   <article>
	   <h1>국내 여행 게시판</h1>
      <div class="btn-group" role="group" aria-label="Basic outlined example">
		<button type="button" class="btn btn-outline-primary" onclick="url('./inboard?write=0')">전체</button>
		<button type="button" class="btn btn-outline-primary" onclick="url('./inboard?write=0&category=공지사항')">공지사항</button>
		<button type="button" class="btn btn-outline-primary" onclick="url('./inboard?write=0&category=여행정보')">여행정보</button>
		<button type="button" class="btn btn-outline-primary" onclick="url('./inboard?write=0&category=잡담')">잡담</button>
		</div><br>
         <div>
            <div>
               <table class="table table-hover">
                  <thead>
    	    		<tr class="table-info">
        	        	<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">글쓴이</th>
						<th scope="col">등록일</th>
						<th scope="col">조회</th>
						<th scope="col">추천</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
					<c:when test="${param.category eq '공지사항'}">
					<c:forEach items="${list}" var="row">
            		<tr>
        	   			<c:if test="${row.inout eq 0 && row.del ne 0 && row.header eq '공지사항'}">
						<td>${row.no}</td>
						<td><a href="./detail?no=${row.no}&inout=${row.inout}">[${row.header}] ${row.title}</a></td>                    
						<td>${row.write}</td>
						<td>${row.date}</td>
						<td>${row.count}</td>
						<td>${row.like}</td>
						</c:if>
					</tr>
					</c:forEach></c:when>
					<c:when test="${param.category eq '여행정보'}">
					<c:forEach items="${list}" var="row">
            		<tr>
        	   			<c:if test="${row.inout eq 0 && row.del ne 0 && row.header eq '여행정보'}">
						<td>${row.no}</td>
						<td><a href="./detail?no=${row.no}&inout=${row.inout}">[${row.header}] ${row.title} ${row.comment }</a></td>                    
						<td>${row.write}</td>
						<td>${row.date}</td>
						<td>${row.count}</td>
						<td>${row.like}</td>
						</c:if>
					</tr>
					</c:forEach></c:when>
					<c:when test="${param.category eq '잡담'}">
					<c:forEach items="${list}" var="row">
            		<tr>
        	   			<c:if test="${row.inout eq 0 && row.del ne 0 && row.header eq '잡담'}">
						<td>${row.no}</td>
						<td><a href="./detail?no=${row.no}&inout=${row.inout}">[${row.header}] ${row.title}</a></td>                    
						<td>${row.write}</td>
						<td>${row.date}</td>
						<td>${row.count}</td>
						<td>${row.like}</td>
						</c:if>
					</tr>
					</c:forEach></c:when>
					<c:otherwise>
					<c:forEach items="${list}" var="row">
            		<tr>
        	   			<c:if test="${row.inout eq 0 && row.del ne 0}">
						<td>${row.no}</td>
						<td><a href="./detail?no=${row.no}&inout=${row.inout}">[${row.header}] ${row.title} <c:if test="${row.comment gt 0}"><span style="font-size: small;">[${row.comment }]</span></c:if></a></td>                    
						<td>${row.write}</td>
						<td>${row.date}</td>
						<td>${row.count}</td>
						<td>${row.like}</td>
						</c:if>
					</tr>
					</c:forEach>
					</c:otherwise>
					</c:choose>
				</tbody>
               </table>
                    <c:set var="totalPage" value="${totalCount/10 }"/>
					<fmt:parseNumber integerOnly="true" value="${totalPage }" var="totalPage"/>
					<c:if test="${totalCount % 10 gt 0}">
						<c:set var="totalPage" value="${totalPage +1 }"/>
					</c:if>
					
					<c:set var ="startPage" value="1"/>
					<c:if test="${page gt 5}">
						<c:set var="startPage" value="${page-5 }"/>
					</c:if>
					<c:set var = "endPage" value="${startPage +9 }"/>
					<c:if test="${endPage gt totalPage }">
						<c:set var="startPage" value="${totalPage - 9 }"/>
						<c:set var="endPage" value="${totalPage }"/>
					</c:if>
							
										<button type="button" class="btn btn-outline-primary" name="writebtn" onclick="url('./write?write=0')">글쓰기</button>
										
								<nav aria-label="Page navigation example">
  									<ul class="pagination" style="justify-content: center">
										<li class="page-item"><button class="page-link" onclick="paging(${page-10})" <c:if test="${page - 10 lt 1 }">disabled="disabled"</c:if> >이전</button></li>
   										<c:forEach begin="${startPage }" end="${endPage }" var="p">
   										<li class="page-item"><a class="page-link" onclick="paging(${p})">${p }</a></li>
										</c:forEach>
										<li class="page-item"><button class="page-link" onclick="paging(${page+10})" <c:if test="${page + 10 gt totalPage }">disabled="disabled"</c:if>>다음</button></li>
 								 	</ul>
								</nav>
								
						</div>
            		</div>
         		</div>
      		<div>
	 		</div>
<script type="text/javascript">
	function paging(no){
		location.href="inboard?page="+no;
}
</script>
</article>
</body>
</html>