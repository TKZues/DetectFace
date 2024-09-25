import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/config/size_config.dart';

class StudentCard extends StatefulWidget {
  const StudentCard({super.key});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
      padding:
          EdgeInsets.symmetric(vertical: psHeight(14), horizontal: psWidth(10)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(psHeight(10)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(31, 96, 96, 96),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(flex: 1,child: Image.asset("assets/images/logoufm.jpg"),),
              SizedBox(width: psWidth(2),),
              Expanded(flex: 5,child: TextCustom(text: "BỘ TÀI CHÍNH \n TRƯỜNG ĐẠI HỌC TÀI CHÍNH MARKETING",fontWeight: FontWeight.bold,fontSize: psHeight(10),textAlign: TextAlign.center, ),),
              SizedBox(width: psWidth(2),),
              Expanded(flex: 1,child: Image.asset("assets/images/logobidv.png"),)
            ],
          ),
          TextCustom(text: "THẺ SINH VIÊN", fontWeight: FontWeight.bold,fontSize: psHeight(14),),
          Row(
            children: [
              Expanded(flex: 1,child: Image.network("https://static.vecteezy.com/system/resources/previews/009/399/824/non_2x/sim-card-clipart-design-illustration-free-png.png"),),
              SizedBox(width: psWidth(6),),
              Expanded(flex: 6,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    item("Họ và tên: ", "Ngô Nguyễn Tuấn Kiệt"),
                    item("Ngày sinh: ", "13/06/2003"),
                    item("Lớp: ", "21DTH3"),
                    item("Niên khóa: ", "2022 - 2025"),
                    item("Khoa: ", "Công nghệ thông tin"),
                    item("Ngành: ", "Hệ thống thông tin quản lý"),
                    item("Hiệu lực thẻ: ", "01/2022"),
                    TextCustom(text: "Thẻ có giá trị suốt khóa học", fontWeight: FontWeight.w500,fontSize: psHeight(10),),
                ],
              ),),
              SizedBox(width: psWidth(6),),
              Expanded(flex: 2,child: Column(
                children: [Image.network("https://smilemedia.vn/wp-content/uploads/2022/09/cach-chup-anh-the-dep-e1664379835782.jpg"), 
                Image.network("https://img.freepik.com/free-psd/barcode-illustration-isolated_23-2150584086.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1726704000&semt=ais_hybrid"),
                TextCustom(text: "MSSV: 2121012280", fontWeight: FontWeight.bold,fontSize: psHeight(6),),],
              ),)
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextCustom(text: "01/22",fontSize: psHeight(11),fontWeight: FontWeight.w600,),
              TextCustom(text: "01/28",fontSize: psHeight(11),fontWeight: FontWeight.w600),
              TextCustom(text: "9704 4958 0000 4856 345", fontWeight: FontWeight.bold,fontSize: psHeight(14),),
            ],
          )
        ],
      ),
    );
  }

  Widget item(String title, String description){
    return Row(
      children: [
        TextCustom(text: title, fontWeight: FontWeight.bold,fontSize: psHeight(11),),
        TextCustom(text: description,fontSize: psHeight(11),)
      ],
    );
  }
}
