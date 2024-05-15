import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({Key? key});

  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  String longVideo = "https://sportsleading.online/live/stream_f1.m3u8";
  Map<String, String> headers = {
    "origin": "https://streambtw.com",
    "referer": "https://streambtw.com/",
    "User-Agent": "Mozilla"
  };

  String premiumVideo =
      "https://example.com/premium_video.mp4"; // Replace with your premium video URL
  final bool isLive = true;

  late String selectedSource;

  @override
  void initState() {
    super.initState();

    selectedSource = 'Source 1'; // Initialize the selected source
    _initializePlayer(longVideo);
  }

  void _initializePlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(
      httpHeaders: headers,
      videoUrl,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      fullScreenByDefault: false,
      allowFullScreen: true,
      allowMuting: true,
      autoPlay: true,
      isLive: true,
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightBlue,
      ),
      hideControlsTimer: const Duration(seconds: 3),
      transformationController: TransformationController(),
      draggableProgressBar: true,
      aspectRatio: 16 / 9,
      showControlsOnInitialize: true,
      showControls: true,
      showOptions: true,
      controlsSafeAreaMinimum: const EdgeInsets.all(0),
      maxScale: double.infinity,
      customControls: const CupertinoControls(
        backgroundColor: Colors.blueAccent,
        iconColor: Colors.white,
        showPlayButton: true,
      ),
      looping: true,
      zoomAndPan: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Stream'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Chewie(controller: _chewieController),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Get.to(MatchDetailsPage(
                  //   matchDetails: MatchDetails(
                  //     matchId: 1,
                  //     tournamentName: 'NBA',
                  //     team1Name: '',
                  //     team2Name: '',
                  //     team1Score: 0,
                  //     team2Score: 0,
                  //     isLive: isLive,
                  //     date: DateTime.now(),
                  //     matchNumber: '1/20',
                  //   ),
                  // ));
                },
                child: const Text('Match Details'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _initializePlayer(longVideo);
                      setState(() {
                        selectedSource = 'Source 1';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedSource == 'Source 1'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: const Text('Source 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _initializePlayer(longVideo);
                      setState(() {
                        selectedSource = 'Source 2';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedSource == 'Source 2'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: const Text('Source 2'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _initializePlayer(longVideo);
                      setState(() {
                        selectedSource = 'Source 3';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedSource == 'Source 3'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: const Text('Source 3'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _initializePlayer(premiumVideo);
                      setState(() {
                        selectedSource = 'Premium';
                      });
                    },
                    icon: const Icon(Icons.star),
                    label: const Text('Premium'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedSource == 'Premium' ? Colors.blue : Colors.grey,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}






// // pages/streaming_page.dart

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:better_player/better_player.dart';
// import '../models/server.dart';

// const Color windowBackground = Color(0xFF070d17);
// const Color cardColor = Color(0xFF182035);
// const Color red = Color(0xFFED2044);

// class StreamingPage extends StatefulWidget {
//   final Server server;

//   const StreamingPage({Key? key, required this.server}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _StreamingPageState();
// }

// class _StreamingPageState extends State<StreamingPage> {
//   late BetterPlayerController _betterPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: windowBackground,
//       body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: Stack(
//           children: [
//             if (_betterPlayerController != null)
//               BetterPlayer(controller: _betterPlayerController),
//             Positioned(
//               top: 16,
//               left: 16,
//               child: GestureDetector(
//                 onTap: () {
//                   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//                       overlays: SystemUiOverlay.values);
//                   SystemChrome.setPreferredOrientations([
//                     DeviceOrientation.landscapeRight,
//                     DeviceOrientation.landscapeLeft,
//                     DeviceOrientation.portraitUp,
//                     DeviceOrientation.portraitDown,
//                   ]);
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   height: 36,
//                   width: 36,
//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(Icons.close, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     _betterPlayerController.dispose(); // Dispose the controller
//     super.dispose();
//   }

//   void _initializePlayer() {
//     BetterPlayerDataSource? betterPlayerDataSource;

//     if (widget.server.headers.containsKey("token")) {
//       // Token-based DRM
//       BetterPlayerDrmConfiguration drmConfiguration =
//           BetterPlayerDrmConfiguration(
//         drmType: BetterPlayerDrmType.token,
//         token: widget.server.headers["token"]!,
//       );

//       betterPlayerDataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         widget.server.url,
//         drmConfiguration: drmConfiguration,
//       );
//     } else {
//       // Regular video without DRM
//       betterPlayerDataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         widget.server.url,
//         headers: widget.server.headers,
//       );
//     }

//     _betterPlayerController = BetterPlayerController(
//       BetterPlayerConfiguration(
//         aspectRatio: 16 / 9,
//         autoPlay: true,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           loadingColor: red,
//           enableFullscreen: false,
//         ),
//       ),
//       betterPlayerDataSource: betterPlayerDataSource!,
//     );

//     _betterPlayerController
//         .setupDataSource(betterPlayerDataSource!)
//         .then((value) {
//       if (kDebugMode) {
//         print("Data source setup successfully");
//       }
//     }).catchError((error) {
//       if (kDebugMode) {
//         print("Error setting up data source: $error");
//       }
//     });
//   }
// }







// import 'package:flutter/material.dart';

// class StreamingPage extends StatefulWidget {
//   const StreamingPage({super.key});

//   @override
//   State<StreamingPage> createState() => _StreamingPageState();
// }

// class _StreamingPageState extends State<StreamingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
