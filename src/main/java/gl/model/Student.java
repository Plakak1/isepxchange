package gl.model;

import java.util.Date;

public class Student {
	private int id;
	private String firstname;
	private String lastname;
	private String mail;
	private int idExchange;
	
	private Date startDate;
	private Date endDate;
	private String year;
	private String universityName;
	private String universityCountry;
	
	public int getId() {
		return this.id;
	}

	public int setId(int id) {
		return this.id = id;
	}
	
	public String getFirstName() {
		return this.firstname;
	}

	public String setFirstName(String firstname) {
		return this.firstname = firstname;
	}

	public String getLastName() {
		return this.lastname;
	}

	public String setLastName(String lastname) {
		return this.lastname = lastname;
	}

	public String getMail() {
		return this.mail;
	}

	public String setMail(String mail) {
		return this.mail = mail;
	}
	
	public int getIdExchange() {
		return this.idExchange;
	}

	public int setIdExchange(int idExchange) {
		return this.idExchange = idExchange;
	}
	
	public Date getStartDate() {
		return this.startDate;
	}

	public Date setStartDate(Date startDate) {
		return this.startDate = startDate;
	}

	public Date getEndDate() {
		return this.endDate;
	}

	public Date setEndDate(Date endDate) {
		return this.endDate = endDate;
	}
	public String getYear() {
		return this.year;
	}

	public String setYear(String year) {
		return this.year = year;
	}

	public String getUniversityName() {
		return this.universityName;
	}

	public String setUniversityName(String universityName) {
		return this.universityName = universityName;
	}

	public String getUniversityCountry() {
		return this.universityCountry;
	}

	public String setUniversityCountry(String universityCountry) {
		return this.universityCountry = universityCountry;
	}
}
