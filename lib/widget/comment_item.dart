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
        margin: EdgeInsets.only(bottom: 30, top: 30),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.comment!['user'] != null
                          ? widget.comment!['user']
                          : '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.comment!['message'] != null
                          ? widget.comment!['message']
                          : '',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ))));
  }
}
