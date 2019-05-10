package gl.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gl.model.University;

@WebServlet(name = "getUniversityListServlet", urlPatterns = "/UniversityList")
public class UniListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// getUniversities(request, response);
		request.setAttribute("allUniversities", getUniversities(request, response, "country", ""));
		request.setAttribute("filter", "country");
        RequestDispatcher view = request.getRequestDispatcher("index2.jsp");
        view.forward(request, response);
	}
	
	@Override
	protected void doPost( HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String filter = request.getParameter("filterParam");
		String column = request.getParameter("columnParam");
		
		if (filter == null) {
			filter = "";
		}
		
		request.setAttribute("allUniversities", getUniversities(request, response, "", ""));
		request.setAttribute("filteredUniversities", getUniversities(request, response, column, filter));
		request.setAttribute("filter", column);

		
		RequestDispatcher view = request.getRequestDispatcher("index2.jsp");
        view.forward(request, response);
}
	
	public List<University> getUniversities	(HttpServletRequest request, HttpServletResponse response, String column, String filter) throws IOException, ServletException {

		List<University> list = new ArrayList();
		 
		try {
			ResultSet rs = DbDao.getUniversityList(column, filter);
			while (rs.next()) {
		         University uni = new University();
		         uni.setId(rs.getInt(1));
		         uni.setName(rs.getString(2));
		         uni.setCity(rs.getString(3));
		         uni.setCountry(rs.getString(4));
		         uni.setUrl(rs.getString(5));
		         uni.setQuota(rs.getInt(6));
		         uni.setLanguage(rs.getString(7));
		         uni.setField(rs.getString(8));
		         uni.setDescription(rs.getString(9));
		         list.add(uni);
		      }
		} catch(Exception exObj) {
			exObj.printStackTrace();
		} finally {
			DbDao.disconnectDb();
		}
		return list;
	}
}