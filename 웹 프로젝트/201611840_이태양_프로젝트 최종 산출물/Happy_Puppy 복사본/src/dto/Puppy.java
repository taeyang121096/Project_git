package dto;

import java.io.Serializable;

public class Puppy implements Serializable {

	private static final long serialVersionUID = -4274700572038677000L;
	private String memberId;
	private String name;
	private String allergy;

	private String feed;
	private String birth;
	private String age;
	private String sex;
	private Integer heart_rate;
	private String weight;
	private Integer sleep;
	private Integer walk_time;
	private Integer bath;
	private String filename;

	public Puppy() {
		super();
	}

	public Puppy(String memberId, String name, String age, String birth) {
		this.memberId = memberId;
		this.name = name;
		this.age = age;
		this.birth = birth;

	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String puppyId) {
		this.memberId = puppyId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAllergy() {
		return allergy;
	}

	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}

	

	public String getFeed() {
		return feed;
	}

	public void setFeed(String feed) {
		this.feed = feed;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getHeart_rate() {
		return heart_rate;
	}

	public void setHeart_rate(Integer heart_rate) {
		this.heart_rate = heart_rate;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public Integer getSleep() {
		return sleep;
	}

	public void setSleep(Integer sleep) {
		this.sleep = sleep;
	}

	public Integer getWalk_time() {
		return walk_time;
	}

	public void setWalk_time(Integer walk_time) {
		this.walk_time = walk_time;
	}

	public Integer getBath() {
		return bath;
	}

	public void setBath(Integer bath) {
		this.bath = bath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}

}
