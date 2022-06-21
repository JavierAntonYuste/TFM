import 'package:flutter_app/models/apiModel.dart';

class CompareArguments {
  final String otherUsername;
  final ApiModel prediction;

  CompareArguments(this.otherUsername, this.prediction);
}
