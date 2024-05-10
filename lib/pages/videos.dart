import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import this to be able to call json.decode()
import 'dart:convert';
// import this to easily send HTTP request
import 'package:http/http.dart' as http;

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Future<List> _loadData() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const apiUrl = 'https://jsonplaceholder.typicode.com/posts';

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _loadData(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
          snapshot.hasData
              ? ListView.builder(
            // render the list
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) => Card(
              margin: const EdgeInsets.all(10),
              // render list item
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Text(snapshot.data![index]['title']),
                subtitle: Text(snapshot.data![index]['body']),
              ),
            ),
          )
              : const Center(
            // render the loading indicator
            child: CircularProgressIndicator(),
          ))
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}