import 'package:flutter/material.dart';

class Gauge extends StatefulWidget{
  //인덱스 초기값
  int firstfgi = 0;

  Gauge({Key? key, required this.firstfgi})
    :super(key: key);

  @override
  State<Gauge> createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.95,
      height: MediaQuery.of(context).size.width*0.5,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.blue,
          child: Text(widget.firstfgi.toString()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}