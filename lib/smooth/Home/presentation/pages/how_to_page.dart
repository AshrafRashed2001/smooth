import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:video_player/video_player.dart';

class HowToPage extends StatefulWidget {
  const HowToPage({super.key});

  @override
  State<HowToPage> createState() => _HowToPageState();
}

class _HowToPageState extends State<HowToPage> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
        // ignore: deprecated_member_use
        videoPlayerController: VideoPlayerController.network(
            'https://firebasestorage.googleapis.com/v0/b/smooth-bd82d.appspot.com/o/WhatsApp%20Video%202024-05-17%20at%2015.02.46_868fa4e9.mp4?alt=media&token=57b8d227-2d81-41f5-9fae-1b646a430d28'));
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose(); // هذا سيوقف الفيديو ويتخلص من الموارد.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: const PopWidget(),
        leadingWidth: 70.w,
      ),
      body: Stack(children: [
        Column(
          children: [
            Image.asset('assets/images/_.png'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/images/_ (1).png'),
              ],
            ),
          ],
        ),
        Column(
          children: [
            80.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How to',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.bottomColor),
                ),
              ],
            ),
            Text(
              '?',
              style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.bottomColor),
            ),
            50.heightBox,
            SizedBox(
              height: 200.h,
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
            20.heightBox,
            Text(
              'Watch the video',
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )
          ],
        )
      ]),
    );
  }
}
