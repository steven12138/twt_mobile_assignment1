import 'package:flutter/material.dart';
import 'package:twt_mobile_assignment1/service/requests.dart';
import './components/post.dart';
import './components/post_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple WpyBBS",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int length = 2;

  // 这个后面要自己改
  List<Post> postList = [
    Post(
        id: 10010,
        title: "test",
        content: "test",
        nickname: "test",
        level: 5,
        likes: 1,
        comments: 3),
    Post.fromJson({
      "id": 107527,
      "created_at": "2022-10-07T23:18:17.537544+08:00",
      "uid": 16226,
      "type": 2,
      "campus": 0,
      "solved": 0,
      "title": "关于10月8日-9日点对点615公交车增发车辆的通知",
      "content":
          "亲爱的同学们，经学校与天津市公交集团紧急沟通，明日（周六）点对点615公交车，增设上午10:30车辆1个，下午14:00车辆1个，晚上20:00车辆3个。后天（周日）在周六的基础上，再增设上午10:30车辆1个。具体详见预约系统。望周知。感谢理解和支持。\n同时，请同学们自觉遵守乘车预约制，排队有序上车，全程佩戴口罩，做好个人防护。若有不遵守乘车规定的，倒买倒卖乘车资格的，欢迎同学们举报，举报信息发送至xuegongbu@tju.edu.cn，学校定将严肃处理！",
      "nickname": "点对点615公交车",
      "fav_count": 1,
      "like_count": 18,
      "rating": 0,
      "value": 1,
      "e_tag": "top",
      "commentable": true,
      "tag": null,
      "floors": null,
      "comment_count": 6,
      "image_urls": [],
      "department": null,
      "is_like": false,
      "is_dis": false,
      "is_fav": false,
      "is_owner": false,
      "visit_count": 35,
      "user_info": {
        "nickname": "点对点615公交车",
        "avatar": "2ce9e2ec701ccec30aa788173c65f704.jpg",
        "level_name": "",
        "level": 2,
        "next_level_point": 6,
        "cur_level_point": 3
      },
      "is_deleted": false
    }),
    Post(
        id: 10011,
        title: "test",
        content: "test",
        nickname: "test",
        level: 5,
        likes: 1,
        comments: 2),
  ];

  Future<void> _refresh(PostType type, int page, int capacity) async {
    debugPrint("Refreshing-----!-----!-----");
    var list = await FeedbackAPI().GetPost(
      type,
      page,
      capacity,
    );
    setState(() => postList = list);
  }

  @override
  Widget build(BuildContext context) {
    _refresh(PostType.UnderLake, 0, 10);

    var CardList = ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: <Widget>[
        Text(
          '\n这就是个示例项目，请打开wpy_service看看吧\n我们最终要实现一个简易版的仅可读的微北洋论坛\n'
          '你需要完整地写好卡片的ui，并补充好网络请求部分，\n最后以合适的方式实现数据的获取\n'
          '遇到困难的时候请尽可能前往工作室寻求帮助\n',
        ),
        ...List.generate(postList.length, (index) => PostCard(postList[index]))
      ],
    );

    var cardListBuild = RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          print('get');
          await _refresh(PostType.Proficient, 0, 10);
        },
        child: CardList);

    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () async => await _refresh(PostType.UnderLake, 0, 10),
      ),
      appBar: AppBar(
        title: Text("Simple BBS"),
      ),
      body: SafeArea(
        child: cardListBuild,
      ),
    );
  }
}
