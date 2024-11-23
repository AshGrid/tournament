import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:share_plus/share_plus.dart';

class ReelsPage extends StatefulWidget {
  final List<String> videoPaths;
  final List<String> videoCaptions;
final int currentIndex;
  const ReelsPage({
    Key? key,
    required this.videoPaths,
    required this.videoCaptions,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<ReelModel> reelsList = [];

  @override
  void initState() {
    super.initState();
    _generateReelModels();
  }

  void _generateReelModels() {
    // Start from the specified `currentIndex`
    for (int i = widget.currentIndex; i < widget.videoPaths.length; i++) {
      String videoUrl = widget.videoPaths[i];
      String description = widget.videoCaptions.length > i
          ? widget.videoCaptions[i]
          : 'No caption available';

      reelsList.add(
        ReelModel(
          videoUrl,
          'ABC EVENTS ',
          reelDescription: description,
          profileUrl: 'https://eu2.contabostorage.com/b44117b3116548a1b1703df5e191fd05:abc/images/49afa3de_ABC.png',
        ),
      );
    }

    // Add the remaining reels from the beginning to `currentIndex - 1`
    for (int i = 0; i < widget.currentIndex; i++) {
      String videoUrl = widget.videoPaths[i];
      String description = widget.videoCaptions.length > i
          ? widget.videoCaptions[i]
          : 'No caption available';

      reelsList.add(
        ReelModel(
          videoUrl,
          'ABC EVENTS ',
          reelDescription: description,
          profileUrl: 'https://eu2.contabostorage.com/b44117b3116548a1b1703df5e191fd05:abc/images/49afa3de_ABC.png',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReelsViewer(
      reelsList: reelsList,
      appbarTitle: 'MEILLEURS MOMENTS',

      onShare: (url) {
        //Share.share('check out this video: $url');
        print('Shared reel url ==> $url');
      },
      onClickBackArrow: () {
        log('======> Clicked on back arrow <======');
        Navigator.pop(context); // Navigate back when back arrow is clicked
      },
      onIndexChanged: (index) {
        log('======> Current Index ======> $index <========');

        // Check if the current index is the last one
        if (index == reelsList.length) {
          log('======> Reels ended, returning to previous page <======');
          Navigator.pop(context); // Navigate back immediately when the last reel is reached
        }
      },
      showProgressIndicator: true,
      showVerifiedTick: true,
      showAppbar: true,
    );
  }
}
