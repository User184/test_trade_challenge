class NachislenieModel {
  final String status;
  final String title;
  final String date;
  final String sum;
  final String causer;

  NachislenieModel({
    this.status,
    this.title,
    this.date,
    this.sum,
    this.causer,
  });

  factory NachislenieModel.fromJson(Map<String, dynamic> json) {
    return NachislenieModel(
      status: json["status"] ?? "",
      title: json["title"] ?? "",
      date: json["date"] ?? "",
      sum: json["sum"] ?? "",
      causer: json["causer"] ?? "",
      // accessDomain: json["access_domain"] ?? "",
    );
  }
  @override
  toString() {
    return "status: " + status + ", title: " + title + ', date: ' + date + ', sum: ' + sum;
  }
}
