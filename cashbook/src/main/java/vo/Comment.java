package vo;

public class Comment {
	private int CommentNo;
	private int helpNo;
	private String CommentMemo;
	private String memberId;
	private String updatedate;
	private String createdate;
	public int getCommentNo() {
		return CommentNo;
	}
	public void setCommentNo(int commentNo) {
		CommentNo = commentNo;
	}
	public int getHelpNo() {
		return helpNo;
	}
	public void setHelpNo(int helpNo) {
		this.helpNo = helpNo;
	}
	public String getCommentMemo() {
		return CommentMemo;
	}
	public void setCommentMemo(String commentMemo) {
		CommentMemo = commentMemo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
	
	
}
