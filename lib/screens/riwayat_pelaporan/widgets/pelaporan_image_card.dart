import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:video_player/video_player.dart';

class PelaporanImageCard {
  static void showImage(BuildContext context, String url) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.all(8),
              elevation: 0,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Bukti Foto/Video",
                    style: ThemeFont.heading6Medium
                        .copyWith(color: Pallete.secondary),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.network(
                      url,
                    ),
                  ),
                ],
              ),
            ));
  }

  static void showVideo(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(8),
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Bukti Foto/Video",
              style:
                  ThemeFont.heading6Medium.copyWith(color: Pallete.secondary),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: VideoPlayerWidget(videoUrl: url),
            ),
          ],
        ),
      ),
    );
  }

  static FileType getFileType(String url) {
    if (url.toLowerCase().endsWith('.mp4')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('m4v.')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('.mov.')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('.asf.')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('.avi.')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('.wmv.')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('.m2ts.')) {
      return FileType.video;
    } else if (url.toLowerCase().endsWith('.3g2.')) {
      return FileType.video;
    } else {
      return FileType.image;
    }
  }
}

enum FileType { image, video }

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _controller.addListener(() {
      setState(() {});
    });

    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
        IconButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
