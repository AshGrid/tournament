import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:share_plus/share_plus.dart';




class ReelsPage extends StatefulWidget {
  const ReelsPage({Key? key}) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<ReelModel> reelsList = [
    ReelModel(
        'https://www.w3schools.com/html/mov_bbb.mp4',
        'Darshan Patil',
        likeCount: 2000,
        isLiked: true,
        reelDescription: "ABC EVENTS.",
        profileUrl:
        'https://eu2.contabostorage.com/b44117b3116548a1b1703df5e191fd05:abc/images/1c80bcc2_ABC.png',
        ),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
      'Rahul',
      musicName: 'In the name of Love',
      reelDescription: "Life is better when you're laughing.",
      profileUrl:
      'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
    ),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
      'Rahul',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ReelsViewer(
      reelsList: reelsList,
      appbarTitle: 'MEILLEURS MOMENTS',

      onLike: (url) {
        print('Liked reel url ==> $url');
      },
      onFollow: () {
        log('======> Clicked on follow <======');
      },

      onShare: (url) {
        Share.share('check out my website $url');
        print('Shared reel url ==> $url');
      },
      onClickBackArrow: () {
        log('======> Clicked on back arrow <======');
      },
      onIndexChanged: (index){
        log('======> Current Index ======> $index <========');
      },
      showProgressIndicator: true,
      showVerifiedTick: true,
      showAppbar: true,
    );
  }
}