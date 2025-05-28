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

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String phone = request.getParameter("phone");

    try (Connection conn = DBUtil.getConnection()) {
      // 아이디 중복 확인
      String checkSql = "SELECT * FROM user WHERE username = ?";
      PreparedStatement checkStmt = conn.prepareStatement(checkSql);
      checkStmt.setString(1, username);
      ResultSet rs = checkStmt.executeQuery();

      if (rs.next()) {
        // 중복 아이디 → signup.jsp로 에러 메시지 전달
        response.sendRedirect("signup.jsp?error=1");
        return;
      }

      // 회원가입 정보 삽입
      String insertSql = "INSERT INTO user (username, password, phone) VALUES (?, ?, ?)";
      PreparedStatement insertStmt = conn.prepareStatement(insertSql);
      insertStmt.setString(1, username);
      insertStmt.setString(2, password);  // 비밀번호 평문 저장 (암호화는 후속 단계에서)
      insertStmt.setString(3, phone);
      insertStmt.executeUpdate();

      // 회원가입 성공 → 로그인 페이지로 리다이렉트
      response.sendRedirect("login.jsp");

    } catch (Exception e) {
      e.printStackTrace();
      response.getWriter().println("회원가입 중 오류 발생: " + e.getMessage());
    }
  }
}
