//import 'package:location/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key, this.title, this.id}) : super(key: key);
  final String title;
  final String id;

  @override
  _InfoPageState createState() => _InfoPageState();
}

final List<String> imgList = [
  'assets/images/sample_1.jpg',
  'assets/images/sample_2.jpg',
  'assets/images/sample_3.jpg',
  'assets/images/sample_4.jpg'
];

class _InfoPageState extends State<InfoPage> {
  String _previewImageUrl;

/*Future<void> _getCurrentLocationData() async{
  final locData = await Location().getLocation();
  final staticImageUrl = LocationHelper.generateLocationPreviewImage(latitude: locData.latitude, longitude:locData.longitude);
  setState(() {
    _previewImageUrl = staticImageUrl;
  });
}*/

  @override
  Widget build(BuildContext parentcontext) {
    dynamic passdata = widget.id;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _printMenu("상세 정보"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person), tooltip: '사용자 정보', onPressed: () {})
        ],
      ),
      body: Container(
        height: 750,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("아파트")
              .doc("매매")
              .collection("서울")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading...");
              default:
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data.docs[index].id == passdata) {
                        return SingleChildScrollView(
                            child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(5.0)),
                              _printMenu('매물사진'),
                              _printImage(),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  color: Colors.black12,
                                  height: 10,
                                ),
                              ),
                              _printMenu('매물정보'),
                              Padding(padding: EdgeInsets.all(10.0)),
                              Container(height: 1, color: Colors.black12),
                              _printInfo(
                                  '아파트', snapshot.data.docs[index]["아파트"]),
                              Container(height: 1, color: Colors.black12),
                              _printInfo('전용면적',
                                  "${snapshot.data.docs[index]["전용면적"]}"),
                              Container(height: 1, color: Colors.black12),
                              _printInfo(
                                  '방개수', "${snapshot.data.docs[index]["방개수"]}"),
                              Container(height: 1, color: Colors.black12),
                              _printInfo(
                                  '층', "${snapshot.data.docs[index]["층"]}"),
                              Container(height: 1, color: Colors.black12),
                              _printInfo('거래금액',
                                  "${snapshot.data.docs[index]["거래금액"]}"),
                              Container(height: 1, color: Colors.black12),
                              _printInfo('건축년도',
                                  "${snapshot.data.docs[index]["건축년도"]}"),
                              Container(height: 1, color: Colors.black12),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  color: Colors.black12,
                                  height: 10,
                                ),
                              ),
                              _printMenu('편의시설'),
                              Padding(padding: EdgeInsets.all(10.0)),
                              _printOption(
                                  '주차', snapshot.data.docs[index]["주차"]),
                              _printOption(
                                  '반려견', snapshot.data.docs[index]["반려견"]),
                              _printOption(
                                  '엘리베이터', snapshot.data.docs[index]["엘리베이터"]),
                              _printOption(
                                  'CCTV', snapshot.data.docs[index]["CCTV"]),
                              _printOption(
                                  '현관보안', snapshot.data.docs[index]["현관보안"]),
                              _printOption(
                                  '경비원', snapshot.data.docs[index]["경비원"]),
                              _printOption(
                                  '인터폰', snapshot.data.docs[index]["인터폰"]),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  color: Colors.black12,
                                  height: 10,
                                ),
                              ),
                              _printMenu('매물옵션'),
                              Padding(padding: EdgeInsets.all(10.0)),
                              _printOption(
                                  '에어컨', snapshot.data.docs[index]["에어컨"]),
                              _printOption(
                                  '냉장고', snapshot.data.docs[index]["냉장고"]),
                              _printOption(
                                  '침대', snapshot.data.docs[index]["침대"]),
                              _printOption(
                                  '세탁기', snapshot.data.docs[index]["세탁기"]),
                              _printOption(
                                  '식기세척기', snapshot.data.docs[index]["식기세척기"]),
                              _printOption(
                                  '건조기', snapshot.data.docs[index]["건조기"]),
                              _printOption(
                                  '옷장', snapshot.data.docs[index]["옷장"]),
                              _printOption(
                                  '신발장', snapshot.data.docs[index]["신발장"]),
                              _printOption(
                                  '전자레인지', snapshot.data.docs[index]["전자레인지"]),
                              _printOption(
                                  '복층', snapshot.data.docs[index]["복층"]),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                height: 180,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: _previewImageUrl == null
                                    ? Text(
                                        'No Location Chosen',
                                        textAlign: TextAlign.center,
                                      )
                                    : Image.network(
                                        _previewImageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                              ),
                            ],
                          ),
                        ));
                      }
                    });
            }
          },
        ),
      ),
      //아이콘 형식
      /*Row(
          children: <Widget>[
            Column(
              children: <Widget>[Icon(Icons.directions_bus), Text('버스정류장')],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Column(
              children: <Widget>[Icon(Icons.elevator_outlined), Text('엘레베이터')],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Column(
              children: <Widget>[
                Icon(Icons.local_hospital_outlined),
                Text('병원')
              ],
            ),
          ],
        ),*/
    );
  }

  Widget _printMenu(var n) {
    return (Container(
        child: Center(
      child: (Text(n,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
    )));
  }

  Widget _printInfo(var n, var m) {
    return (Row(
      children: <Widget>[
        Container(
          child: Text(
            n,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          width: 100,
        ),
        Container(
          child: Text(
            m,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    ));
  }

  Widget _printImage() {
    return (Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Swiper(
          scale: 0.9,
          viewportFraction: 0.8,
          control: SwiperControl(),
          pagination: SwiperPagination(alignment: Alignment.bottomRight),
          itemCount: imgList.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
                width: 100, height: 200, child: Image.asset(imgList[index]));
          },
        ),
      ),
    ));
  }
}

Widget _printOption(var n, bool m) {
  if (m) {
    return (Container(
        child: Center(
      child: (Text(n, style: TextStyle(fontSize: 20))),
    )));
  } else {
    return (Container());
  }
}
