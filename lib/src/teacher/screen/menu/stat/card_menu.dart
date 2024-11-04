import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final IconData icon;
  final String number;
  final String title;
  final Color gradientcolor1;
  final Color gradientcolor2;
  final VoidCallback? onTap;

  const CardMenu({
    super.key,
    required this.icon,
    required this.number,
    required this.title,
    required this.gradientcolor1,
    required this.gradientcolor2, required this.onTap,
    
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(psHeight(20)),
          ),
          color: Colors.white,
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.all(psHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: psHeight(30),
                  width: psWidth(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(psHeight(25)),
                    gradient: LinearGradient(
                      colors: [
                        gradientcolor1.withOpacity(0.25),
                        gradientcolor2.withOpacity(0.25)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [gradientcolor1, gradientcolor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: psWidth(10),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: number.toString(),
                      fontSize: psHeight(14),
                      fontWeight: FontWeight.bold,
                    ),
                    TextCustom(
                      text: title,
                      fontSize: psHeight(12),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF9098A3),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
