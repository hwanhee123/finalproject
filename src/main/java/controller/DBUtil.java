package controller;

import java.sql.*;

public class DBUtil {
	  public static Connection getConnection() throws Exception {
		  String url = "jdbc:mysql://172.30.1.100:3306/musicdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Seoul";
	    String user = "root";  // 본인 DB 사용자명
	    String password = "1234";  // 본인 DB 비밀번호

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    return DriverManager.getConnection(url, user, password);
	  }
	}
