package gl.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbDao {

	static ResultSet rsObj = null;
	static Statement stmtObj = null;
	static Connection connObj = null;

	/***** Method #1 :: This Method Is Used To Create A Connection With The Database *****/
	private static Connection connectDb() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connObj = DriverManager.getConnection("jdbc:mysql://localhost:3306/isepxchange?useSSL=false", "root", "password");
		} catch (Exception exObj) {
			exObj.printStackTrace();
		}
		return connObj;
	}

	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getUniversityList(String column, String filter) {
		if (filter.length() != 0) {
			try {
				stmtObj = connectDb().createStatement();
				String sql = "SELECT * from isepxchange.university WHERE country = '" + filter + "';";
				
				if (column.equals("language")) {
					sql = "SELECT UNIVERSITY.ID, UNIVERSITY.NAME, UNIVERSITY.CITY, UNIVERSITY.COUNTRY, " + 
							"UNIVERSITY.URL, UNIVERSITY.QUOTA, UNIVERSITY.DESCRIPTION FROM UNIVERSITY " + 
							"INNER JOIN LANGUAGE INNER JOIN UNI_LANGUAGE " + 
							"ON UNI_LANGUAGE.ID_LANGUAGE = LANGUAGE.ID WHERE LANGUAGE.NAME = '" + filter + "' " +
							"AND UNI_LANGUAGE.ID_UNIVERSITY = UNIVERSITY.ID;";
				} else if (column.equals("domain")) {
					sql = "SELECT UNIVERSITY.ID, UNIVERSITY.NAME, UNIVERSITY.CITY, UNIVERSITY.COUNTRY, " + 
							"UNIVERSITY.URL, UNIVERSITY.QUOTA, UNIVERSITY.DESCRIPTION FROM UNIVERSITY " + 
							"INNER JOIN DOMAIN INNER JOIN UNI_DOMAIN " + 
							"ON UNI_DOMAIN.ID_DOMAIN = DOMAIN.ID WHERE DOMAIN.NAME = '" + filter + "' " +
							"AND UNI_DOMAIN.ID_UNIVERSITY = UNIVERSITY.ID;";
				} 

				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange.university";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		}

		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getLanguageList () {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT UNI_LANGUAGE.ID_UNIVERSITY, LANGUAGE.NAME " + 
						"from university INNER JOIN UNI_LANGUAGE " + 
						"ON UNI_LANGUAGE.ID_UNIVERSITY = UNIVERSITY.ID " + 
						"INNER JOIN LANGUAGE ON UNI_LANGUAGE.ID_LANGUAGE = LANGUAGE.ID " + 
						"ORDER BY ID_UNIVERSITY;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getFieldList () {
			try {
				stmtObj = connectDb().createStatement();
				String sql = "SELECT UNI_DOMAIN.ID_UNIVERSITY, DOMAIN.NAME " + 
						"from university INNER JOIN UNI_DOMAIN " + 
						"ON UNI_DOMAIN.ID_UNIVERSITY = UNIVERSITY.ID " + 
						"INNER JOIN DOMAIN ON UNI_DOMAIN.ID_DOMAIN = DOMAIN.ID " + 
						"ORDER BY ID_UNIVERSITY;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getAllLanguages () {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT NAME from isepxchange.LANGUAGE;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getAllFields () {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT NAME from isepxchange.DOMAIN;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		return rsObj;
	}

	/***** Method #2 :: This Method Is Used To Insert The Records In The Database *****/
	public static void insertComment(String actualDate, String commentContent, String author_firstname, String author_lastname, String author_mail, String id_university) {
		try {
			stmtObj = connectDb().createStatement();
			String query = "INSERT INTO isepxchange.comment(creation_date, content, author_firstname, author_lastname, author_mail, accepted, id_university)"+
					" VALUES ('"+actualDate+"','"+commentContent+"','"+author_firstname+"','"+author_lastname+"','"+author_mail+"', FALSE,'"+id_university+"')";
			stmtObj.executeUpdate(query);
		} catch (Exception exObj) {
			exObj.printStackTrace();
		}
	}
	
	public static void updateComment(String id) {
		try {
			stmtObj = connectDb().createStatement();
			String query = "UPDATE isepxchange.comment SET ACCEPTED = " + true + " WHERE ID = '" + id + "'";
			stmtObj.executeUpdate(query);
		} catch (Exception exObj) {
			exObj.printStackTrace();
		}
	}
	
	public static void deleteComment(String id) {
		try {
			stmtObj = connectDb().createStatement();
			String query = "DELETE FROM isepxchange.comment WHERE ID = '" + id + "'";
			stmtObj.executeUpdate(query);
		} catch (Exception exObj) {
			exObj.printStackTrace();
		}
	}

	public static ResultSet getComments(){
		try {
			stmtObj = connectDb().createStatement();
			String query = "SELECT * FROM ISEPXCHANGE.COMMENT";
			rsObj = stmtObj.executeQuery(query);
		} catch (Exception exception){
			exception.printStackTrace();
		}
		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Insert The Records In The Database *****/
	public static void insertAlert(String actualDate, String authorMail, String reason, String comment, String id_university) {
		try {
			stmtObj = connectDb().createStatement();
			String query = "INSERT INTO isepxchange.alert(creation_date, author_mail, reason, comment, treated, id_university)"+
					" VALUES ('"+actualDate+"','"+authorMail+"','"+reason+"','"+comment+"', TRUE ,'"+id_university+"')";
			stmtObj.executeUpdate(query);
		} catch (Exception exObj) {
			exObj.printStackTrace();
		}
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getStudentList(String column, String filter) {
		if (filter.length() != 0) {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT student.ID, student.FIRSTNAME, student.LASTNAME, student.MAIL, university.NAME, university.COUNTRY, " + 
						"student_exchange.START_DATE, student_exchange.END_DATE, " + 
						"university.URL FROM isepxchange.student INNER JOIN isepxchange.student_exchange INNER JOIN isepxchange.university ON "
						+ "isepxchange.student_exchange.id_University = isepxchange.university.id "
						+ "AND isepxchange.student_exchange.ID_STUDENT = isepxchange.student.id "
						+ "WHERE isepxchange.university.country = '" + filter + "';";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT student.ID, student.FIRSTNAME, student.LASTNAME, student.MAIL, university.NAME, university.COUNTRY, " + 
						"student_exchange.START_DATE, student_exchange.END_DATE, " + 
						"university.URL FROM isepxchange.student INNER JOIN isepxchange.student_exchange INNER JOIN isepxchange.university ON "
						+ "isepxchange.student_exchange.id_University = isepxchange.university.id "
						+ "AND isepxchange.student_exchange.ID_STUDENT = isepxchange.student.id;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		}

		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getExchangeList(String column, String filter) {
		if (filter.length() != 0) {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange.student_exchange WHERE " + column + " = "  + "'" + filter + "'";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange.student_exchange";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		}

		return rsObj;
	}
	
	public static boolean validate(String name,String password){  
		boolean status=false;  
		try {
			stmtObj = connectDb().createStatement();
			
			PreparedStatement ps = connObj.prepareStatement("select * from isepxchange.admin where name=? and password=?");  
			ps.setString(1, name);  
			ps.setString(2, password);  
			      
			ResultSet rs=ps.executeQuery();  
			status=rs.next();  	          
		} catch(Exception e) {
			System.out.println(e);
		}
		
		return status;  
	}

	/***** Method #3 :: This Method Is Used To Close The Connection With The Database *****/
	public static void disconnectDb() {
		try {
			rsObj.close();
			stmtObj.close();
			connObj.close();
		} catch (Exception exObj) {
			exObj.printStackTrace();
		}		
	}
}