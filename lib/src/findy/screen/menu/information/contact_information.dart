import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

class ContactInformation extends StatelessWidget {
  final String title;
  final String dantoc;
  final String tongiao;
  final String quocgia;
  final String tinhthanh;
  final String quanhuyen;
  final String didong;
  const ContactInformation(
      {super.key,
       required this.title, required this.dantoc, required this.tongiao, required this.quocgia, required this.tinhthanh, required this.quanhuyen, required this.didong});

  @override
  Widget build(BuildContext context) {
    return _buildContactInformation(context);
  }

  Widget _buildContactInformation(BuildContext context) {
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
              _item("Dân tộc: ",dantoc),
              _item( "Tôn giáo: ",tongiao),
              _item("Quốc gia: ",quocgia),
              _item("Tỉnh thành: ",tinhthanh),
              _item("Quận huyện: ",quanhuyen),
              _item("Di động: ",didong),
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
