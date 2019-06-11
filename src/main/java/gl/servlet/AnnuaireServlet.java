package gl.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gl.model.Student;

@WebServlet(name = "StudentListServlet", urlPatterns = "/Annuaire")
public class AnnuaireServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uniFilterCountry = request.getParameter("studentCountryParam");

		if (uniFilterCountry != null) {
			request.setAttribute("studentsFilteredByCountry", getStudentList(request, response, "", uniFilterCountry));
		}

		request.setAttribute("allStudents", getStudentList(request, response, "", ""));

		RequestDispatcher view = request.getRequestDispatcher("annuaire.jsp");
        view.forward(request, response);
	}

	public List<Student> getStudentList(HttpServletRequest request, HttpServletResponse response, String column, String filter) throws IOException, ServletException {

		List<Student> list = new ArrayList<>();

		try {
			ResultSet rs = DbDao.getStudentList(column, filter);
			while (rs.next()) {
		         Student stud = new Student();
		         if (rs.getDate(7) != null) {
			         Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Europe/Paris"));
			         cal.setTime(rs.getDate(7));
			         stud.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		         } else {
		        	 stud.setYear("N/A");
		         }

		         stud.setId(rs.getInt(1));
		         stud.setFirstName(DbDao.unescapeXML(rs.getString(2)));
		         stud.setLastName(DbDao.unescapeXML(rs.getString(3)));
		         stud.setMail(rs.getString(4));
		         stud.setStartDate(rs.getDate(7));
		         stud.setEndDate(rs.getDate(8));
		         stud.setUniversityName(DbDao.unescapeXML(rs.getString(5)));
		         stud.setUniversityCountry(DbDao.unescapeXML(rs.getString(6)));
		         list.add(stud);
		    }
		} catch(Exception exObj) {
			exObj.printStackTrace();
		} finally {
			DbDao.disconnectDb();
		}
		return list;
	}

}
