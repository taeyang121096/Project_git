package user;




import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;



public class userDAO {

   




   private Connection conn; // 
   private PreparedStatement pstmt;
   private Statement st;
   private ResultSet rs;
   private static userDAO dao = new userDAO();
   
   public  static userDAO getInstance() {
      return dao;   
   }




   

   public userDAO() { 
      try {

         String url = "jdbc:mysql://localhost:3306/HappyPuppy";
         String user = "root";
         String password ="admin1234";

         Class.forName("com.mysql.jdbc.Driver");

         conn = DriverManager.getConnection(url, user, password);
         
         

      } catch (Exception e) {

         e.printStackTrace();

      }

   }






   public int login(String id, String pw) {

      String SQL = "SELECT pw FROM customer WHERE id = ?";

      try {

         pstmt = conn.prepareStatement(SQL);

         pstmt.setString(1, id);
         
         rs = pstmt.executeQuery();

         if (rs.next()) {

            
            if (rs.getString(1).equals(pw)) {

               return 1; 

            } else

               return 0; 
         }

         return -1; 




      } catch (Exception e) {

         e.printStackTrace();

      }

      return -2; 
   }
   
   public String getDate() { 

      String SQL = "SELECT NOW()";

      try {

         PreparedStatement pstmt = conn.prepareStatement(SQL);

         rs = pstmt.executeQuery();

         if(rs.next()) {

            return rs.getString(1);

         }

      } catch (Exception e) {

         e.printStackTrace();

      }

      return ""; 
   }
   
   public int join(user user) {

      String SQL = "INSERT INTO customer VALUES (?,?,?,?,?,?,?,?,?)";

      try {

         pstmt = conn.prepareStatement(SQL);

         pstmt.setString(1, user.getId());

         pstmt.setString(2, user.getPw());

         

         pstmt.setString(3, user.getPhone());

      
         

         return pstmt.executeUpdate();

      } catch (Exception e) {

         e.printStackTrace();

      }

      return -1;

   }
   
   public ArrayList<user> selectAllMember(){
        ArrayList<user> list = new ArrayList<user>();
        Connection conn=null;
        PreparedStatement ps = null;
        ResultSet rs=null;
        try{
         String sql = "select * from custmoer order by name asc";
         ps = conn.prepareStatement(sql);
         rs = ps.executeQuery();
         while(rs.next()){
          user u = new user();

         u.setId(rs.getString(1));

         u.setPw(rs.getString(2));

         

         u.setPhone(rs.getString(3));

      
          list.add(u);
         }
        }catch(Exception e){
         e.printStackTrace();
        }
        return list;
       }
   
   

   public user getUserInfo(String id) {
      user user = null;
      
      try {
         String SQL = "SELECT * FROM member WHERE id = ?";
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();

         if (rs.next()) {
                user = new user();

                user.setId(rs.getString("id"));
                user.setPw(rs.getString("pw"));
           
                user.setPhone(rs.getString("phone"));
           
             }
         
      } catch (Exception e) {

         e.printStackTrace();

      }
      return user;
      
   }
   public int update(user user) throws SQLException {

        String SQL = "UPDATE customer SET pw = ?, phoneNumber = ? WHERE customer_id = ?";

        try {

           PreparedStatement pstmt = conn.prepareStatement(SQL);

           pstmt.setString(1, user.getPw());
           pstmt.setString(2, user.getPhone());

           pstmt.setString(3, user.getId());
           
           

           return pstmt.executeUpdate();




        } catch (Exception e) {

           e.printStackTrace();

        }

        return -1; 

     }


}