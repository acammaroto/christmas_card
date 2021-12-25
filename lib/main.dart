import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
//import 'package:path_provider/path_provider.dart';

void main() {
  runApp(ChristmasCardGenerator());
}

class ChristmasCardGenerator extends StatefulWidget {
  @override
  _ChristmasCardGeneratorState createState() => _ChristmasCardGeneratorState();
}

class _ChristmasCardGeneratorState extends State<ChristmasCardGenerator> {
  var bodies = [
    Image.asset('assets/thesantalorian.png'),
    Image.asset('assets/grogu.png'),
    Image.asset('assets/porg-cute.png'),
    Image.asset('assets/porg-mas.png'),
    Image.asset('assets/bb8.png'),
  ];

  var heads = [
    Image.asset('assets/sentence1.png', width: 300),
    Image.asset('assets/sentence2.png', width: 400),
    Image.asset('assets/sentence3.png', width: 300),
    Image.asset('assets/sentence4.png', width: 300),
  ];

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screenshot(
        controller: screenshotController,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/title.png', width: 200)),
                  ),
                ),
                CarouselSlider(
                  items: bodies,
                  options: CarouselOptions(
                    height: 800,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.2,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CarouselSlider(
                      items: heads,
                      options: CarouselOptions(
                        height: 250,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.2,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: () async {
                      screenshotController
                          .capture(delay: const Duration(milliseconds: 10))
                          .then((image) async {
                        if (image != null) {
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final imagePath =
                              await File('${directory.path}/image.png')
                                  .create();
                          await imagePath.writeAsBytes(image);

                          /// Share Plugin
                          await Share.shareFiles([imagePath.path]);
                        }
                      });
                    },
                    backgroundColor: Color.fromRGBO(212, 175, 55, 1),
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
