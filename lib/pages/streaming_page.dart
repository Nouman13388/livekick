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

import 'package:flutter/material.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({super.key});

  @override
  State<StreamingPage> createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
