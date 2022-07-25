import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/watch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                const Expanded(
                  child: Watch(),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.restart,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.play_fill,
                            color: Colors.blueAccent,
                            size: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.flag,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
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
