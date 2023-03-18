class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;
  List<String> praysNames = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];
  List<String> praysTimes = [];
  Timings({this.fajr, this.sunrise, this.dhuhr, this.asr, this.sunset, this.maghrib, this.isha, this.imsak, this.midnight, this.firstthird, this.lastthird});

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    imsak = json['Imsak'];
    midnight = json['Midnight'];
    firstthird = json['Firstthird'];
    lastthird = json['Lastthird'];
    praysTimes = [fajr ?? "", dhuhr ?? "", asr ?? "", maghrib ?? "", isha ?? ""];
  }
}
