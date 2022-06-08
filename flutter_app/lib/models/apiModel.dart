import 'dart:convert';

List<ApiModel> ApiModelFromJson(String str) =>
    List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));
String ApiModelToJson(List<ApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
  String prediction;
  String username;
  String pic;
  String wordcloud;
  String error;

  ApiModel({this.prediction, this.username, this.pic, this.wordcloud});

  ApiModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
      prediction: json["prediction"],
      username: json["username"],
      pic: json["pic"],
      wordcloud: json["wordcloud"]);
  Map<String, dynamic> toJson() => {
        "prediction": prediction,
        "username": username,
        "pic": pic,
        "wordcloud": wordcloud
      };
}
