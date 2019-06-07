package gl.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import gl.model.Comment;

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

    public static List<Comment> getComment(){
        List<Comment> commentList = new ArrayList();
        try{
            ResultSet commentsRS = DbDao.getComments();
            while(commentsRS.next()){
                Comment comment = new Comment();
                comment.setId(commentsRS.getInt(1));
                comment.setCreation_date(commentsRS.getString(2));
                comment.setContent(commentsRS.getString(3));
                comment.setAuthor_firstname(commentsRS.getString(4));
                comment.setAuthor_lastname(commentsRS.getString(5));
                comment.setAuthor_mail(commentsRS.getString(6));
                comment.setAccepted(commentsRS.getBoolean(7));
                comment.setId_university(commentsRS.getInt(8));
                commentList.add(comment);
            }
        }catch (Exception exception){
            exception.printStackTrace();
        }
        return commentList;
    }

    public static String displayComment(Comment comment){
        return "<div class='comments'><p><b>"+comment.getCreation_date()+", "+comment.getAuthor_firstname()+" "+comment.getAuthor_lastname()+" ["+comment.getAuthor_mail()+"]</b>"+
                "<br/>"+comment.getContent()+"</p></div>";
    }
}
