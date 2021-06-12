import 'package:flutter/material.dart';
import 'Services.dart';
import 'Users.dart';
import 'package:honeyroom/firestore/addData.dart';
import 'package:honeyroom/firestore/readData.dart';

class JsonParseDemo extends StatefulWidget {
  JsonParseDemo() : super();

  @override
  _JsonParseDemoState createState() => _JsonParseDemoState();
}

class _JsonParseDemoState extends State<JsonParseDemo> {
  //api 읽을때
  //List<ApartBuy> _users;
  //List<MonthlyRent> _users;

  //firebase 읽을 때
  List _users;
  List filterusers = [];
  List<Read> parsinguser;
  List<Read> filterParsinguser;
  bool _loading;

  String building = "아파트";
  String type = "매매";
  String city = "서울";
  String transactionAmount;
  String constructionYear;
  String year;
  String address;
  String apartment;
  String month;
  String date;
  String squareMeasure;
  String number;
  String code;
  String floor;
  String guranteedAmount;
  String monthlyRent;
  List<String> gu;
  //String gu;
  bool parking = true;
  bool pet = true;
  bool elevator = false;
  bool cctv = false;
  bool doorSecurity = false;
  bool guard = false;
  bool intercom = false;
  bool airConditioner = false;
  bool refrigerator = false;
  bool bed = false;
  bool washer = false;
  bool dishwasher = false;
  bool dryer = false;
  bool closet = false;
  bool shoeRack = false;
  bool microwave = false;
  bool multipleLayer = false;
  int rooms = 1;
  int bathroom = 1;

  @override
  //api 호출 (for문 이용)
  // void initState() {
  //   super.initState();
  //   _loading = true;
  //   Services.getUsers();
  // }

  // firebase 데이터 읽는 부분
  @override
  void initState() {
    super.initState();
    _loading = true;
    ReadData.readData(building, type, city).then((users) {
      setState(() {
        _users = users;
        parsinguser = usersFromFirebase(_users);
        _loading = false;
        //filter();
      });
    });
  }

  void filter() {
    filterusers = ReadData.filter(
        _users,
        transactionAmount,
        constructionYear,
        year,
        address,
        apartment,
        month,
        date,
        squareMeasure,
        number,
        code,
        floor,
        guranteedAmount,
        monthlyRent,
        gu,
        parking,
        pet,
        elevator,
        cctv,
        doorSecurity,
        guard,
        intercom,
        airConditioner,
        refrigerator,
        bed,
        washer,
        dishwasher,
        dryer,
        closet,
        shoeRack,
        microwave,
        multipleLayer,
        rooms,
        bathroom);
    filterParsinguser = usersFromFirebase(filterusers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Users'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: null == parsinguser ? 0 : parsinguser.length,
            itemBuilder: (context, index) {
              Read user = parsinguser[index];
              return ListTile(
                title: Text("지역:{$user.address}"),
                subtitle: Text("주차:{$user.parking}, 애완견:{$user.pet}, 월세:"),
              );
            }),
      ),
    );
  }
}
