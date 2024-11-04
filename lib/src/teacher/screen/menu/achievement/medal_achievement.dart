import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

class MedalAchievement extends StatefulWidget {
  final String title;
  final Color gradientcolor1;
  final Color gradientcolor2;
    final int number;
  const MedalAchievement({super.key, required this.title, required this.gradientcolor1, required this.gradientcolor2, required this.number});

  @override
  State<MedalAchievement> createState() => _MedalAchievementState();
}

class _MedalAchievementState extends State<MedalAchievement> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(psHeight(15)),
          ),
          color: Colors.white,
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: psHeight(20)),
            child: Column(
              children: [
                Container(
                  height: psHeight(40),
                  width: psWidth(40),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:  LinearGradient(
                        colors: [widget.gradientcolor1, widget.gradientcolor2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:  widget.gradientcolor2
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]),
                  child: Center(
                    child: Container(
                      height: psHeight(30),
                      width: psWidth(30),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient:  LinearGradient(
                            colors: [widget.gradientcolor1, widget.gradientcolor2],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.gradientcolor2
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            )
                          ]),
                    ),
                  ),
                ),
                TextCustom(
                  text: widget.title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  paddingY: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: widget.gradientcolor2.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(psHeight(10))),
                  child: TextCustom(
                    text: widget.number.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.gradientcolor2,
                    paddingY: 3,
                    paddingX: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
