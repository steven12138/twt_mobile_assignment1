import 'package:flutter/material.dart';
import 'package:twt_mobile_assignment1/components/post.dart';
import '../service/requests.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard(this.post, {Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  void _CardOnClick() {
    print("start web requests");
    var ls = FeedbackAPI().GetPost(PostType.Proficient, 0, 10);
    ls.then((item) {
      print(item);
    });
  }

  Container _act(Icon ico, int value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ico,
          Text(value.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var SenderInfo = Row(
      children: [
        //Avatar
        CircleAvatar(
          child: Text(widget.post.nickname.substring(0, 2)),
        ),

        //TextInfoArea
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.nickname,
                textScaleFactor: 1.3,
              ),
              Text(
                "Level ${widget.post.level.toString()}",
                textScaleFactor: 0.8,
              ),
            ],
          ),
        ),

        //ID
        Spacer(),
        Text(
          "#MP${widget.post.id}",
          style: TextStyle(color: Colors.black26),
        ),
      ],
    );

    var ContentArea = Container(
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.all(20),
      child: Text(
        widget.post.content,
        textScaleFactor: 1.05,
      ),
    );

    var ActionBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _act(Icon(Icons.comment), widget.post.comments),
        _act(Icon(Icons.thumb_up), widget.post.likes),
      ],
    );

    return Card(
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SenderInfo,
              ContentArea,
              ActionBar,
            ],
          ),
        ));
  }
}
