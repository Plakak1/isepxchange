package gl.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminNotificationServlet", urlPatterns = "/Notification")
public class NotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NotificationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		String acceptedCom = request.getParameter("acceptComment");
		String rejectedCom = request.getParameter("rejectComment");
		String confirmedAlert = request.getParameter("confirmAlert");
		
		String currentTab = request.getParameter("currentTab");
		if (currentTab != null) {
			request.setAttribute("currentTab", currentTab);
		} else {
			request.setAttribute("currentTab", "1");
		}
		
		
		if (acceptedCom != null) {
			try{
	            DbDao.updateComment(acceptedCom);
	        }
	        catch (Exception exObj){
	            exObj.printStackTrace();
	        }
	        finally {
	            DbDao.disconnectDb();
	        }
		} else if (rejectedCom != null) {
			try{
	            DbDao.deleteComment(rejectedCom);
	        }
	        catch (Exception exObj){
	            exObj.printStackTrace();
	        }
	        finally {
	            DbDao.disconnectDb();
	        }
		} else if (confirmedAlert != null) {
			try{
	            DbDao.deleteAlert(confirmedAlert);
	        }
	        catch (Exception exObj){
	            exObj.printStackTrace();
	        }
	        finally {
	            DbDao.disconnectDb();
	        }
		}
		
		request.setAttribute("allUniversities", DbDemo.getUniversities(request, response, "country", ""));
		request.setAttribute("allComments", DbDemo.getComment());
		request.setAttribute("allAlerts", DbDemo.getAlert());
		
		RequestDispatcher view = request.getRequestDispatcher("notification.jsp");
        view.forward(request, response);
	}

}
