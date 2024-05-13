// import 'dart:convert';
//
// PermissionModel3 permissionModel3FromJson(String str) =>
//     PermissionModel3.fromJson(json.decode(str));
//
// String permissionModel4ToJson(PermissionModel3 data) =>
//     json.encode(data.toJson());
//
// class PermissionModel3 {
//   PermissionModel3({
//     this.data,
//   });
//
//   PermissionModel3.fromJson(dynamic json) {
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Data data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (data != null) {
//       map['data'] = data.toJson();
//     }
//     return map;
//   }
// }
//
// Data dataFromJson(String str) => Data.fromJson(json.decode(str));
//
// String dataToJson(Data data) => json.encode(data.toJson());
//
// class Data {
//   Data({
//     this.id,
//     this.name,
//     this.lastName,
//     this.patronymic,
//     this.email,
//     this.phone,
//     this.city,
//     this.rubBalance,
//     this.pointsBalance,
//     this.officePositionTitle,
//     this.company,
//     this.permissions,
//   });
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     lastName = json['last_name'];
//     patronymic = json['patronymic'];
//     email = json['email'];
//     phone = json['phone'];
//     city = json['city'];
//     rubBalance = json['rub_balance'];
//     pointsBalance = json['points_balance'];
//     officePositionTitle = json['office_position_title'];
//     company =
//         json['company'] != null ? Company.fromJson(json['company']) : null;
//     permissions = json['permissions'] != null
//         ? Permissions.fromJson(json['permissions'])
//         : null;
//   }
//
//   int id;
//   String name;
//   String lastName;
//   String patronymic;
//   String email;
//   String phone;
//   String city;
//   int rubBalance;
//   int pointsBalance;
//   String officePositionTitle;
//   Company company;
//   Permissions permissions;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['last_name'] = lastName;
//     map['patronymic'] = patronymic;
//     map['email'] = email;
//     map['phone'] = phone;
//     map['city'] = city;
//     map['rub_balance'] = rubBalance;
//     map['points_balance'] = pointsBalance;
//     map['office_position_title'] = officePositionTitle;
//     if (company != null) {
//       map['company'] = company.toJson();
//     }
//     if (permissions != null) {
//       map['permissions'] = permissions.toJson();
//     }
//     return map;
//   }
// }
//
// Permissions permissionsFromJson(String str) =>
//     Permissions.fromJson(json.decode(str));
//
// String permissionsToJson(Permissions data) => json.encode(data.toJson());
//
// class Permissions {
//   Permissions({
//     this.passportdata,
//     this.faqs,
//     this.news,
//     this.welcomescreens,
//     this.notifications,
//     this.files,
//     this.tests,
//     this.role,
//     this.promos,
//     this.products,
//     this.mechanics,
//     this.checks,
//     this.goods,
//     this.transactions,
//     this.withdrawals,
//   });
//
//   Permissions.fromJson(dynamic json) {
//     passportdata = json['passport-data'] != null
//         ? json['passport-data'].cast<String>()
//         : [];
//     faqs = json['faqs'] != null ? json['faqs'].cast<String>() : [];
//     news = json['news'] != null ? json['news'].cast<String>() : [];
//     welcomescreens = json['welcome-screens'] != null
//         ? json['welcome-screens'].cast<String>()
//         : [];
//     notifications = json['notifications'] != null
//         ? json['notifications'].cast<String>()
//         : [];
//     files = json['files'] != null ? json['files'].cast<String>() : [];
//     tests = json['tests'] != null ? json['tests'].cast<String>() : [];
//     role = json['role'] != null ? json['role'].cast<String>() : [];
//     promos = json['promos'] != null ? json['promos'].cast<String>() : [];
//     products = json['products'] != null ? json['products'].cast<String>() : [];
//     mechanics =
//         json['mechanics'] != null ? json['mechanics'].cast<String>() : [];
//     checks = json['checks'] != null ? json['checks'].cast<String>() : [];
//     goods = json['goods'] != null ? json['goods'].cast<String>() : [];
//     transactions =
//         json['transactions'] != null ? json['transactions'].cast<String>() : [];
//     withdrawals =
//         json['withdrawals'] != null ? json['withdrawals'].cast<String>() : [];
//   }
//
//   List<String> passportdata;
//   List<String> faqs;
//   List<String> news;
//   List<String> welcomescreens;
//   List<String> notifications;
//   List<String> files;
//   List<String> tests;
//   List<String> role;
//   List<String> promos;
//   List<String> products;
//   List<String> mechanics;
//   List<String> checks;
//   List<String> goods;
//   List<String> transactions;
//   List<String> withdrawals;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['passport-data'] = passportdata;
//     map['faqs'] = faqs;
//     map['news'] = news;
//     map['welcome-screens'] = welcomescreens;
//     map['notifications'] = notifications;
//     map['files'] = files;
//     map['tests'] = tests;
//     map['role'] = role;
//     map['promos'] = promos;
//     map['products'] = products;
//     map['mechanics'] = mechanics;
//     map['checks'] = checks;
//     map['goods'] = goods;
//     map['transactions'] = transactions;
//     map['withdrawals'] = withdrawals;
//     return map;
//   }
// }
//
// Company companyFromJson(String str) => Company.fromJson(json.decode(str));
//
// String companyToJson(Company data) => json.encode(data.toJson());
//
// class Company {
//   Company({
//     this.name,
//     this.description,
//     this.notificationMails,
//     this.feedbackEmail,
//     this.backgroundColor,
//     this.buttonsColor,
//     // this.companiesLogo,
//     // this.companiesFavicon,
//   });
//
//   Company.fromJson(dynamic json) {
//     name = json['name'];
//     description = json['description'];
//     notificationMails = json['notification_mails'];
//     feedbackEmail = json['feedback_email'];
//     backgroundColor = json['background_color'];
//     buttonsColor = json['buttons_color'];
//     // companiesLogo = json['companies_logo'] != null ? CompaniesLogo.fromJson(json['companiesLogo']) : null;
//     // companiesFavicon = json['companies_favicon'] != null ? CompaniesFavicon.fromJson(json['companiesFavicon']) : null;
//   }
//
//   String name;
//   String description;
//   String notificationMails;
//   String feedbackEmail;
//   String backgroundColor;
//   String buttonsColor;
//
//   // CompaniesLogo companiesLogo;
//   // CompaniesFavicon companiesFavicon;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = name;
//     map['description'] = description;
//     map['notification_mails'] = notificationMails;
//     map['feedback_email'] = feedbackEmail;
//     map['background_color'] = backgroundColor;
//     map['buttons_color'] = buttonsColor;
//     // if (companiesLogo != null) {
//     //   map['companies_logo'] = companiesLogo.toJson();
//     // }
//     // if (companiesFavicon != null) {
//     //   map['companies_favicon'] = companiesFavicon.toJson();
//     // }
//     return map;
//   }
// }
//
// // CompaniesFavicon companiesFaviconFromJson(String str) => CompaniesFavicon.fromJson(json.decode(str));
// // String companiesFaviconToJson(CompaniesFavicon data) => json.encode(data.toJson());
// // class CompaniesFavicon {
// //   CompaniesFavicon({
// //     this.name,
// //     this.url,});
// //
// //   CompaniesFavicon.fromJson(dynamic json) {
// //     name = json['name'];
// //     url = json['url'];
// //   }
// //   String name;
// //   String url;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['name'] = name;
// //     map['url'] = url;
// //     return map;
// //   }
// //
// // }
//
// // CompaniesLogo companiesLogoFromJson(String str) => CompaniesLogo.fromJson(json.decode(str));
// // String companiesLogoToJson(CompaniesLogo data) => json.encode(data.toJson());
// // class CompaniesLogo {
// //   CompaniesLogo({
// //     this.name,
// //     this.url,});
// //
// //   CompaniesLogo.fromJson(dynamic json) {
// //     name = json['name'];
// //     url = json['url'];
// //   }
// //   String name;
// //   String url;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['name'] = name;
// //     map['url'] = url;
// //     return map;
// //   }
// //
// // }
//
// class ErrorRequestPermission3 extends PermissionModel3 {
//   final String error;
//
//   ErrorRequestPermission3({
//     this.error,
//   });
// }
