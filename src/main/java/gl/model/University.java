package gl.model;

import java.util.List;

public class University {

	private int id;
	private String name;
	private String city;
	private String country;
	private List<String> language;
	private List<String> field;
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

	public List<String> getLanguage() {
		return this.language;
	}

	public List<String> setLanguage(List<String> language) {
		return this.language = language;
	}

	public List<String> getField() {
		return this.field;
	}

	public List<String> setField(List<String> field) {
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

	public String getListString(List<String> list){
		String fieldlist = list.toString();
		return fieldlist.substring(1, fieldlist.length()-1);
	}
}
