import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';

class BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.bottomSheet,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Home', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.white),
            title: Text('Groups', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.more_horiz, color: Colors.white),
            title: Text('More', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}