import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

class GeneralInformation extends StatelessWidget {
  final String title;
  final String mssv;
  final String name;
  final String birth;
  final String gender;
  final String cccd;
  final String lop;
  const GeneralInformation(
      {super.key,
      required this.mssv,
      required this.name,
      required this.birth,
      required this.gender,
      required this.cccd,
      required this.lop, required this.title});

  @override
  Widget build(BuildContext context) {
    return _buildGeneralInformation(context);
  }

  Widget _buildGeneralInformation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 1),
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
              _item("Mã sinh viên: ",mssv),
              _item( "Họ tên: ",name),
              _item("Ngày sinh: ",birth),
              _item("Giới tính: ",gender),
              _item("CMND/CCCD: ",cccd),
              _item("Lớp sinh viên: ",lop),
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
