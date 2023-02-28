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
  Duration? duration = Duration(seconds: 0); // duration
  double value = 0;
  bool isPlaying = false;

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
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
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
                  Text("${(value / 60).floor()} : ${(value % 60).floor()}", style: TextStyle(color: Colors.lightBlueAccent)),
                  Slider.adaptive(
                    onChanged: (value) {},
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    onChangeEnd: (newValue) async {
                      setState(() {
                        value = newValue;
                      });
                      player.pause();
                      await player.seek(Duration(seconds: newValue.toInt()));
                      await player.resume();
                    },
                  ),
                  Text("${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                      )),
                ],
              ),
              const SizedBox(height: 30.0),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(60.0), color: Colors.blueAccent, border: Border.all(color: Colors.lightBlueAccent)),
                child: InkWell(
                  onTap: () async {
                    if (isPlaying) {
                      await player.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await player.resume();
                      setState(() {
                        isPlaying = true;
                      });
                      player.onPositionChanged.listen((position) {
                        setState(() {
                          value = position.inSeconds.toDouble();
                        });
                      });
                    }
                  },
                  child: Icon(
                    isPlaying?Icons.play_arrow:Icons.pause,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
