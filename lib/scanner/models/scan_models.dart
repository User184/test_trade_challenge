abstract class ScanModel {}

class ScanResponseModel extends ScanModel {
  int code;
  String message;
  String description;

  // String accessDomain;

  ScanResponseModel({
    this.code,
    this.message,
    this.description,
    // this.accessDomain,
  });

  factory ScanResponseModel.fromJson(Map<String, dynamic> json) {
    return ScanResponseModel(
      code: json["code"] ?? "",
      message: json["message"] ?? "",
      description: json["description"] ?? "",
      // accessDomain: json["access_domain"] ?? "",
    );
  }

  @override
  toString() {
    return "code: " +
        code.toString() +
        ", messge: " +
        message +
        ', description: ' +
        description;
  }
}

class ScanRequestModel extends ScanModel {
  String t;
  String s;
  String fn;
  String fp;
  String i;
  String n;

  // String os;
  // String version;
  // String deviceToken;

  ScanRequestModel({
    this.fn,
    this.fp,
    this.i,
    this.n,
    this.s,
    this.t,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      't': t,
      's': s,
      'fn': fn,
      'fp': fp,
      'i': i,
      'n': n
    };

    return map;
  }
}

class ErrorRequestScan extends ScanModel {
  final String error;

  ErrorRequestScan({
    this.error,
  });
}

class SuccessRequestScan extends ScanModel {
  final String success;

  SuccessRequestScan({
    this.success,
  });
}
