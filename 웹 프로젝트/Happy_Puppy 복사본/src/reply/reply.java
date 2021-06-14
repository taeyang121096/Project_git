package reply;


public class reply {
   
   private String userID;
   private int bbsID;
   private String replyDate;
   private String replyContent;
   
   private int replyID;
   public int getReplyID() {
      return replyID;
   }
   public void setReplyID(int replyID) {
      this.replyID = replyID;
   }
   public String getUserID() {
      return userID;
   }
   public void setUserID(String userID) {
      this.userID = userID;
   }
   public int getBbsID() {
      return bbsID;
   }
   public void setBbsID(int bbsID) {
      this.bbsID = bbsID;
   }
   public String getReplyDate() {
      return replyDate;
   }
   public void setReplyDate(String replyDate) {
      this.replyDate = replyDate;
   }
   public String getReplyContent() {
      return replyContent;
   }
   public void setReplyContent(String replyContent) {
      this.replyContent = replyContent;
   }


   
}