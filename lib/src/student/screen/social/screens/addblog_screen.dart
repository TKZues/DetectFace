import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/button/buttoncustom.dart';
import '../../../../../widget/text/textcustom.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  XFile? _image; // Biến để lưu ảnh đã chọn
// Biến để lưu caption
  // Phương thức để chọn ảnh
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Mở thư viện ảnh để chọn ảnh
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // Cập nhật trạng thái với ảnh đã chọn
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: KeyboardDismisser(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? Image.file(
                      File(_image!.path),
                      width: psWidth(200),
                      fit: BoxFit.cover,
                    )
                  : Text('Chưa có ảnh nào được chọn'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ButtonCustom(
                  title: " Chọn ảnh",
                  colorbtn: AppColor.btncheckin,
                  colortitle: AppColor.kGreen,
                  onTap: () async {
                    _pickImage();
                  },
                  paddingX: 100,
                  paddingY: 12,
                ),
              ),
              SizedBox(height: psHeight(20),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  maxLines: 5,
                  onChanged: (value) {
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nhập Caption',
                    hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: psHeight(14),
                      color: AppColor.textGrey
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GFAppBar _buildAppBar() {
    return GFAppBar(
      backgroundColor: AppColor.appbarColor,
      centerTitle: true,
      leading: GFIconButton(
        icon: Container(
          padding: EdgeInsets.symmetric(
            horizontal: psWidth(3),
            vertical: psHeight(4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(psHeight(4)),
            color: AppColor.backgbackColor,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.backiconColor,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        type: GFButtonType.transparent,
      ),
      title: TextCustom(
        text: "Tạo bài viết mới",
        color: AppColor.textDefault,
        fontSize: psHeight(16),
      ),
      actions: <Widget>[
        GFIconButton(
          icon: Icon(
            Icons.favorite,
            color: AppColor.textDefault,
            size: psHeight(16),
          ),
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
      ],
    );
  }
}
