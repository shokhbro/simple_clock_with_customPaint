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
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void toggleClock() {
    setState(() {
      if (isRunning) {
        _controller.stop();
      } else {
        _controller.repeat();
      }
      isRunning = !isRunning;
    });
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
            const Text(
              "Rolex Watch",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
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
            ElevatedButton(
              onPressed: toggleClock,
              child: Text(isRunning ? 'Stop' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}
