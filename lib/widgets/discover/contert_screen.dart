import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/widgets/discover/profile_text_style.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  final String? src;

  const ContentScreen({super.key, this.src});

  @override
  createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(widget.src!);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: true,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 16,
                      color: Colors.amber,
                    ),
                    Expanded(
                      child: Chewie(
                        controller: _chewieController!,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 22,
                  left: 18,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        child: Image.asset("images/flash_sale.png"),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: size.width * .55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            ProfileTextStyle(data: "Author Profile Name"),
                            SizedBox(height: 4),
                            ProfileTextStyle(
                                data: "New sweat shirts that glow the winter"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 22,
                  child: CircleAvatar(
                    radius: 24,
                    child: Image.asset("images/whatsapp.png"),
                  ),
                ),
                Positioned(
                  bottom: 85,
                  right: 22,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        child: SvgPicture.asset("images/grid.svg"),
                      ),
                      SizedBox(height: 4),
                      ProfileTextStyle(data: "Grid"),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 170,
                  right: 22,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        child: SvgPicture.asset("images/barcode.svg"),
                      ),
                      SizedBox(height: 4),
                      ProfileTextStyle(data: "Products"),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...')
                ],
              ),
            ),
    );
  }
}
