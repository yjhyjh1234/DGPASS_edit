document.getElementById("search").addEventListener("keypress", function (e) {
	if (e.key === "Enter") {
		location.href = `./search.jsp?keyword=${e.target.value}`;
	}
});
