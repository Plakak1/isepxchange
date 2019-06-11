package gl.model;

public class Alert {

	private int id;
	private String creationDate;
	private String authorMail;
	private String reason;
	private String comment;
	private boolean treated;
	private int idUniversity;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public String getAuthorMail() {
		return authorMail;
	}

	public void setAuthorMail(String authorMail) {
		this.authorMail = authorMail;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public boolean isTreated() {
		return treated;
	}

	public void setTreated(boolean treated) {
		this.treated = treated;
	}

	public int getIdUniversity() {
		return idUniversity;
	}

	public void setIdUniversity(int idUniversity) {
		this.idUniversity = idUniversity;
	}
}
