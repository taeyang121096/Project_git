// // API 호출 부분(공공데이터 실거래 정보)

// import 'dart:convert';
// import 'dart:io';
// import 'package:xml2json/xml2json.dart';
// import 'package:http/http.dart' as http;
// import 'Users.dart';
// import 'package:honeyroom/firestore/landCord.dart';
// import 'package:honeyroom/firestore/addData.dart';

// // for문 이용해서 데이터 넣기
// class Services {
//   static Xml2Json xml2Json = Xml2Json();
//   static getUsers() async {
//     var date = 202105;
//     // 아파트 매매
//     // String url =
//     //     'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?serviceKey=VsP3C42h0DXIcxUFSjfmt%2F7f5y4Um%2Bvne3HVTGecAlAuTXYShcM1VHSAH5S3yNj%2FW0qHqv7ubtuUQmdRbSYoXg%3D%3D&LAWD_CD=${landcode}&DEAL_YMD=${date}';

//     //아파트 전월세
//     // String url =
//     //        'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptRent?serviceKey=VsP3C42h0DXIcxUFSjfmt%2F7f5y4Um%2Bvne3HVTGecAlAuTXYShcM1VHSAH5S3yNj%2FW0qHqv7ubtuUQmdRbSYoXg%3D%3D&LAWD_CD=${landcode}&DEAL_YMD=${date}';

//     // 단독/ 다가구 전월세
//     // String url =
//     //     'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcSHRent?serviceKey=VsP3C42h0DXIcxUFSjfmt%2F7f5y4Um%2Bvne3HVTGecAlAuTXYShcM1VHSAH5S3yNj%2FW0qHqv7ubtuUQmdRbSYoXg%3D%3D&LAWD_CD=${landcode}&DEAL_YMD=${date}';

//     for (int i = 1; i <= seoulLandcode.length; i++) {
//       var landcode = seoulLandcode[i];
//       var url =
//           'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcSHRent?serviceKey=VsP3C42h0DXIcxUFSjfmt%2F7f5y4Um%2Bvne3HVTGecAlAuTXYShcM1VHSAH5S3yNj%2FW0qHqv7ubtuUQmdRbSYoXg%3D%3D&LAWD_CD=${landcode}&DEAL_YMD=${date}';

//       final response = await http.get(url);
//       var response1 = utf8.decode(response.bodyBytes);
//       xml2Json.parse(response1);
//       var jsonString = xml2Json.toParker();
//       var data = jsonDecode(jsonString);

//       //다가구 전월세
//       final List<MonthlyRent> users =
//           monthlyRentFromJson(data['response']['body']['items']['item']);

//       for (int j = 0; j < users.length; j++) {
//         MonthlyRent user = users[j];
//         addRentData(
//             user.constructionYear,
//             user.year,
//             user.address,
//             user.month,
//             user.date,
//             user.squareMeasure,
//             user.code,
//             user.guranteedAmount,
//             user.monthlyRent);
//       }

//       //아파트 전월세
//       // final List<ApartRent> users =
//       //     apartRentFromJson(data['response']['body']['items']['item']);

//       // for (int j = 15; j < users.length; j++) {
//       //   ApartRent user = users[j];
//       //   addAprtRentData(
//       //       user.constructionYear,
//       //       user.year,
//       //       user.address,
//       //       user.apartment,
//       //       user.month,
//       //       user.date,
//       //       user.squareMeasure,
//       //       user.number,
//       //       user.code,
//       //       user.floor,
//       //       user.guranteedAmount,
//       //       user.monthlyRent);
//       // }

//       // 아파트 매매
//       // final List<ApartBuy> users =
//       //     apartBuyFromJson(data['response']['body']['items']['item']);

//       // for (int j = 0; j < users.length; j++) {
//       //   ApartBuy user = users[j];
//       //   addAprtbuyData(
//       //     user.transactionAmount,
//       //     user.constructionYear,
//       //     user.year,
//       //     user.address,
//       //     user.apartment,
//       //     user.month,
//       //     user.date,
//       //     user.squareMeasure,
//       //     user.number,
//       //     user.code,
//       //     user.floor,
//       //   );
//       // }
//       sleep(const Duration(seconds: 12));
//     }
//   }
// }
