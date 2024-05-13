class HistoryGetMoneyModel {
  final String status;
  final String title;
  final String date;
  final String sum;

  HistoryGetMoneyModel({
    this.status,
    this.title,
    this.date,
    this.sum,
  });

  factory HistoryGetMoneyModel.fromJson(Map<String, dynamic> json) {
    return HistoryGetMoneyModel(
      status: json["status"] ?? "",
      title: json["title"] ?? "",
      date: json["date"] ?? "",
      sum: json["sum"] ?? "",
      // accessDomain: json["access_domain"] ?? "",
    );
  }
  @override
  toString() {
    return "status: " + status + ", title: " + title + ', date: ' + date + ', sum: ' + sum;
  }
}
