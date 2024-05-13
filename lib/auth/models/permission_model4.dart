import 'dart:convert';

PermissionModel4 permissionModel4FromJson(String str) =>
    PermissionModel4.fromJson(json.decode(str));

String permissionModel4ToJson(PermissionModel4 data) =>
    json.encode(data.toJson());

class PermissionModel4 {
  PermissionModel4({
    this.data,
  });

  PermissionModel4.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;
  PermissionModel4 copyWith({
    Data data,
  }) =>
      PermissionModel4(
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.name,
    this.lastName,
    this.patronymic,
    this.profileIsCompleted,
    this.email,
    this.phone,
    this.city,
    this.rubBalance,
    this.pointsBalance,
    this.officePositionTitle,
    this.company,
    this.promo,
    this.permissions,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    patronymic = json['patronymic'];
    profileIsCompleted = json['profile_is_completed'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    rubBalance = json['rub_balance'];
    pointsBalance = json['points_balance'];
    officePositionTitle = json['office_position_title'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    promo = json['promo'] != null ? Promo.fromJson(json['promo']) : null;
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
  }
  int id;
  String name;
  String lastName;
  String patronymic;
  bool profileIsCompleted;
  String email;
  String phone;
  String city;
  int rubBalance;
  int pointsBalance;
  String officePositionTitle;
  Company company;
  Promo promo;
  Permissions permissions;
  Data copyWith({
    int id,
    String name,
    String lastName,
    String patronymic,
    bool profileIsCompleted,
    String email,
    String phone,
    String city,
    int rubBalance,
    int pointsBalance,
    String officePositionTitle,
    Company company,
    Promo promo,
    Permissions permissions,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        patronymic: patronymic ?? this.patronymic,
        profileIsCompleted: profileIsCompleted ?? this.profileIsCompleted,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        city: city ?? this.city,
        rubBalance: rubBalance ?? this.rubBalance,
        pointsBalance: pointsBalance ?? this.pointsBalance,
        officePositionTitle: officePositionTitle ?? this.officePositionTitle,
        company: company ?? this.company,
        promo: promo ?? this.promo,
        permissions: permissions ?? this.permissions,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['last_name'] = lastName;
    map['patronymic'] = patronymic;
    map['profile_is_completed'] = profileIsCompleted;
    map['email'] = email;
    map['phone'] = phone;
    map['city'] = city;
    map['rub_balance'] = rubBalance;
    map['points_balance'] = pointsBalance;
    map['office_position_title'] = officePositionTitle;
    if (company != null) {
      map['company'] = company.toJson();
    }
    if (promo != null) {
      map['promo'] = promo.toJson();
    }
    if (permissions != null) {
      map['permissions'] = permissions.toJson();
    }
    return map;
  }
}

Permissions permissionsFromJson(String str) =>
    Permissions.fromJson(json.decode(str));
String permissionsToJson(Permissions data) => json.encode(data.toJson());

class Permissions {
  Permissions({
    this.passportdata,
    this.faqs,
    this.news,
    this.welcomescreens,
    this.certificates,
    this.notifications,
    this.files,
    this.tests,
    this.promos,
    this.products,
    this.mechanics,
    this.checks,
    this.goods,
    this.transactions,
    this.withdrawals,
  });

  Permissions.fromJson(dynamic json) {
    passportdata = json['passport-data'] != null
        ? json['passport-data'].cast<String>()
        : [];
    faqs = json['faqs'] != null ? json['faqs'].cast<String>() : [];
    news = json['news'] != null ? json['news'].cast<String>() : [];
    welcomescreens = json['welcome-screens'] != null
        ? json['welcome-screens'].cast<String>()
        : [];
    certificates =
        json['certificates'] != null ? json['certificates'].cast<String>() : [];
    notifications = json['notifications'] != null
        ? json['notifications'].cast<String>()
        : [];
    files = json['files'] != null ? json['files'].cast<String>() : [];
    tests = json['tests'] != null ? json['tests'].cast<String>() : [];
    promos = json['promos'] != null ? json['promos'].cast<String>() : [];
    products = json['products'] != null ? json['products'].cast<String>() : [];
    mechanics =
        json['mechanics'] != null ? json['mechanics'].cast<String>() : [];
    checks = json['checks'] != null ? json['checks'].cast<String>() : [];
    goods = json['goods'] != null ? json['goods'].cast<String>() : [];
    transactions =
        json['transactions'] != null ? json['transactions'].cast<String>() : [];
    withdrawals =
        json['withdrawals'] != null ? json['withdrawals'].cast<String>() : [];
  }
  List<String> passportdata;
  List<String> faqs;
  List<String> news;
  List<String> welcomescreens;
  List<String> certificates;
  List<String> notifications;
  List<String> files;
  List<String> tests;
  List<String> promos;
  List<String> products;
  List<String> mechanics;
  List<String> checks;
  List<String> goods;
  List<String> transactions;
  List<String> withdrawals;
  Permissions copyWith({
    List<String> passportdata,
    List<String> faqs,
    List<String> news,
    List<String> welcomescreens,
    List<String> certificates,
    List<String> notifications,
    List<String> files,
    List<String> tests,
    List<String> promos,
    List<String> products,
    List<String> mechanics,
    List<String> checks,
    List<String> goods,
    List<String> transactions,
    List<String> withdrawals,
  }) =>
      Permissions(
        passportdata: passportdata ?? this.passportdata,
        faqs: faqs ?? this.faqs,
        news: news ?? this.news,
        welcomescreens: welcomescreens ?? this.welcomescreens,
        certificates: certificates ?? this.certificates,
        notifications: notifications ?? this.notifications,
        files: files ?? this.files,
        tests: tests ?? this.tests,
        promos: promos ?? this.promos,
        products: products ?? this.products,
        mechanics: mechanics ?? this.mechanics,
        checks: checks ?? this.checks,
        goods: goods ?? this.goods,
        transactions: transactions ?? this.transactions,
        withdrawals: withdrawals ?? this.withdrawals,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['passport-data'] = passportdata;
    map['faqs'] = faqs;
    map['news'] = news;
    map['welcome-screens'] = welcomescreens;
    map['certificates'] = certificates;
    map['notifications'] = notifications;
    map['files'] = files;
    map['tests'] = tests;
    map['promos'] = promos;
    map['products'] = products;
    map['mechanics'] = mechanics;
    map['checks'] = checks;
    map['goods'] = goods;
    map['transactions'] = transactions;
    map['withdrawals'] = withdrawals;
    return map;
  }
}

Promo promoFromJson(String str) => Promo.fromJson(json.decode(str));
String promoToJson(Promo data) => json.encode(data.toJson());

class Promo {
  Promo({
    this.active,
    this.type,
  });

  Promo.fromJson(dynamic json) {
    active = json['active'];
    type = json['type'];
  }
  bool active;
  String type;
  Promo copyWith({
    bool active,
    String type,
  }) =>
      Promo(
        active: active ?? this.active,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = active;
    map['type'] = type;
    return map;
  }
}

Company companyFromJson(String str) => Company.fromJson(json.decode(str));
String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  Company({
    this.feedbackEmail,
    this.companyLogo,
  });

  Company.fromJson(dynamic json) {
    feedbackEmail = json['feedback_email'];
    companyLogo = json['company_logo'] != null
        ? CompanyLogo.fromJson(json['company_logo'])
        : null;
  }
  String feedbackEmail;
  CompanyLogo companyLogo;
  Company copyWith({
    String feedbackEmail,
    CompanyLogo companyLogo,
  }) =>
      Company(
        feedbackEmail: feedbackEmail ?? this.feedbackEmail,
        companyLogo: companyLogo ?? this.companyLogo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feedback_email'] = feedbackEmail;
    if (companyLogo != null) {
      map['company_logo'] = companyLogo.toJson();
    }
    return map;
  }
}

CompanyLogo companyLogoFromJson(String str) =>
    CompanyLogo.fromJson(json.decode(str));
String companyLogoToJson(CompanyLogo data) => json.encode(data.toJson());

class CompanyLogo {
  CompanyLogo({
    this.name,
    this.url,
  });

  CompanyLogo.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;
  CompanyLogo copyWith({
    String name,
    String url,
  }) =>
      CompanyLogo(
        name: name ?? this.name,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}

class ErrorRequestPermission4 extends PermissionModel4 {
  final String error;

  ErrorRequestPermission4({
    this.error,
  });
}
