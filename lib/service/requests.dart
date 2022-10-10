import 'dart:io';

import 'package:dio/dio.dart';
import '../components/post.dart';
import '../config/configs.dart';

class HttpRequests {
  static Future<Response> get(String url, Map<String, dynamic> params,
      {String? token}) async {
    Response response = await Dio().get(url,
        queryParameters: params,
        options: Options(headers: {
          "token": token,
        }));
    return response;
  }
}

class WrongPasswordException implements CertificateException {
  String toString() {
    return "[ERROR]: ---Wrong Username or Password---";
  }

  @override
  // TODO: implement message
  String get message => throw UnimplementedError("Wrong Username or Password");

  @override
  // TODO: implement osError
  OSError? get osError => throw UnimplementedError();

  @override
  // TODO: implement type
  String get type => throw UnimplementedError();
}

enum PostType {
  Proficient,
  Feedback,
  UnderLake,
}

class FeedbackAPI {
  FeedbackAPI._privateConstructor();

  static final FeedbackAPI _instance = FeedbackAPI._privateConstructor();

  factory FeedbackAPI() => _instance;

  static const String _BasicUrl = "https://qnhd.twt.edu.cn/api/v1/f/";
  String Token = "";

  Future<Response> get(String path, Map<String, dynamic> params) async {
    return await HttpRequests.get(_BasicUrl + path, params, token: Token);
  }

  Future<void> GetToken() async {
    var usr = Config.username;
    var pas = Config.password;
    try {
      Response response = await get('auth/passwd', {
        "user": usr,
        "password": pas,
      });
      Map<String, dynamic> data = response.data;
      if (data["code"] != 200) {
        throw new WrongPasswordException();
      }
      this.Token = data["data"]["token"];
      print(this.Token);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> GetPost(PostType type, int page, int pageCapacity) async {
    if (this.Token == "") await GetToken();
    try {
      Response response = await get("posts", {
        "type": type.index,
        "search_mode": 0,
        "page_size": pageCapacity,
        "page": page,
      });
      Map<String, dynamic> data = response.data;
      List<Post> postList = [];
      for (int i = 0; i < 10; i++) {
        postList.add(Post.fromJson(
          data["data"]["list"][i],
        ));
      }
      return postList;
    } catch (e) {
      print(e);
    }
  }
}
