package dao;

import java.util.ArrayList;

import dto.Puppy;

public class PuppyRepository {

	private ArrayList<Puppy> listOfPuppies = new ArrayList<Puppy>();
	private static PuppyRepository instance=new PuppyRepository();

	public PuppyRepository() {

		Puppy p1 = new Puppy("p1", "밤달", "8개월", "2020/03/25");
		p1.setAllergy("없음");

		p1.setFeed("loyalchain사료");
		p1.setHeart_rate(85);
		p1.setWeight("3");
		p1.setSleep(12);
		p1.setWalk_time(60);
		p1.setBath(1);
		p1.setSex("남");
		p1.setFilename("p1.png");

		listOfPuppies.add(p1);

	}

	public ArrayList<Puppy> getAllPuppies() {
		return listOfPuppies;
	}

	public Puppy getPuppyById(String puppyId) {
		Puppy puppyById = null;
		for (int i = 0; i < listOfPuppies.size(); i++) {
			Puppy puppy = listOfPuppies.get(i);
			if (puppy != null && puppy.getMemberId() != null && puppy.getMemberId().equals(puppyId)) {
				puppyById = puppy;
				break;
			}
		}
		return puppyById;

	}
	public static PuppyRepository getInstance() {
		return instance;
	}
	public void addPuppy(Puppy puppy) {
		listOfPuppies.add(puppy);
	}

}
