package gl.model;

public class University {
	private int id;
	private String name;
	private String city;
	private String country;
	private String language;
	private String field;
	private String url;
	private int quota;
	private String description;
	
	public int getId() {
		return this.id;
	}

	public int setId(int id) {
		return this.id = id;
	}
	
	public String getName() {
		return this.name;
	}

	public String setName(String name) {
		return this.name = name;
	}
	
	public String getCity() {
		return this.city;
	}

	public String setCity(String city) {
		return this.city = city;
	}

	public String getCountry() {
		return this.country;
	}

	public String setCountry(String country) {
		return this.country = country;
	}

	public String getLanguage() {
		return this.language;
	}

	public String setLanguage(String language) {
		return this.language = language;
	}

	public String getField() {
		return this.field;
	}

	public String setField(String field) {
		return this.field = field;
	}

	public String getUrl() {
		return this.url;
	}

	public String setUrl(String url) {
		return this.url = url;
	}

	public int getQuota() {
		return this.quota;
	}

	public int setQuota(int quota) {
		return this.quota = quota;
	}

	public String getDescription() {
		return this.description;
	}

	public String setDescription(String description) {
		return this.description = description;
	}
}
