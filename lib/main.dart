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
  late String hour;
  late String minute;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _controller.addListener(() {
      DateTime now = DateTime.now();
      setState(() {
        hour = now.hour.toString().padLeft(2, '0');
        minute = now.minute.toString().padLeft(2, '0');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            // ElevatedButton(
            //   onPressed: toggleClock,
            //   child: Text(isRunning ? 'Stop' : 'Start'),
            // ),
            Container(
              width: 170,
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
                      fontSize: 45,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    ":",
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    minute,
                    style: const TextStyle(
                      fontSize: 45,
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
