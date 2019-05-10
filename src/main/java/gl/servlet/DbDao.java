package gl.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbDao {

	static ResultSet rsObj = null;
	static Statement stmtObj = null;
	static Connection connObj = null;

	/***** Method #1 :: This Method Is Used To Create A Connection With The Database *****/
	private static Connection connectDb() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connObj = DriverManager.getConnection("jdbc:mysql://localhost:3306/gl?useSSL=false", "root", "password");
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

				String sql = "SELECT * FROM isepxchange.university WHERE " + column + " like "  + "'%" + filter + "%'";
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
	public static ResultSet getStudentList(String column, String filter) {
		if (filter.length() != 0) {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange.student INNER JOIN isepxchange.echange INNER JOIN isepxchange.university ON "
						+ "isepxchange.student.id_Exchange = isepxchange.echange.id AND isepxchange.echange.id_University = isepxchange.university.id;";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange.student";
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

				String sql = "SELECT * FROM isepxchange.exchange WHERE " + column + " = "  + "'" + filter + "'";
				rsObj = stmtObj.executeQuery(sql);
			} catch (Exception exObj) {
				exObj.printStackTrace();
			}
		} else {
			try {
				stmtObj = connectDb().createStatement();

				String sql = "SELECT * FROM isepxchange.exchange";
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