package com.kosa.ssg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * JDBC 작업 (5가지 : 전체 조회, 조건 조회, 삽입, 수정, 삭제 >> class EmpDao(5개 함수) )
 * 5개의 함수 공통적으로
 * 1. 드라이버 로딩
 * 2. 연결 객체 생성, 명령, 자원 해제
 * 3. 반복적인 코드 제거
 * 
 * 반복적인 코드를 가지고 있는 별도의 클래스 >> ConnectionHelper
 * 
 * ConnectionHelper 설계
 * 함수 자주 사용 >> static >> 함수 종류 >> overloading >> 다형성
 * 
 * 성능 개선을 위해 커넥션 객체를 미리 생성해서 사용하고 반환하는 커넥션 풀 방식을 사용
 * https://hudi.blog/dbcp-and-hikaricp/
 */

public class ConnectionHelper {
	public static Connection getConnection(String dsn, String id, String pwd) throws ClassNotFoundException { // oracle, mysql 연결 가능 가정
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = null;
		try {
			if (dsn.equals("oracle")) conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", id, pwd);
			else if (dsn.equals("mysql")) conn = DriverManager.getConnection("jdbc:mysql://localhost/sampledb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=true", id, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	public static Connection getConnection(String dsn) throws ClassNotFoundException { // oracle, mysql 연결 가능 가정
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = null;
		try {
			if (dsn.equals("oracle")) conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "KOSA", "1004");
			else if (dsn.equals("mysql")) conn = DriverManager.getConnection("jdbc:mysql://localhost/sampledb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=true", "KOSA", "1004");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void close(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
