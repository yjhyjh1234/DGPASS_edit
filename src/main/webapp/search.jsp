<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String keyword = request.getParameter("keyword"),
			sql, id, title, content, category, category_nm;
	int cnt = 0,  no;
	PreparedStatement pstmt = null;
	Connection conn = null;
	ResultSet rs = null;
%>
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
					<input type="text" id="search" placeholder="검색어를 입력해주세요" value="<%=keyword%>">
				</div>
			</div>
			
		</div>
	</header>
		
	<section class="search-section">
		<div class="container body-container">
			<%
				if (keyword != null && keyword.length() > 1) {
					try {
						Class.forName("com.mysql.jdbc.Driver");
						String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
						conn = DriverManager.getConnection(url, "root", "0000");
						sql = "SELECT * FROM dgu_road_article a, dgu_road_category c WHERE a.category_id = c.id AND (title LIKE ? OR content LIKE ?);";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, "%" + keyword + "%");
						pstmt.setString(2, "%" + keyword + "%");
						rs = pstmt.executeQuery();
					} catch (Exception e) {
						out.println("DB 연동 오류: " + e.getMessage());
					}
					
					while (rs.next()) {
						no = Integer.parseInt(rs.getString("article_no"));
						category = rs.getString("id");
						category_nm = rs.getString("name");
						title = rs.getString("title");
						content = rs.getString("content");
						cnt ++;

			%>
			<div class="search-item">
				<a class="links" href="./subpage.jsp?category=<%=category%>&no=<%=no%>">
					<h3><span class="category-badge"><%=category_nm%></span><%=title%></h3>
					<span><%=content%></span>
				</a>
			</div>
			<%
					}
				}
				
				if (cnt == 0) {
			%>
			<div class="search-item">
				<h3>검색 결과가 없습니다.</h3>
				<p>- 검색어는 2자 이상 입력해야 합니다.</p>
				<p>- 다른 검색어를 시도해 보세요.</p>
			</div>
			<% 
				}
			%>
		</div>
	</section>
	
	<section class="map-section">
		<img src="map-placeholder.png" alt="지도" class="map">
	</section>
	<script src="script.js"></script>
</body>
</html>
