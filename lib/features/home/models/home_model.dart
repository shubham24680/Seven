import 'package:seven/app/app.dart';

class HomeModel {
  final String? id;
  final String? type;
  final List<Model>? response;

  const HomeModel({this.id, this.type, this.response});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
      id: json["id"],
      type: json["type"],
      response: json["response"]?.map((e) => Model.fromJson(e)).toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "response": response?.map((e) => e.toJson()).toList()
      };
}
