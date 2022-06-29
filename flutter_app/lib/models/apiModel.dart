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
  String graph;
  double meanwords;
  List mentioned_users;
  String error;

  ApiModel(
      {this.prediction,
      this.username,
      this.meanwords,
      this.mentioned_users,
      this.pic,
      this.wordcloud,
      this.graph});

  ApiModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
      prediction: json["prediction"],
      username: json["username"],
      meanwords: json["meanwords"],
      mentioned_users: json["mentioned_users"],
      pic: json["pic"],
      wordcloud: json["wordcloud"],
      graph: json["graph"]);
  Map<String, dynamic> toJson() => {
        "prediction": prediction,
        "username": username,
        "meanwords": meanwords,
        "mentioned_users": mentioned_users,
        "pic": pic,
        "wordcloud": wordcloud,
        "graph": graph,
      };
}
