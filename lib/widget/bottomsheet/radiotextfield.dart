import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';
import '../../../../../constant/color.dart';

class RadioTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onTap;
  final VoidCallback? onPressclear;
  final String text;
  final String hintText;
  final String error;
  const RadioTextField({
    super.key,
    required this.textEditingController,
    this.onTap,
    required this.text,
    required this.hintText,
    required this.error,
    this.onPressclear,
  });

  @override
  State<RadioTextField> createState() => _RadioTextFieldState();
}

class _RadioTextFieldState extends State<RadioTextField> {
  final bool _isClick = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: psHeight(12),
            fontWeight: FontWeight.w700,
            color: AppColor.topTitle,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          readOnly: true,
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
            widget.onTap;
            setState(() {
              
            });
          },
          decoration: InputDecoration(
              filled: true,
              suffixIcon: widget.textEditingController.text.isEmpty
                  ? IconButton(
                      onPressed: () {
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                        widget.onTap;
                        setState(() {
                          
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.black,
                      ))
                  : IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                      onPressed: widget.onPressclear,
                    ),
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(
                left: 8,
                bottom: 0,
                top: 0,
                right: 15,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: psHeight(12)
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              focusedBorder: _isClick
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(
                      color: AppColor.error,
                      width: 1.5,
                    ))
                  : null),
        ),
        SizedBox(
          height: psHeight(4),
        ),
        AnimatedOpacity(
          opacity: _isClick ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: _isClick
              ? Padding(
                  padding:
                      EdgeInsets.only(left: psWidth(4), bottom: psHeight(2)),
                  child: Text(
                    widget.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
