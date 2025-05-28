package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try (Connection conn = DBUtil.getConnection()) {
      String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, username);
      stmt.setString(2, password);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        // 로그인 성공 → 세션에 사용자 정보 저장
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        response.sendRedirect("userinfo.jsp");  // 성공 시 사용자 정보 페이지로 이동
      } else {
        // 로그인 실패 → login.jsp로 에러 전달
        response.sendRedirect("login.jsp?error=1");
      }

    } catch (Exception e) {
      e.printStackTrace();
      response.getWriter().println("로그인 오류: " + e.getMessage());
    }
  }
}
