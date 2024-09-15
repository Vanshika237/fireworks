import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fireworks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var crossAxisCount = (MediaQuery.of(context).size.width / 32).floor();
    var mainAxisCount = (MediaQuery.of(context).size.height / 32).floor();
    var totalCount = mainAxisCount * crossAxisCount;
    return Scaffold(
        backgroundColor: Colors.black,
        body: GridView.builder(
            itemCount: totalCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount),
            itemBuilder: ((context, index) => const ConfettiView())));
  }
}

class ConfettiView extends StatefulWidget {
  const ConfettiView({super.key});

  @override
  ConfettiViewState createState() => ConfettiViewState();
}

const colors = [
  Colors.yellow,
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.orange,
];

class ConfettiViewState extends State<ConfettiView> {
  var controller = ConfettiController(duration: const Duration(seconds: 1));

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var index = Random().nextInt(7);
    return Stack(
      children: [
        Center(
          child: ConfettiWidget(
            confettiController: controller,
            emissionFrequency: 0.5,
            maxBlastForce: 50,
            blastDirectionality: BlastDirectionality.explosive,
            blastDirection: 0,
            particleDrag: 0.1,
            colors: index == 6 ? colors : [colors[index]],
            minimumSize: const Size(1, 5),
            maximumSize: const Size(1, 10),
          ),
        ),
        Center(
          child: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              controller.play();
            },
            child: const SizedBox(
              height: 32,
              width: 32,
            ),
          ),
        ),
      ],
    );
  }
}
