import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  final comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.comment != null ? const Color(0xff37718E) : Colors.transparent,
        margin: EdgeInsets.only(bottom: 30, top: 30),
        child:
            Column(children: [
              Text(widget.comment.user != null ? widget.comment.user! : '', style: TextStyle(color: Colors.white),),
              Text(widget.comment.message != null ? widget.comment.message! : '', style: TextStyle(color: Colors.white),)
            ],)
    );
  }

}