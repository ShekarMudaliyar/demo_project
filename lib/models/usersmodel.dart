// To parse this JSON data, do
//
//     final Users = UsersFromJson(jsonString);

import 'dart:convert';

import 'package:demo_project/models/postsmodel.dart';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.id,
    this.name,
    this.avatar,
    this.posts,
  });

  String? id;
  String? name;
  String? avatar;
  List<Post>? posts;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}
