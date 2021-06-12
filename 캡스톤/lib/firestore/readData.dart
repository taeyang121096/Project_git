import 'package:cloud_firestore/cloud_firestore.dart';

// firebase의 데이터를 읽어오는 부분
/* 
  building : 아파트, 다가구, 오피스텔
  type : 매매, 전세, 월세
  city : 시
*/
class ReadData {
  static Future readData(
    String building,
    String type,
    String city,
  ) async {
    List _users = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(building)
        .doc(type)
        .collection(city)
        .get();

    for (int i = 0; i < querySnapshot.size; i++) {
      _users.add(querySnapshot.docs[i].data());
    }
    return _users;
  }

  //filter
  static filter(
      List user,
      String transactionAmount,
      String constructionYear,
      String year,
      String address,
      String apartment,
      String month,
      String date,
      String squareMeasure,
      String number,
      String code,
      String floor,
      String guranteedAmount,
      String monthlyRent,
      List<String> gu,
      bool parking,
      bool pet,
      bool elevator,
      bool cctv,
      bool doorSecurity,
      bool guard,
      bool intercom,
      bool airConditioner,
      bool refrigerator,
      bool bed,
      bool washer,
      bool dishwasher,
      bool dryer,
      bool closet,
      bool shoeRack,
      bool microwave,
      bool multipleLayer,
      int rooms,
      int bathroom) {
    var _user = user
        .where((element) => gu != ""
            ? element['구'] == gu[0] ||
                element['구'] == gu[1] ||
                element['구'] == gu[2] ||
                element['구'] == gu[3] ||
                element['구'] == gu[4]
            : true)
        .where((element) => pet == true ? element['반려견'] == true : true)
        .where((element) => parking == true ? element['주차'] == true : true)
        .where((element) => elevator == true ? element['엘리베이터'] == true : true)
        .where((element) => cctv == true ? element['CCTV'] == true : true)
        .where(
            (element) => doorSecurity == true ? element['현관보안'] == true : true)
        .where((element) => guard == true ? element['경비원'] == true : true)
        .where((element) => intercom == true ? element['인터폰'] == true : true)
        .where(
            (element) => airConditioner == true ? element['에어컨'] == true : true)
        .where(
            (element) => refrigerator == true ? element['냉장고'] == true : true)
        .where((element) => bed == true ? element['침대'] == true : true)
        .where((element) => washer == true ? element['세탁기'] == true : true)
        .where(
            (element) => dishwasher == true ? element['식기세척기'] == true : true)
        .where((element) => dryer == true ? element['건조기'] == true : true)
        .where((element) => closet == true ? element['옷장'] == true : true)
        .where((element) => shoeRack == true ? element['신발장'] == true : true)
        .where((element) => microwave == true ? element['전자레인지'] == true : true)
        .where(
            (element) => multipleLayer == true ? element['복층'] == true : true)
        .where((element) => rooms != 0 ? element['방개수'] <= rooms : true)
        .where((element) => bathroom != 0 ? element['화장실개수'] <= bathroom : true)
        .toList();
    print(_user);
    if (_user.isNotEmpty) {
      return _user;
    } else
      return false;
  }
}
