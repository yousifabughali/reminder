

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';

class CustomHomeScreenCard extends StatelessWidget {
  String nameOnTheCard;
  int count;
  IconData icon;
  Color backgroundColor;
  String navRoute;

  CustomHomeScreenCard(
      {required this.nameOnTheCard,
      required this.count,
      required this.icon,
      required this.backgroundColor,
      required this.navRoute,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, navRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ],
            ),
            Text(
              nameOnTheCard,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
