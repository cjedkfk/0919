<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>와인</title>
</head>
<body>
<%
	String userID =null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID =Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'board_list.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
%>
 <!-- 네비게이션  -->
 <nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed" 
    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
    aria-expaned="false">
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="index.jsp">메인으로 가기</a>
  </div>
  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
    <%
    	if(userID == null){
    %>
    <ul class="nav navbar-nav navbar-right">
    	<li class="dropdown">
     		<a href="#" class="dropdown-toggle"
      			data-toggle="dropdown" role="button" aria-haspopup="true"
      			aria-expanded="false">접속하기<span class="caret"></span></a>
     		<ul class="dropdown-menu">
      			<li><a href="login.jsp">로그인</a></li>
      			<li><a href="join.jsp">회원가입</a></li>
         	</ul>
    	</li>
   </ul>
    <%		
    	} else {
    %>
        <ul class="nav navbar-nav navbar-right">
    	<li class="dropdown">
     		<a href="#" class="dropdown-toggle"
      			data-toggle="dropdown" role="button" aria-haspopup="true"
      			aria-expanded="false">회원관리<span class="caret"></span></a>
     		<ul class="dropdown-menu">
      			<li><a href="logoutAction.jsp">로그아웃</a></li>
         	</ul>
    	</li>
   </ul>
    <%	
    	}
    %>
    <%
	// request 내장객체에서 boardDTO get하여 클래스 변수에 저장()
	String action = request.getParameter("action");
	String groupId = request.getParameter("groupId");
	String category = request.getParameter("category");

%>
  </div> 
 </nav>
 	<div class="container">
 		<div class="row">
 		<form method="post" action="re.jsp?bbsID=<%= bbsID%>">
 		<input type="hidden" name="action" value="<%= action %>">
 		<input type="hidden" name="category" value="<%= bbs.getCategory() %>">
 		<input type="hidden" name="groupId" value="<%= bbs.getGroupId() %>">
 			<table class = "table table-striped" style="text-align: center; border : 1px solid #dddddd">
 				<thead>
 					<tr>
 						<th colspan="3" style = "background-color :#eeeeee; text-align: center;">게시판 글보기 양식</th>
 					</tr>
 				</thead>
 				<tbody>
 					<tr>
 						<td style ="width:20%;">글 제목</td>
 						<td colsapn="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
 					</tr>
 					 <tr>
 						<td>작성자</td>
 						<td colsapn="2"><%= bbs.getUserID() %></td>
 					</tr>
 					 <tr>
 						<td>작성일자</td>
 						<td colsapn="2"><%=  bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) +  "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
 					</tr>
 					 <tr>
 						<td>내용</td>
 						<td colsapn="2" style="min-height: 200px; text-align:left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
 					</tr> 				
 				</tbody>
 			</table>
 			
 			<a href="hit.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">목록</a>
 			<%
 				if(userID != null && userID.equals(bbs.getUserID())){
 			%>
 					<a href="update.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">수정</a>
 					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID%>&category=<%= bbs.getCategory() %>&groupId=<%= bbs.getGroupId() %>" class="btn btn-primary">삭제</a>
 					
 			<%
 				}
 			%>
 			<input type="submit" class="btn btn-primary pull-right" value="댓글">
 			</form>
 		</div>
 	</div>
 <!-- 애니매이션 담당 JQUERY -->
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <!-- 부트스트랩 JS  -->
 <script src="js/bootstrap.js"></script>

</body>
</html>