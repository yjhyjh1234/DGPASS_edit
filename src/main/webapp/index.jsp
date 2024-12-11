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
		
	<section class="filter-section">
		<div class="filter-buttons">
			<%
				String sql, id, name;
				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;
				
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
					conn = DriverManager.getConnection(url, "root", "0000");
					stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
					sql = "SELECT * FROM dgu_road_category;";
					rs = stmt.executeQuery(sql);
				} catch (Exception e) {
					out.println("DB 연동 오류: " + e.getMessage());
				}

				if (rs != null) {
					while (rs.next()) {
						id = rs.getString("id");
						name = rs.getString("name");
			%>
			<a class="button" href="./subpage.jsp?category=<%=id%>"><%=name%></a>
			<%
					}
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
