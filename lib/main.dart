import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // for ios full screen splash screen
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  // for android statusbar dark shadow removal
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isStarted = false;
  bool _onPause = false;
  late Stopwatch stopwatch;
  late Timer t;

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;
    String milliseconds = ((milli % 1000) ~/ 10).toString().padLeft(2, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    return "$minutes:$seconds.$milliseconds";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const Expanded(
                  child: Image(
                    image: AssetImage('assets/image1.png'),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: Colors.blueAccent,
                        ),
                      ),
                      child: Text(
                        returnFormattedText(),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _onPause
                            ? GestureDetector(
                                onTap: () {
                                  stopwatch.reset();
                                  _onPause = false;
                                },
                                child: const Icon(
                                  CupertinoIcons.restart,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              )
                            : Container(),
                      ),
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () {
                            if (_isStarted) {
                              stopwatch.stop();
                              _onPause = true;
                            } else {
                              stopwatch.start();
                              _onPause = false;
                            }
                            HapticFeedback.heavyImpact();
                            setState(() {
                              _isStarted = !_isStarted;
                            });
                          },
                          child: _isStarted
                              ? const Icon(
                                  CupertinoIcons.pause_fill,
                                  color: Colors.blueAccent,
                                  size: 50,
                                )
                              : const Icon(
                                  CupertinoIcons.play_fill,
                                  color: Colors.blueAccent,
                                  size: 50,
                                ),
                        ),
                      ),
                      Expanded(
                        child: _isStarted
                            ? GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  CupertinoIcons.flag,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
