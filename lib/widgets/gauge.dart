import 'package:flutter/material.dart';
import 'package:my_fng/widgets/needle.dart';

class Gauge extends StatefulWidget{
  //인덱스 초기값
  final int firstfgi;

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
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.95,
          height: MediaQuery.of(context).size.width*0.95*0.4,
          //color: Colors.green,
          child: Transform.rotate(
            angle: (widget.firstfgi*1.8-90) * (3.14159 / 180.0),//Tween(begin: 0.25, end: 0.75).animate(_controller),
            alignment: Alignment.bottomCenter,
            /*
            child: Container(
              width: MediaQuery.of(context).size.width*0.1,
              height: MediaQuery.of(context).size.width*0.1,
              color: Colors.blue,
              child: Text(widget.firstfgi.toString(), textAlign: TextAlign.center,),
            ),
            */
            child: CustomPaint(
              painter: GaugeNeedle(),
            ),
            
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}