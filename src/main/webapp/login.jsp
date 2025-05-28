<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>MoodTunes 로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #1f4037, #99f2c8);
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-container {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 400px;
    }

    .login-container h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #2f4f4f;
    }
  </style>
</head>
<body>

  <div class="login-container">
    <h2>🎵 MoodTunes 로그인</h2>

    <!-- 에러 메시지 출력 -->
    <%
      String error = request.getParameter("error");
      if (error != null) {
    %>
      <div class="alert alert-danger text-center">
        아이디 또는 비밀번호가 일치하지 않습니다.
      </div>
    <%
      }
    %>

    <!-- 로그인 폼 -->
    <form method="post" action="login">
      <div class="mb-3">
        <label class="form-label">아이디</label>
        <input type="text" class="form-control" name="username" required>
      </div>
      <div class="mb-3">
        <label class="form-label">비밀번호</label>
        <input type="password" class="form-control" name="password" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>

    <div class="text-center mt-3">
      <a href="signup.jsp">회원가입</a>
    </div>
  </div>

</body>
</html>
