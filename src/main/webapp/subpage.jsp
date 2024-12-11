<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>동국로드</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<header class="header">
		<div class="container">
			<a class="links" href="./">
				<h1>
					<img class="logo" src="https://www.dongguk.edu/resources/images/site/layout/logo-small.png">동국로드
				</h1>
			</a>
			<div class="nav-container">
				<!--
				<ul class="nav-links">
					<li><a href="#">Restaurants</a></li>
					<li><a href="#">Cafes</a></li>
					<li><a href="#">Shortcuts</a></li>
				</ul>
				-->
				<div class="search-bar">
					<input type="text" id="search" placeholder="검색어를 입력해주세요">
				</div>
			</div>
			
		</div>
	</header>
	
	<!-- 콘텐츠 섹션 -->
	<main class="subpage-container">
		<!-- 왼쪽 옵션 리스트 -->
		<section class="options-list">
			<%
				String sql, id, title, content, category_name, img_src,
						category = request.getParameter("category");
				String[] content_split;
				int no = request.getParameter("no") == null ? -1 : Integer.parseInt(request.getParameter("no")),
						tmp_no;
				PreparedStatement pstmt = null;
				Connection conn = null;
				ResultSet rs = null;
				
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
					conn = DriverManager.getConnection(url, "root", "0000");
					
					sql = "SELECT name FROM dgu_road_category WHERE id = ?;";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, category);
					rs = pstmt.executeQuery();
				} catch (Exception e) {
					out.println("DB 연동 오류: " + e.getMessage());
				}
				
				if (rs != null) {
					rs.next();
					if (rs.getRow() > 0) {
						category_name = rs.getString("name");
			%>
			<h2><%=category_name%></h2>
			<%
					}
				}
			%>
			<ul>
			<%
				try {
					sql = "SELECT article_no, title FROM dgu_road_article WHERE category_id = ?;";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, category);
					rs = pstmt.executeQuery();
				} catch (Exception e) {
					out.println("DB 연동 오류: " + e.getMessage());
				}

				if (rs != null) {
					while (rs.next()) {
						tmp_no = Integer.parseInt(rs.getString("article_no"));
						title = rs.getString("title");
						if (no == -1) no = tmp_no;
			%>
				<li><a href="./subpage.jsp?category=<%=category%>&no=<%=tmp_no%>"><%=title%></a></li>
			<%
					}
				}
			%>
			</ul>
		</section>

		<!-- 오른쪽 콘텐츠 -->
		<section class="content">
			<%
				try {
					sql = "SELECT title, content, image FROM dgu_road_article WHERE article_no = ?;";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, no);
					rs = pstmt.executeQuery();
				} catch (Exception e) {
					out.println("DB 연동 오류: " + e.getMessage());
				}

				if (rs != null) {
					rs.next();
					if (rs.getRow() > 0) {
						title = rs.getString("title");
						content = rs.getString("content");
						img_src = rs.getString("image");
						content_split = content.split("\r\n");
			%>
			<h2 id="title"><%=title%></h2>
			<div>
				<% if (img_src != null) { %>
				<img id="image" src="<%=img_src%>" alt="대표 이미지" class="content-image">
				<% } %>
				<% if (content.length() > 0) { %>
				<ul id="details">
					<% for (String c : content_split) { %>
					<li><span class="text"><%=c%></span></li>
					<% } %>
				</ul>
				<% } %>
			</div>
			<%
					} else {
			%>
			<div>
				해당하는 게시물이 없습니다.
			</div>
			<%
					}
				}
			%>
			<!-- 
			<img id="image" src="images/cafe.jpg" alt="대표 이미지" class="content-image">
			<ul id="details">
				<li>주소: 서울 중구 필동로 1길 30 동국대학교 학술문화관 B1층</li>
				<li>운영시간: 평일 09:00-18:30</li>
				<li>주말: 휴무</li>
			</ul>
			-->
		</section>
	</main>
	<script src="script.js"></script>
</body>
</html>
