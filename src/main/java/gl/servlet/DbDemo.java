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

import org.apache.commons.lang3.StringEscapeUtils;

import gl.model.Comment;
import gl.model.Alert;
import gl.model.University;

@WebServlet(name = "getUniversitiesServlet", urlPatterns = "")
public class DbDemo extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// getUniversities(request, response);
		request.setAttribute("allUniversities", getUniversities(request, response, "country", ""));
		request.setAttribute("allLanguages", getAllLanguages(request, response));
		request.setAttribute("allFields", getAllFields(request, response));
		request.setAttribute("currentTab", "1");
		request.setAttribute("allComments", getComment());
        RequestDispatcher view = request.getRequestDispatcher("index.jsp");
        view.forward(request, response);
	}
	
	@Override
	protected void doPost( HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String uniFilterCountry = request.getParameter("countryParam");
		String uniFilterField = request.getParameter("fieldParam");
		String uniFilterLanguage = request.getParameter("languageParam");
		String currentTab = request.getParameter("currentTab");
		
		request.setAttribute("allUniversities", getUniversities(request, response, "country", ""));
		if (uniFilterCountry != null) {
			request.setAttribute("filteredUniCountry", getUniversities(request, response, "country", uniFilterCountry));
		}
		if (uniFilterField != null) {
			request.setAttribute("filteredUniField", getUniversities(request, response, "domain", uniFilterField));
			request.setAttribute("selectedField", uniFilterField);
		}
		if (uniFilterLanguage != null) {
			request.setAttribute("filteredUniLanguage", getUniversities(request, response, "language", uniFilterLanguage));
			request.setAttribute("selectedLanguage", uniFilterLanguage);
		}
		if (currentTab != null) {
			request.setAttribute("currentTab", currentTab);
		} else {
			request.setAttribute("currentTab", "1");
		}
		
		request.setAttribute("allLanguages", getAllLanguages(request, response));
		request.setAttribute("allFields", getAllFields(request, response));
		request.setAttribute("allComments", getComment());
		
		String username = request.getParameter("userName");  
	    String password = request.getParameter("password");
	    
	    if (username != null) {   	
			if (DbDao.validate(username, password)){  
				RequestDispatcher view = request.getRequestDispatcher("adminIndex.jsp");
		        view.forward(request, response);
		    }  
		    else {
		    	request.setAttribute("loginErrorMessage", "La connexion a échoué");
		    	RequestDispatcher view = request.getRequestDispatcher("index.jsp");
		        view.forward(request, response); 
		    } 
	    } else {
	    	RequestDispatcher view = request.getRequestDispatcher("index.jsp");
	        view.forward(request, response);
	    }	
}
	
	public static List<University> getUniversities	(HttpServletRequest request, HttpServletResponse response, String column, String filter) throws IOException, ServletException {

		List<University> list = new ArrayList();
		 
		try {
			ResultSet rs = DbDao.getUniversityList(column, filter);
			ResultSet languageList = DbDao.getLanguageList();
			ResultSet fieldList = DbDao.getFieldList();
			while (rs.next()) {
				List<String> langList = new ArrayList();
				List<String> domList = new ArrayList();

				while (languageList.next()) {
					if (languageList.getInt(1) == rs.getInt(1)) {
						langList.add(DbDao.unescapeXML(languageList.getString(2)));
					}
				}
				
				while (fieldList.next()) {
					if (fieldList.getInt(1) == rs.getInt(1)) {
						domList.add(DbDao.unescapeXML(fieldList.getString(2)));
					}
				}
				
		         University uni = new University();
		         uni.setId(rs.getInt(1));
		         uni.setName(DbDao.unescapeXML(rs.getString(2)));
		         uni.setCity(DbDao.unescapeXML(rs.getString(3)));
		         uni.setCountry(DbDao.unescapeXML(rs.getString(4)));
		         uni.setUrl(rs.getString(5));
		         uni.setQuota(rs.getInt(6));
		         uni.setDescription(DbDao.unescapeXML(rs.getString(7)));
		         uni.setLanguage(langList);
		         uni.setField(domList);
		         list.add(uni);
		         
		         languageList.beforeFirst();
		         fieldList.beforeFirst();
		      }
		} catch(Exception exObj) {
			exObj.printStackTrace();
		} finally {
			DbDao.disconnectDb();
		}
		return list;
	}
	
	public static List<String> getAllLanguages	(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		List<String> list = new ArrayList();
		 
		try {
			ResultSet rs = DbDao.getAllLanguages();
			while (rs.next()) {
		         list.add(rs.getString(1));
		      }
		} catch(Exception exObj) {
			exObj.printStackTrace();
		} finally {
			DbDao.disconnectDb();
		}
		return list;
	}
	
	public static List<String> getAllFields (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		List<String> list = new ArrayList();
		 
		try {
			ResultSet rs = DbDao.getAllFields();
			while (rs.next()) {
		         list.add(rs.getString(1));
		      }
		} catch(Exception exObj) {
			exObj.printStackTrace();
		} finally {
			DbDao.disconnectDb();
		}
		return list;
	}
	
	public static List<Comment> getComment(){
        List<Comment> commentList = new ArrayList();
        try{
            ResultSet commentsRS = DbDao.getComments();
            while(commentsRS.next()){
                Comment comment = new Comment();
                comment.setId(commentsRS.getInt(1));
                comment.setCreation_date(commentsRS.getString(2));
                comment.setContent(DbDao.unescapeXML((commentsRS.getString(3))));
                comment.setAuthor_firstname(DbDao.unescapeXML(commentsRS.getString(4)));
                comment.setAuthor_lastname(DbDao.unescapeXML(commentsRS.getString(5)));
                comment.setAuthor_mail(DbDao.unescapeXML(commentsRS.getString(6)));
                comment.setAccepted(commentsRS.getBoolean(7));
                comment.setId_university(commentsRS.getInt(8));
                commentList.add(comment);
            }
        }catch (Exception exception){
            exception.printStackTrace();
        }
        return commentList;
    }
	
	public static List<Alert> getAlert(){
        List<Alert> alertsList = new ArrayList();
        try{
            ResultSet alertsRS = DbDao.getAlerts();
            while(alertsRS.next()){
                Alert alert = new Alert();
                alert.setId(alertsRS.getInt(1));
                alert.setCreationDate(alertsRS.getString(2));
                alert.setAuthorMail(DbDao.unescapeXML(alertsRS.getString(3)));
                alert.setReason(alertsRS.getString(4));
                alert.setComment(DbDao.unescapeXML(alertsRS.getString(5)));
                alert.setTreated(alertsRS.getBoolean(6));
                alert.setIdUniversity(alertsRS.getInt(7));
                alertsList.add(alert);
            }
        }catch (Exception exception){
            exception.printStackTrace();
        }
        return alertsList;
    }
	
}