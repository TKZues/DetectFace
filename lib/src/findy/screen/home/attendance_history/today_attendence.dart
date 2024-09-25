import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

class TodayAttendenceCheckIn extends StatefulWidget {
  final String title;
  final IconData icon;
  final String description;
  final Color iconbackground;
  final String data;
  const TodayAttendenceCheckIn(
      {super.key,
      required this.title,
      required this.icon,
      required this.description,
      required this.iconbackground,
      required this.data});

  @override
  State<TodayAttendenceCheckIn> createState() => _TodayAttendenceCheckInState();
}

class _TodayAttendenceCheckInState extends State<TodayAttendenceCheckIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(psHeight(10)),
      margin: EdgeInsets.all(psHeight(6)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(psHeight(10)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(31, 123, 123, 123),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 2))
          ]),
      width: MediaQuery.of(context).size.width / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: widget.iconbackground.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(psHeight(25)),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconbackground,
                ),
              ),
              SizedBox(width: psWidth(10)),
              // Sử dụng Expanded để làm cho Text co giãn
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: psHeight(14),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      color: AppColor.textGrey),
                  overflow: TextOverflow.ellipsis, // Tránh tràn text
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.data,
              style: TextStyle(
                  fontSize: psHeight(20),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter'),
            ),
          ),
          Text(
            widget.description,
            style: TextStyle(
                fontSize: psHeight(13),
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: AppColor.textGrey),
          ),
        ],
      ),
    );
  }
}
