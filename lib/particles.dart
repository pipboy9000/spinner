import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spinner/sensors.dart';

class CirclePainter extends CustomPainter {
  final double xPosition;

  CirclePainter(this.xPosition);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(xPosition, size.height / 2), 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Particles extends StatefulWidget {
  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> with SingleTickerProviderStateMixin {
  List<Particle> particles = [];

  late final Ticker _ticker;
  late Duration lastFrameTime = Duration.zero;
  int dt = 0;

  late double width, height;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;

      for (int i = 0; i < 80; i++) {
        double x = Random().nextDouble() * MediaQuery.of(context).size.width;
        double y = Random().nextDouble() * MediaQuery.of(context).size.height;
        double mx = (x - (width / 2)) / width * 5;
        double my = (y - (height / 2)) / height * 5;

        particles.add(Particle(
          x: x,
          y: y,
          mx: mx,
          my: my,
        ));
      }
    });

    _ticker = createTicker((elapsed) {
      move(dt);

      setState(() {
        dt = elapsed.inMilliseconds - lastFrameTime.inMilliseconds;
        lastFrameTime = elapsed;
      });
      // print(dt);
    });

    _ticker.start();
  }

  move(int dt) {
    //move particles;
    setState(() {
      for (var p in particles) {
        p.x += p.mx;
        p.y += p.my;

        p.mx *= 0.995;
        p.my *= 0.995;

        if (p.x > width) {
          p.x = width;
          p.mx *= -0.8;
        }

        if (p.x < 0) {
          p.x = 0;
          p.mx *= -0.8;
        }

        if (p.y > height) {
          p.y = height;
          p.my *= -0.8;
        }

        if (p.y < 0) {
          p.y = 0;
          p.my *= -0.8;
        }

        if (p.mx.abs() < 0.05) p.mx = 0;
        if (p.my.abs() < 0.05) p.my = 0;

        p.my += 0.2;
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var acc = Sensors().getAcc();
    print(acc);

    return CustomPaint(
      painter: ParticlesPainter(particles),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  List<Particle> particles;

  Paint particlePaint = Paint()..color = Colors.red;
  Paint overlay = Paint()..color = const Color.fromARGB(85, 0, 0, 0);
  Paint bgPaint = Paint()..color = Colors.black;

  ParticlesPainter(this.particles) {
    bgPaint.blendMode = BlendMode.multiply;
  }

  bool first = true;

  @override
  void paint(Canvas canvas, Size size) {
    if (first) {
      canvas.drawRect(Rect.largest, bgPaint);
      first = false;
    }
    for (var p in particles) {
      canvas.drawCircle(Offset(p.x, p.y), 10, particlePaint);
    }

    canvas.drawRect(Rect.largest, overlay);
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}

class Particle {
  double x, y, mx, my;

  Particle({required this.x, required this.mx, required this.y, required this.my});
}
