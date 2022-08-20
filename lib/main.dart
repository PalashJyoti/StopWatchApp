import 'dart:async';
import 'dart:ui';

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
                // const Expanded(
                //   flex: 2,
                //   child: Image(
                //     image: AssetImage('assets/image1.png'),
                //   ),
                // ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
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
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Text(
                                '${index + 1}'.padLeft(2, "0"),
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              trailing: const Text('something'),
                            );
                          }),
                    )),
                Expanded(
                  flex: 1,
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
                            : _isStarted
                                ? GestureDetector(
                                    onTap: null,
                                    child: const Icon(
                                      CupertinoIcons.restart,
                                      color: Colors.grey,
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
                            : _onPause
                                ? GestureDetector(
                                    onTap: null,
                                    child: const Icon(
                                      CupertinoIcons.flag,
                                      color: Colors.grey,
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
