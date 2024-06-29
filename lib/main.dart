import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:simple_clock/views/screens/custom_clock.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _colonController;
  late Animation<double> _colonAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isRunning = false;
  late String hour, minute, second;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _colonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _colonAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_colonController);

    _controller.addListener(() {
      DateTime now = DateTime.now();
      setState(() {
        hour = now.hour.toString().padLeft(2, '0');
        minute = now.minute.toString().padLeft(2, '0');
        second = now.second.toString().padLeft(2, '0');
        _playTickSound();
      });
    });
  }

  void _playTickSound() async {
    await _audioPlayer.play(AssetSource("audios/tick_tock.mp3"));
  }

  @override
  void dispose() {
    _controller.dispose();
    _colonController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff282d41),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(300, 300),
                    painter: CustomClock(dateTime: DateTime.now()),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 220,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hour,
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      FadeTransition(
                        opacity: _colonAnimation,
                        child: const Text(
                          ":",
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    minute,
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      FadeTransition(
                        opacity: _colonAnimation,
                        child: const Text(
                          ":",
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    second,
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
