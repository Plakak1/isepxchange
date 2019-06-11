package gl.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminSideServlet", urlPatterns = "/Admin")
public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String quota = request.getParameter("adminUniQuota");
		String url = request.getParameter("adminUniUrl");
		String information = request.getParameter("adminUniInfo");
		String universityID = request.getParameter("id_university");
		DbDao.updateUniversityInformation(quota, url, information, universityID);

		String uniFilterCountry = request.getParameter("countryParam");
		String uniFilterField = request.getParameter("fieldParam");
		String uniFilterLanguage = request.getParameter("languageParam");
		String currentTab = request.getParameter("currentTab");

		request.setAttribute("allUniversities", DbDemo.getUniversities(request, response, "country", ""));
		if (uniFilterCountry != null) {
			request.setAttribute("filteredUniCountry", DbDemo.getUniversities(request, response, "country", uniFilterCountry));
		}
		if (uniFilterField != null) {
			request.setAttribute("filteredUniField", DbDemo.getUniversities(request, response, "domain", uniFilterField));
			request.setAttribute("selectedField", uniFilterField);
		}
		if (uniFilterLanguage != null) {
			request.setAttribute("filteredUniLanguage", DbDemo.getUniversities(request, response, "language", uniFilterLanguage));
			request.setAttribute("selectedLanguage", uniFilterLanguage);
		}
		if (currentTab != null) {
			request.setAttribute("currentTab", currentTab);
		} else {
			request.setAttribute("currentTab", "1");
		}

		request.setAttribute("allLanguages", DbDemo.getAllLanguages(request, response));
		request.setAttribute("allFields", DbDemo.getAllFields(request, response));
		request.setAttribute("allComments", DbDemo.getComment());

		RequestDispatcher view = request.getRequestDispatcher("adminIndex.jsp");
        view.forward(request, response);
	}

}
