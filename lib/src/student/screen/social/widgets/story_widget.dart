import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  StoryWidget({super.key});

  final List storyItems = [
    {
      "pseudo": 'Khoa học dữ liệu',
      "photo": "assets/images/photo/photo-1.jpeg",
    },
    {
      "pseudo": 'Quản trị kinh doanh',
      "photo": "assets/images/photo/photo-2.jpeg",
    },
    {
      "pseudo": 'Marketing',
      "photo": "assets/images/photo/photo-3.jpeg",
    },
    {
      "pseudo": 'Kế toán - Kiểm toán',
      "photo": "assets/images/photo/photo-4.jpeg",
    },
    {
      "pseudo": 'Ngoại ngữ',
      "photo": "assets/images/photo/photo-5.jpeg",
    },
    {
      "pseudo": 'Thuế',
      "photo": "assets/images/photo/photo-6.jpeg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: storyItems.map((story) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/story-circle.png',
                      height: 70,
                    ),
                    Image.asset(
                      'assets/images/story-circle.png',
                      height: 68,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(story['photo']),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  story['pseudo'],
                  maxLines: 1,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
