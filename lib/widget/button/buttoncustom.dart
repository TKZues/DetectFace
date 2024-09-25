
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {
  final String title;
  final Color colorbtn;
  final Color colortitle;
  final VoidCallback onTap;
  final double paddingX;
  final double paddingY;
  final BoxBorder? boxBorder;
  ButtonCustom(
      {super.key,
      required this.title,
      required this.colorbtn,
      required this.colortitle,
      required this.onTap,
      this.paddingX = 80, this.paddingY = 10,
      // ignore: avoid_init_to_null
      this.boxBorder = null});

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
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
                  offset: const Offset(0, 2))
            ],
            border: widget.boxBorder),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: psWidth(widget.paddingX), vertical: psHeight(widget.paddingY)),
          child: Text(
            widget.title,
            style: TextStyle(
                color: widget.colortitle, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
