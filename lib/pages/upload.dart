import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:video_player/video_player.dart';

import '../helpers/env.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadAppState createState() => _UploadAppState();
}

class _UploadAppState extends State<UploadPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // fetching();
  }
  List<MediaFile>? media;

  Future fetching() async {
    media = await GalleryPicker.pickMedia(context: context);
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        media![0].file!.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (media == null) ? Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: TextButton(
            onPressed: () async {
              await fetching();
            },
            child: Text('Select Video', style: TextStyle(color: mutedColor),),
          ),
        ),
      ) : Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}