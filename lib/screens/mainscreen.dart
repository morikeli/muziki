import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final player = AudioPlayer(); // creates an instance of the music player
  Duration? duration; // duration
  void initPlayer() async {
    await player.setSource(AssetSource("appetitan.mp3"));
    duration = await player.getDuration();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg-images/headphones.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 7.0),
              child: Container(color: Colors.transparent),
            ),
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: const Image(image: AssetImage("assets/bg-images/headphones.jpg"), width: 150.0),
              ),
              const SizedBox(height: 50.0),
              const Text("Muziki vibes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 7.0,
                    color: Colors.white,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("00:00", style: TextStyle(color: Colors.lightBlueAccent)),
                  Slider.adaptive(
                    value: 0,
                    onChanged: (value) {},
                  ),
                  Text("${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
