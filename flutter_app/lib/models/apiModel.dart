import 'dart:convert';

List<ApiModel> ApiModelFromJson(String str) =>
    List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));
String ApiModelToJson(List<ApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
  String prediction;
  String error;

  ApiModel({this.prediction});

  ApiModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        prediction: json["prediction"],
      );
  Map<String, dynamic> toJson() => {
        "prediction": prediction,
      };
}
