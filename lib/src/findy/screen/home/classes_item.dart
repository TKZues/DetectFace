import 'dart:math'; // Import to generate random numbers
import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

class ClassesItem extends StatefulWidget {
  final String monhoc;
  final String giaovien;
  final String? thoigian;
  const ClassesItem({
    super.key,
    required this.monhoc,
    required this.giaovien,
     this.thoigian,
  });

  @override
  State<ClassesItem> createState() => _ClassesItemState();
}

class _ClassesItemState extends State<ClassesItem> {
  // Predefined list of colors and icons
  final List<Color> iconBackgroundColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple
  ];
  final List<IconData> icons = [
    Icons.book,
    Icons.science,
    Icons.computer,
    Icons.history_edu,
    Icons.music_note
  ];

  late Color randomColor;
  late IconData randomIcon;

  @override
  void initState() {
    super.initState();
    // Randomly select a color and an icon
    randomColor =
        iconBackgroundColors[Random().nextInt(iconBackgroundColors.length)];
    randomIcon = icons[Random().nextInt(icons.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: psWidth(15), vertical: psHeight(0)),
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
        ],
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      width: MediaQuery.of(context).size.width / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: psHeight(50),
                width: psWidth(50),
                decoration: BoxDecoration(
                  color: randomColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(psHeight(5)),
                ),
                child: Icon(
                  randomIcon,
                  color: randomColor,
                ),
              ),
              SizedBox(width: psWidth(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.monhoc,
                      style: TextStyle(
                          fontSize: psHeight(14),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.giaovien,
                          style: TextStyle(
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: AppColor.textGrey),
                        ),
                        Text(
                          widget.thoigian??"",
                          style: TextStyle(
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: AppColor.textGrey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
