<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.net.*, org.json.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Last.fm API 호출
    String apiKey = "YOUR_LASTFM_API_KEY";
    String apiUrl = "https://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=" + apiKey + "&format=json&limit=100";

    URL url = new URL(apiUrl);
    HttpURLConnection con = (HttpURLConnection) url.openConnection();
    con.setRequestMethod("GET");

    BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
    String inputLine;
    StringBuffer responseStr = new StringBuffer();

    while ((inputLine = br.readLine()) != null) {
        responseStr.append(inputLine);
    }
    br.close();

    JSONObject jsonResponse = new JSONObject(responseStr.toString());
    JSONArray trackList = jsonResponse.getJSONObject("tracks").getJSONArray("track");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MoodTunes - 메인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #f0f0f0; padding: 20px;">

    <div class="container">
        <h2 class="mb-4">🎵 MoodTunes에 오신 것을 환영합니다, <%= username %>님!</h2>

        <!-- 버튼 섹션 -->
        <div class="mb-4">
            <a href="uploadMusic.jsp" class="btn btn-primary me-2">내 음악 등록하기</a>
            <a href="playlist.jsp" class="btn btn-success me-2">플레이리스트 등록</a>
            <a href="recommend.jsp" class="btn btn-warning">취향에 맞는 추천</a>
        </div>

        <!-- Top 100 노래 리스트 -->
        <h4>🌍 전세계 인기 Top 100 노래</h4>
        <div class="row row-cols-1 row-cols-md-2 g-3 mt-2">
            <%
                for (int i = 0; i < trackList.length(); i++) {
                    JSONObject track = trackList.getJSONObject(i);
                    String name = track.getString("name");
                    String artist = track.getJSONObject("artist").getString("name");
                    String imageUrl = track.getJSONArray("image").getJSONObject(2).getString("#text");
            %>
            <div class="col">
                <div class="card shadow-sm">
                    <div class="row g-0">
                        <div class="col-md-4">
                            <img src="<%= imageUrl %>" class="img-fluid rounded-start" alt="album cover">
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card-title"><%= name %></h5>
                                <p class="card-text">👤 <%= artist %></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

</body>
</html>
