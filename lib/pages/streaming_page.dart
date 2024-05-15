import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wakelock/wakelock.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({Key? key}) : super(key: key);

  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  String longVideo = "https://sportsleading.online/live/stream_mlb7.m3u8";
  Map<String, String> headers = {
    "origin": "https://streambtw.com",
    "referer": "https://streambtw.com/",
    "User-Agent": "Mozilla"
  };

  String premiumVideo =
      "https://example.com/premium_video.mp4"; // Replace with your premium video URL
  final bool isLive = true;

  late String selectedSource;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Wakelock.enable(); // Enable wakelock to keep the screen on
    selectedSource = 'Source 1'; // Initialize the selected source
    _initializePlayer(longVideo);
  }

  Future<void> _initializePlayer(String videoUrl) async {
    _videoPlayerController = VideoPlayerController.network(
      videoUrl,
      httpHeaders: headers,
    );
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      fullScreenByDefault: false,
      allowFullScreen: true,
      allowMuting: true,
      autoPlay: true,
      isLive: isLive,
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.redAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightBlue,
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.redAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightBlue,
      ),
      hideControlsTimer: const Duration(seconds: 3),
      showControlsOnInitialize: true,
      showOptions: true,
      controlsSafeAreaMinimum: const EdgeInsets.all(0),
      aspectRatio: 16 / 9,
      customControls: CustomControls(isLive: isLive),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    await _initializePlayer(longVideo);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    Wakelock.disable(); // Disable wakelock when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Stream'),
        backgroundColor: Colors.red,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Chewie(controller: _chewieController),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomControls extends StatelessWidget {
  final bool isLive;

  const CustomControls({super.key, required this.isLive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLive)
          const Positioned.fill(
            child: Align(
              alignment: Alignment(0, 0.9),
              child: MaterialControls(
                  // Add your custom live controls here
                  
                  ),
            ),
          ),
      ],
    );
  }
}
