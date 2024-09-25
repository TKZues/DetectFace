import 'package:flutter/material.dart';

class TextCustom extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize; 
  final FontWeight fontWeight;
  final String fontFamily;
  final double paddingY;
  final double paddingX;
  final int maxLines;
  final TextAlign? textAlign;

  const TextCustom({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 14.0,
    this.paddingX = 0.0,
    this.paddingY = 0.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = "Inter",
    this.maxLines = 2,  this.textAlign
  });

  @override
  State<TextCustom> createState() => _TextCustomState();
}

class _TextCustomState extends State<TextCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: widget.paddingX, vertical: widget.paddingY),
      child: Text(
        widget.text,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: widget.fontSize, 
          color: widget.color, 
          fontFamily: widget.fontFamily,
          fontWeight: widget.fontWeight,
        ),
        textAlign: widget.textAlign,
      ),
    );
  }
}
