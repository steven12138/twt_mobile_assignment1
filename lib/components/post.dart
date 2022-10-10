import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

// 请根据 json 数据里面的项目完善它
class Post {
  Post(
      {required this.id,
      required this.title,
      required this.content,
      required this.nickname,
      required this.level,
      required this.likes,
      required this.comments});

  int id;
  String title = "";
  String content = "";
  String nickname = "";
  int likes = 0;
  int level = 0;
  int comments = 0;

  bool operator ==(Object other) => other is Post && other.id == id;

  String toString() {
    return "id: ${id}; nickname: ${nickname}; title: ${title};";
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        nickname: json["user_info"]["nickname"],
        level: json["user_info"]["level"],
        likes: json["like_count"],
        comments: json["comment_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
