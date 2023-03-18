class Date {
  String? readable;
  String? timestamp;
  HijriDate? hijri;

  Date({this.readable, this.timestamp, this.hijri});

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'];
    timestamp = json['timestamp'];
    hijri = json['hijri'] != null ? HijriDate.fromJson(json['hijri']) : null;
  }
}

class HijriDate {
  String? date;
  String? format;

  HijriDate({this.date, this.format});

  HijriDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
  }
}
