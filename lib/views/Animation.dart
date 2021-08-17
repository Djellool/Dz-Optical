import 'package:flutter/material.dart';

class Slidablewidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onSlided;
  Slidablewidget({@required this.child, @required this.onSlided, Key key})
      : super(key: key);

  @override
  _SlidablewidgetState createState() => _SlidablewidgetState();
}

class _SlidablewidgetState extends State<Slidablewidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
