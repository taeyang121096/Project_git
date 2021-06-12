import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honeyroom/openAPI/Users.dart';
import 'dart:math';
import 'landCord.dart';
import 'map.dart';

// True, false 랜덤
bool random() {
  Random random = Random();
  bool rand = random.nextBool();
  return rand;
}

//방 개수 1~4
int random2(double x) {
  if (x < 30) // 10평미만
    return 1;
  else if (x >= 30 && x < 83) // 25평 미만
    return 2;
  else if (x >= 83 && x <= 130) // 25~39평
    return 3;
  else // 39평 ~
    return 4;
}

// 화장실 개수 1~2
int random3(double x) {
  if (x < 83) // 25평 미만
    return 1;
  else if (x >= 83 && x <= 194) // 25~58평
    return 2;
  else // 58평 ~
    return 3;
}

// 전월세 다가구
void addRentData(
  String constructionYear,
  String year,
  String address,
  String month,
  String date,
  String squareMeasure,
  String code,
  String guranteedAmount,
  String monthlyRent,
) async {
  bool parking = random();
  bool pet = random();
  bool elevator = random();
  bool cctv = random();
  bool doorSecurity = random();
  bool guard = random();
  bool intercom = random();
  bool airConditioner = random();
  bool refrigerator = random();
  bool bed = random();
  bool washer = random();
  bool dishwasher = random();
  bool dryer = random();
  bool closet = random();
  bool shoeRack = random();
  bool microwave = random();
  bool multipleLayer = random();
  int rooms = random2(double.parse(squareMeasure));
  int bathroom = random3(double.parse(squareMeasure));

  FirebaseFirestore addData = FirebaseFirestore.instance;

  var type;
  if (int.parse(monthlyRent) == 0)
    type = '전세';
  else
    type = '월세';

  addData.collection('다가구').doc(type).collection('서울').add({
    '건축년도': constructionYear,
    '년': year,
    '법정동': address,
    '월': month,
    '일': date,
    '전용면적': squareMeasure,
    '지역코드': code,
    '보증금액': guranteedAmount,
    '월세금액': monthlyRent,
    '주차': parking,
    '반려견': pet,
    '엘리베이터': elevator,
    'CCTV': cctv,
    '현관보안': doorSecurity,
    '경비원': guard,
    '인터폰': intercom,
    '에어컨': airConditioner,
    '냉장고': refrigerator,
    '침대': bed,
    '세탁기': washer,
    '식기세척기': dishwasher,
    '건조기': dryer,
    '옷장': closet,
    '신발장': shoeRack,
    '전자레인지': microwave,
    '복층': multipleLayer,
    '방개수': rooms,
    '화장실개수': bathroom,
    '이미지': '',
    '구': landcodeToSeoul[code]
  });
}

// 아파트 전월세
addAprtRentData(
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
    String monthlyRent) async {
  bool parking = random();
  bool pet = random();
  bool elevator = random();
  bool cctv = random();
  bool doorSecurity = random();
  bool guard = random();
  bool intercom = random();
  bool airConditioner = random();
  bool refrigerator = random();
  bool bed = random();
  bool washer = random();
  bool dishwasher = random();
  bool dryer = random();
  bool closet = random();
  bool shoeRack = random();
  bool microwave = random();
  bool multipleLayer = random();
  int rooms = random2(double.parse(squareMeasure));
  int bathroom = random3(double.parse(squareMeasure));
  List points = await pointSearch(address, number);

  FirebaseFirestore addData = FirebaseFirestore.instance;

  var type;
  if (int.parse(monthlyRent) == 0)
    type = '전세';
  else
    type = '월세';

  addData.collection('아파트').doc(type).collection('서울').add({
    '건축년도': constructionYear,
    '년': year,
    '법정동': address,
    '아파트': apartment,
    '월': month,
    '일': date,
    '전용면적': squareMeasure,
    '지번': number,
    '지역코드': code,
    '층': floor,
    '보증금액': guranteedAmount,
    '월세금액': monthlyRent,
    '주차': parking,
    '반려견': pet,
    '엘리베이터': elevator,
    'CCTV': cctv,
    '현관보안': doorSecurity,
    '경비원': guard,
    '인터폰': intercom,
    '에어컨': airConditioner,
    '냉장고': refrigerator,
    '침대': bed,
    '세탁기': washer,
    '식기세척기': dishwasher,
    '건조기': dryer,
    '옷장': closet,
    '신발장': shoeRack,
    '전자레인지': microwave,
    '복층': multipleLayer,
    '방개수': rooms,
    '화장실개수': bathroom,
    '위도': points[0],
    '경도': points[1],
    '이미지': '',
    '구': landcodeToSeoul[code]
  });
}

// 아파트 매매
addAprtbuyData(
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
    String floor) async {
  bool parking = random();
  bool pet = random();
  bool elevator = random();
  bool cctv = random();
  bool doorSecurity = random();
  bool guard = random();
  bool intercom = random();
  bool airConditioner = random();
  bool refrigerator = random();
  bool bed = random();
  bool washer = random();
  bool dishwasher = random();
  bool dryer = random();
  bool closet = random();
  bool shoeRack = random();
  bool microwave = random();
  bool multipleLayer = random();
  int rooms = random2(double.parse(squareMeasure));
  int bathroom = random3(double.parse(squareMeasure));
  List points = await pointSearch(address, number);

  FirebaseFirestore addData = FirebaseFirestore.instance;

  addData.collection('아파트').doc('매매').collection('서울').add({
    '거래금액': transactionAmount,
    '건축년도': constructionYear,
    '년': year,
    '법정동': address,
    '아파트': apartment,
    '월': month,
    '일': date,
    '전용면적': squareMeasure,
    '지번': number,
    '지역코드': code,
    '층': floor,
    '주차': parking,
    '반려견': pet,
    '엘리베이터': elevator,
    'CCTV': cctv,
    '현관보안': doorSecurity,
    '경비원': guard,
    '인터폰': intercom,
    '에어컨': airConditioner,
    '냉장고': refrigerator,
    '침대': bed,
    '세탁기': washer,
    '식기세척기': dishwasher,
    '건조기': dryer,
    '옷장': closet,
    '신발장': shoeRack,
    '전자레인지': microwave,
    '복층': multipleLayer,
    '방개수': rooms,
    '화장실개수': bathroom,
    '위도': points[0],
    '경도': points[1],
    '이미지': '',
    '구': landcodeToSeoul[code]
  });
}
