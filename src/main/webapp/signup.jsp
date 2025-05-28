<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>MoodTunes 회원가입</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-5" style="max-width: 450px;">
    <h2 class="text-center mb-4">🎧 MoodTunes 회원가입</h2>

    <% if (request.getParameter("error") != null) { %>
      <div class="alert alert-danger text-center">중복된 아이디입니다.</div>
    <% } %>

    <form method="post" action="signup">
      <div class="mb-3">
        <label>아이디</label>
        <input type="text" class="form-control" name="username" required>
      </div>
      <div class="mb-3">
        <label>비밀번호</label>
        <input type="password" class="form-control" name="password" required>
      </div>
      <div class="mb-3">
        <label>전화번호</label>
        <input type="text" class="form-control" name="phone">
      </div>
      <button type="submit" class="btn btn-success w-100">회원가입</button>
    </form>

    <div class="text-center mt-3">
      <a href="login.jsp">로그인 하기</a>
    </div>
  </div>
</body>
</html>
