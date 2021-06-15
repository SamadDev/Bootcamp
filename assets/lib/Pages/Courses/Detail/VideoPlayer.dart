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
  static const route = '/VideoPlayerScreen';
  final index;

  VideoPlayerScreen({this.index});

  Widget build(BuildContext context) {
    print(index);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Video(
        videoPlayerController: VideoPlayerController.network(index),
      ),
    );
  }
}
