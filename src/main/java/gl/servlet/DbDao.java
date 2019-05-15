package gl.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
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
			connObj = DriverManager.getConnection("jdbc:mysql://localhost:3306/isepxchange2?useSSL=false", "root", "password");
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
				String sql = "SELECT * from isepxchange2.university WHERE country = '" + filter + "';";
				
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

				String sql = "SELECT * FROM isepxchange2.university";
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

				String sql = "SELECT NAME from isepxchange2.LANGUAGE;";
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

				String sql = "SELECT NAME from isepxchange2.DOMAIN;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		return rsObj;
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static void postComment(String firstName, String lastName, String mail, int idExchange) {
		try {
			stmtObj = connectDb().createStatement();

			String sql = "INSERT INTO isepxchange2.student (firstname, lastname, mail, id_exchange) VALUES (" + firstName + ", " + lastName + ", "
					+ mail + ", " + idExchange + ")";
			rsObj = stmtObj.executeQuery(sql);
		} catch (Exception exObj) {
				exObj.printStackTrace();
		}
	}
	
	/***** Method #2 :: This Method Is Used To Retrieve The Records From The Database *****/
	public static ResultSet getStudentList(String column, String filter) {
		if (filter.length() != 0) {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange2.student INNER JOIN isepxchange2.echange INNER JOIN isepxchange2.university ON "
						+ "isepxchange2.student.id_Exchange = isepxchange2.echange.id AND isepxchange2.echange.id_University = isepxchange2.university.id;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange2.student";
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

				String sql = "SELECT * FROM isepxchange2.exchange WHERE " + column + " = "  + "'" + filter + "'";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange2.exchange";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		}

		return rsObj;
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