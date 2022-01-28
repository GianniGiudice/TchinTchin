import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiniListItem extends StatefulWidget {
  final String? text;

  const MiniListItem({Key? key, required String? this.text}) : super(key: key);

  @override
  _MiniListItemState createState() => _MiniListItemState();
}

class _MiniListItemState extends State<MiniListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.text != null ? const Color(0xff37718E) : Colors.transparent,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child:
        Text(widget.text != null ? widget.text! : '', style: TextStyle(color: Colors.white),));
  }

}