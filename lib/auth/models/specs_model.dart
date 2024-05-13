abstract class DataSpecsModel {}

class DataSpecs extends DataSpecsModel {
  List<SpecsModel> data;
  DataSpecs({this.data});
  factory DataSpecs.fromJson(Map<String, dynamic> json) {
    return DataSpecs(
        data: json['data'] != null
            ? List.from(json['data'])
                .map((e) => SpecsModel.fromJson(e))
                .toList()
            : null);
  }
}

class SpecsModel extends DataSpecsModel {
  int id;
  String name;
  bool many;
  bool select;
  List<SpecsModel> specializations;

  SpecsModel(
      {this.name, this.many, this.id, this.select, this.specializations});

  factory SpecsModel.fromJson(Map<String, dynamic> json, {bool select}) {
    return SpecsModel(
      id: json['id'],
      name: json['name'],
      many: json['many'],
      specializations: json['specializations'] != null
          ? List.from(json['specializations'])
              .map((e) => SpecsModel.fromJson(e))
              .toList()
          : null,
      select: select,
    );
  }
}

class ErrorRequestSpecs extends DataSpecsModel {
  final String error;

  ErrorRequestSpecs({
    this.error,
  });
}
