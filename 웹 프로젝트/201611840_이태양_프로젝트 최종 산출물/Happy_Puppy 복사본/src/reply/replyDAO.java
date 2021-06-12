package reply;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class replyDAO {
      private Connection conn;
      private ResultSet rs;
      public replyDAO() {
         try{
            String url = "jdbc:mysql://localhost:3306/HappyPuppy";
            String user = "root";
            String password ="admin1234";
            try {
               Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            }
            conn=DriverManager.getConnection(url,user,password);
            }catch(SQLException ex){
               System.out.println("데이터베이스 연결이 실패했습니다.<br>");
               }
      }

      public int getNext() { 
         String SQL = "SELECT replyID FROM reply ORDER BY replyID DESC";
         try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
               return rs.getInt(1) + 1;
            }
            return 1;
         } catch (Exception e) {
            e.printStackTrace();
         }
         return -1;
      }
      
      public int write(String userID, int bbsID, String replyContent) { 
         String SQL = "INSERT INTO Reply VALUES(?, ?, ?, ?, ?)";
         try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());   //replyID
            pstmt.setString(2, userID);   //userID
            pstmt.setInt(3, bbsID);      //bbsID
            java.util.Date utilDate = new java.util.Date();
            java.sql.Timestamp sqlDate = new java.sql.Timestamp(utilDate.getTime());   
            pstmt.setTimestamp(4, sqlDate);   //replyDATE      
            pstmt.setString(5, replyContent);   //replyContent
            
            return pstmt.executeUpdate();
         } catch (Exception e) {
            e.printStackTrace();
         }
         return -1; 
      }         
         
      public ArrayList<reply> getList(int bbsID){ 
         String SQL = "SELECT * FROM reply WHERE bbsID = ? ORDER BY replyID";
         ArrayList<reply> list = new ArrayList<reply>();
         try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            rs = pstmt.executeQuery();
               while (rs.next()) {
               reply reply = new reply();
               
               reply.setReplyID(rs.getInt(1));
               reply.setUserID(rs.getString(2));
               reply.setBbsID(rs.getInt(3));
               reply.setReplyDate(rs.getString(4));
               reply.setReplyContent(rs.getString(5));
               list.add(reply);
            }
         } catch (Exception e) {
            e.printStackTrace();
         }
         return list; 
      }

      public int delete(int replyID) {
         String SQL = "delete from reply where replyID = ?";
         try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);   
            pstmt.setInt(1, replyID);
            return pstmt.executeUpdate();
         } catch (Exception e) {
            e.printStackTrace();
         }
         return -1;
      }
}