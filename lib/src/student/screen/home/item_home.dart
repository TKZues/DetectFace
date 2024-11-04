import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

import '../../../../utils/config/size_config.dart';

class ItemHome extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final String logo;
  const ItemHome(
      {super.key,
      required this.title,
      required this.onTap,
      required this.logo});

  @override
  State<ItemHome> createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: psHeight(6), horizontal: psWidth(10)),
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
              children: [
                Image.asset(
                  widget.logo,
                  height: psHeight(120),
                  width: psWidth(120),
                  fit: BoxFit.cover,
                ),
                TextCustom(text: widget.title, fontSize: psHeight(13),fontWeight: FontWeight.w500,)
              ],
            )),
      ),
    );
  }
}
