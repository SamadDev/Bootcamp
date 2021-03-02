import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  Video({
    this.videoPlayerController,
  });

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        looping: true,
        aspectRatio: 1.4,
        allowFullScreen: true,
        allowMuting: true,
        autoInitialize: true);
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

class VideoPlayerScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Video(
        videoPlayerController: VideoPlayerController.network(
            "https://firebasestorage.googleapis.com/v0/b/teastea-29af1.appspot.com/o/Estate%20-%20A%20Property%20Real%20Estate%20App%20Template_2.mp4?alt=media&token=91b9f033-826f-4c13-8b67-655b15c20796"),
      ),
    );
  }
}
