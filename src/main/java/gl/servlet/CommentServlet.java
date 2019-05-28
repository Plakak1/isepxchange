package gl.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "CommentServlet", urlPatterns = "/CommentServlet")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Date currentDate = new Date();
        DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
        String stringDate = dateFormat.format(currentDate);
        String comment = request.getParameter("comContent");
        String author_firstname = request.getParameter("studentFirstName");
        String author_lastname = request.getParameter("studentLastName");
        String author_mail = request.getParameter("studentMail");
        String id_university = request.getParameter("id_university");

        try{
            DbDao.insertComment(stringDate, comment,author_firstname, author_lastname, author_mail,id_university);
            System.out.println("ADD TO DATABASE");
            response.sendRedirect("/GL");
        }
        catch (Exception exObj){
            exObj.printStackTrace();
        }
        finally {
            DbDao.disconnectDb();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
