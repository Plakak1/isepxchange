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

@WebServlet(name = "getUniversitiesServlet", urlPatterns = "")
public class DbDemo extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// getUniversities(request, response);
		request.setAttribute("allUniversities", getUniversities(request, response, "country", ""));
		request.setAttribute("currentTab", "1");
        RequestDispatcher view = request.getRequestDispatcher("index.jsp");
        view.forward(request, response);
	}
	
	@Override
	protected void doPost( HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String uniFilterCountry = request.getParameter("countryParam");
		String uniFilterField = request.getParameter("fieldParam");
		String uniFilterLanguage = request.getParameter("languageParam");
		String uniFilterExchange = request.getParameter("exchangeTypeParam");
		String currentTab = request.getParameter("currentTab");
		
		request.setAttribute("allUniversities", getUniversities(request, response, "country", ""));
		if (uniFilterCountry != null) {
			request.setAttribute("filteredUniCountry", getUniversities(request, response, "country", uniFilterCountry));
		}
		if (uniFilterField != null) {
			request.setAttribute("filteredUniField", getUniversities(request, response, "domain", uniFilterField));
		}
		if (uniFilterLanguage != null) {
			request.setAttribute("filteredUniLanguage", getUniversities(request, response, "language", uniFilterLanguage));
		}
		if (currentTab != null) {
			request.setAttribute("currentTab", currentTab);
		} else {
			request.setAttribute("currentTab", "1");
		}

		RequestDispatcher view = request.getRequestDispatcher("index.jsp");
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