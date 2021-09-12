import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.id,
    this.author,
    this.title,
    this.body,
  });

  String? id;
  String? author;
  String? title;
  String? body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "body": body,
      };
}
