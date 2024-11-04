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
    Colors.purple,
    const Color(0xFF257180),
    const Color(0xFFF2E5BF),
    const Color(0xFFFD8B51),
    const Color(0xFF72BF78),
    const Color(0xFF78B7D0),
    const Color(0xFF009FBD),
    const Color(0xFFB1AFFF),
    const Color(0xFF740938),
    const Color(0xFF384B70),
    const Color(0xFFC96868),
    const Color(0xFF799351),
    const Color(0xFFA94438),
    const Color(0xFFFF8F8F),
    const Color(0xFF9ADE7B),
    const Color(0xFFCE5A67),
    const Color(0xFF219C90),
    const Color(0xFFCECE5A),
    const Color(0xFFFF6D60),
    const Color(0xFFFF597B),
  ];
  final List<IconData> icons = [
    Icons.book,
    Icons.science,
    Icons.computer,
    Icons.history_edu,
    Icons.music_note,
    Icons.accessibility_new_sharp,
    Icons.account_tree_rounded,
    Icons.adobe_sharp,
    Icons.align_vertical_bottom_rounded,
    Icons.wordpress,
    Icons.width_wide_rounded
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
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: AppColor.textGrey),
                        ),
                        Text(
                          widget.thoigian ?? "",
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

class SubjectItem extends StatefulWidget {
  final String tensubject;
  final String roomID;
  final String thoigian;
  const SubjectItem({
    super.key,
    required this.tensubject,
    required this.roomID,
    required this.thoigian,
  });

  @override
  State<SubjectItem> createState() => _SubjectItemState();
}

class _SubjectItemState extends State<SubjectItem> {
  // Predefined list of colors and icons
  final List<Color> iconBackgroundColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    const Color(0xFF257180),
    const Color(0xFFF2E5BF),
    const Color(0xFFFD8B51),
    const Color(0xFF72BF78),
    const Color(0xFF78B7D0),
    const Color(0xFF009FBD),
    const Color(0xFFB1AFFF),
    const Color(0xFF740938),
    const Color(0xFF384B70),
    const Color(0xFFC96868),
    const Color(0xFF799351),
    const Color(0xFFA94438),
    const Color(0xFFFF8F8F),
    const Color(0xFF9ADE7B),
    const Color(0xFFCE5A67),
    const Color(0xFF219C90),
    const Color(0xFFCECE5A),
    const Color(0xFFFF6D60),
    const Color(0xFFFF597B),
  ];
  final List<IconData> icons = [
    Icons.book,
    Icons.science,
    Icons.computer,
    Icons.history_edu,
    Icons.music_note,
    Icons.accessibility_new_sharp,
    Icons.account_tree_rounded,
    Icons.adobe_sharp,
    Icons.align_vertical_bottom_rounded,
    Icons.wordpress,
    Icons.width_wide_rounded
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
          EdgeInsets.symmetric(horizontal: psWidth(15), vertical: psHeight(10)),
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
                      widget.tensubject,
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
                          widget.roomID,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: AppColor.textGrey),
                        ),
                        Text(
                          widget.thoigian ?? "",
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

class StudentItem extends StatefulWidget {
  final String tensv;
  final String email;
  const StudentItem({
    super.key,
    required this.tensv,
    required this.email,
  });

  @override
  State<StudentItem> createState() => _StudentItemState();
}

class _StudentItemState extends State<StudentItem> {
  // Predefined list of colors and icons
  final List<Color> iconBackgroundColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    const Color(0xFF257180),
    const Color(0xFFF2E5BF),
    const Color(0xFFFD8B51),
    const Color(0xFF72BF78),
    const Color(0xFF78B7D0),
    const Color(0xFF009FBD),
    const Color(0xFFB1AFFF),
    const Color(0xFF740938),
    const Color(0xFF384B70),
    const Color(0xFFC96868),
    const Color(0xFF799351),
    const Color(0xFFA94438),
    const Color(0xFFFF8F8F),
    const Color(0xFF9ADE7B),
    const Color(0xFFCE5A67),
    const Color(0xFF219C90),
    const Color(0xFFCECE5A),
    const Color(0xFFFF6D60),
    const Color(0xFFFF597B),
  ];
  final List<IconData> icons = [
    Icons.book,
    Icons.science,
    Icons.computer,
    Icons.history_edu,
    Icons.music_note,
    Icons.accessibility_new_sharp,
    Icons.account_tree_rounded,
    Icons.adobe_sharp,
    Icons.align_vertical_bottom_rounded,
    Icons.wordpress,
    Icons.width_wide_rounded
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
          EdgeInsets.symmetric(horizontal: psWidth(15), vertical: psHeight(10)),
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
                      widget.tensv,
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
                          widget.email,
                          overflow: TextOverflow.ellipsis,
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
