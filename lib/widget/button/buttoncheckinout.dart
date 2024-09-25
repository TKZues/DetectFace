
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

class ButtonCheckInOut extends StatefulWidget {
  final String title;
  final Color colorbtn;
  final Color colortitle;
  final VoidCallback onTap;
 const ButtonCheckInOut({super.key, required this.title, required this.colorbtn, required this.colortitle, required this.onTap});

  @override
  State<ButtonCheckInOut> createState() => _ButtonCheckInOutState();
}

class _ButtonCheckInOutState extends State<ButtonCheckInOut> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(psHeight(10)),
          color: widget.colorbtn,
          boxShadow: [
            BoxShadow(
              color: widget.colorbtn.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 2)
            )
          ]
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: psWidth(80), vertical: psHeight(15)),
          child: Text(widget.title, style: TextStyle(color: widget.colortitle,fontWeight: FontWeight.bold, fontSize: psHeight(14)),),
        ),
      ),
    );
  }
}