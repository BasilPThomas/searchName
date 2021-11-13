import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final String title;
  final int id;
  final String description;
  final String? profileUrl;

  UserModel(
      {required this.title, required this.description, this.profileUrl,required this.id });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:json['query']['pages'][0]['pageid'],
      description :json['query']['pages'][0]['terms']['description'],
    profileUrl :json['query']['pages'][0]['thumbnail']['source'],
    title : json ['query']['pages'][0]['title'],
    );
  }
  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }
}
