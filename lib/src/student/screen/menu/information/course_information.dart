import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

class CourseInformation extends StatelessWidget {
  final String title;
  final String course;
  final String type;
  final String person;
  final String phone;
  const CourseInformation(
      {super.key,
   required this.course, required this.type, required this.person, required this.phone, required this.title});

  @override
  Widget build(BuildContext context) {
    return _buildCourseInformation(context);
  }

  Widget _buildCourseInformation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(psHeight(10)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(psHeight(10)),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 133, 155, 218),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(psHeight(6)),
                  child: TextCustom(
                    text: title,
                    fontWeight: FontWeight.bold,
                    fontSize: psHeight(15),
                    paddingY: 10,
                  ),
                ),
              ),
              _item("Khóa học: ",course),
              _item( "Hình thức đào tạo: ",type),
              _item("Cố vấn học tập: ",person),
              _item("Liên hệ cố vấn học tập: ",person),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String infor) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 197, 197, 197), width: 1))),
      child: Padding(
        padding: EdgeInsets.all(psHeight(8)),
        child: Row(
          children: [
            SizedBox(width: psWidth(120),child: TextCustom(text: title)),
            TextCustom(text: infor)
          ],
        ),
      ),
    );
  }
}
