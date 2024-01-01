import 'package:flutter/material.dart';
import 'package:my_fng/widgets/needle.dart';

class Gauge extends StatefulWidget{
  //인덱스 초기값
  final int firstfgi;
  final int secondfgi;

  Gauge({
      Key? key, 
      required this.firstfgi,
      required this.secondfgi,
    }):super(key: key);

  @override
  State<Gauge> createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween(
      begin: (widget.firstfgi*1.8-90) * (3.14159 / 180.0), 
      end: (widget.secondfgi*1.8-90) * (3.14159 / 180.0)).animate(
        CurvedAnimation(
          parent: _controller, 
          curve: Curves.easeInOut
        )
      );
    _controller.forward();
  }

    @override
  void didUpdateWidget(covariant Gauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.firstfgi != oldWidget.firstfgi || widget.secondfgi != oldWidget.secondfgi) {
      // firstfgi 또는 secondfgi가 변경되면 애니메이션 업데이트
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.duration = Duration(seconds: 2);

    _animation = Tween(
      begin: (widget.firstfgi * 1.8 - 90) * (3.14159 / 180.0),
      end: (widget.secondfgi * 1.8 - 90) * (3.14159 / 180.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.width*0.95*0.4,
              //color: Colors.green,
              child: Transform.rotate(
                angle: _animation.value,//(widget.firstfgi*1.8-90) * (3.14159 / 180.0),//Tween(begin: 0.25, end: 0.75).animate(_controller),
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
            );
          },
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