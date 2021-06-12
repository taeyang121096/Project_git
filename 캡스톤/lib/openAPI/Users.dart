List<ApartRent> apartRentFromJson(var data) {
  return List<ApartRent>.from(data.map((x) => ApartRent.fromJson(x)));
}

// 아파트 전월세
class ApartRent {
  ApartRent({
    this.constructionYear,
    this.year,
    this.address,
    this.apartment,
    this.month,
    this.date,
    this.squareMeasure,
    this.number,
    this.code,
    this.floor,
    this.guranteedAmount,
    this.monthlyRent,
  });

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

  factory ApartRent.fromJson(Map<String, dynamic> json) => ApartRent(
        constructionYear: json["건축년도"],
        year: json["년"],
        address: json["법정동"],
        apartment: json['아파트'],
        month: json['월'],
        date: json["일"],
        squareMeasure: json["전용면적"],
        number: json['지번'],
        code: json['지역코드'],
        floor: json['층'],
        guranteedAmount: json['보증금액'],
        monthlyRent: json['월세금액'],
      );
}

List<ApartBuy> apartBuyFromJson(var data) {
  return List<ApartBuy>.from(data.map((x) => ApartBuy.fromJson(x)));
}

// 아파트 매매
class ApartBuy {
  ApartBuy(
      {this.transactionAmount,
      this.constructionYear,
      this.year,
      this.address,
      this.apartment,
      this.month,
      this.date,
      this.squareMeasure,
      this.number,
      this.code,
      this.floor,
      this.dismantle,
      this.dismantleDate});

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
  String dismantle;
  String dismantleDate;

  factory ApartBuy.fromJson(Map<String, dynamic> json) => ApartBuy(
        transactionAmount: json["거래금액"],
        constructionYear: json["건축년도"],
        year: json["년"],
        address: json["법정동"],
        apartment: json['아파트'],
        month: json['월'],
        date: json["일"],
        squareMeasure: json["전용면적"],
        number: json['지번'],
        code: json['지역코드'],
        floor: json['층'],
        dismantle: json['해체사유발생일'],
        dismantleDate: json['해체여부'],
      );
}

List<MonthlyRent> monthlyRentFromJson(var data) {
  return List<MonthlyRent>.from(data.map((x) => MonthlyRent.fromJson(x)));
}

// 다가구 전월세
class MonthlyRent {
  MonthlyRent({
    this.constructionYear,
    this.year,
    this.address,
    this.month,
    this.date,
    this.squareMeasure,
    this.code,
    this.guranteedAmount,
    this.monthlyRent,
  });

  String constructionYear;
  String year;
  String address;
  String month;
  String date;
  String squareMeasure;
  String code;
  String guranteedAmount;
  String monthlyRent;

  factory MonthlyRent.fromJson(Map<String, dynamic> json) => MonthlyRent(
      constructionYear: json["건축년도"],
      year: json["년"],
      address: json["법정동"],
      month: json['월'],
      date: json["일"],
      squareMeasure: json["계약면적"],
      code: json['지역코드'],
      guranteedAmount: json['보증금액'],
      monthlyRent: json['월세금액']);
}

// firebase 데이터 파싱
List<Read> usersFromFirebase(var data) {
  return List<Read>.from(data.map((x) => Read.fromJson(x)));
}

class Read {
  Read({
    this.transactionAmount,
    this.constructionYear,
    this.year,
    this.address,
    this.apartment,
    this.month,
    this.date,
    this.squareMeasure,
    this.number,
    this.code,
    this.floor,
    this.guranteedAmount,
    this.monthlyRent,
    this.gu,
    this.parking,
    this.pet,
    this.elevator,
    this.cctv,
    this.doorSecurity,
    this.guard,
    this.intercom,
    this.airConditioner,
    this.refrigerator,
    this.bed,
    this.washer,
    this.dishwasher,
    this.dryer,
    this.closet,
    this.shoeRack,
    this.microwave,
    this.multipleLayer,
    this.rooms,
    this.bathroom,
    this.lat,
    this.lng,
  });

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
  String gu;
  bool parking;
  bool pet;
  bool elevator;
  bool cctv;
  bool doorSecurity;
  bool guard;
  bool intercom;
  bool airConditioner;
  bool refrigerator;
  bool bed;
  bool washer;
  bool dishwasher;
  bool dryer;
  bool closet;
  bool shoeRack;
  bool microwave;
  bool multipleLayer;
  int rooms;
  int bathroom;
  double lat;
  double lng;

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        transactionAmount: json["거래금액"],
        constructionYear: json["건축년도"],
        year: json["년"],
        address: json["법정동"],
        apartment: json['아파트'],
        month: json['월'],
        date: json["일"],
        squareMeasure: json["전용면적"],
        number: json['지번'],
        code: json['지역코드'],
        floor: json['층'],
        guranteedAmount: json['보증금액'],
        monthlyRent: json['월세금액'],
        gu: json['구'],
        parking: json['주차'],
        pet: json['반려견'],
        elevator: json['엘리베이터'],
        cctv: json['CCTV'],
        doorSecurity: json['현관보안'],
        guard: json['경비원'],
        intercom: json['인터폰'],
        airConditioner: json['에어컨'],
        refrigerator: json['냉장고'],
        bed: json['침대'],
        washer: json['세탁기'],
        dishwasher: json['식기세척기'],
        dryer: json['건조기'],
        closet: json['옷장'],
        shoeRack: json['신발장'],
        microwave: json['전자레인지'],
        multipleLayer: json['복층'],
        rooms: json['방개수'],
        bathroom: json['화장실개수'],
        lat: json['위도'],
        lng: json['경도'],
      );
}
