import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner/spinner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.black,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Spinner(),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton("Spin", () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Spinner(),
              ));
            }),
            // MenuButton("Settings"),
          ],
        ),
      ),
    );
  }
}

Widget MenuButton(String label, Function onClick) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: const LinearGradient(
          transform: GradientRotation(-pi / 1.85),
          colors: [
            Color.fromARGB(198, 230, 50, 227),
            Color.fromARGB(37, 28, 96, 184),
          ],
          stops: [0.2, 0.7],
        ),
      ),
      child: Center(
          child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      )),
    ),
  );
}
