import 'package:flutter/material.dart';

Widget getAlbum(albumImg) {
  return SizedBox(
      height: 55,
      width: 55,
      child: Stack(
        children: [
          Container(
              width: 55,
              height: 60,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black)),
          Center(
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          (albumImg),
                        ),
                        fit: BoxFit.cover))),
          )
        ],
      ));
}

Widget getIcon(icon, size, count) {
  return Column(
    children: [
      Icon(icon, color: Colors.white, size: size),
      const SizedBox(height: 5),
      Text(count, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
    ],
  );
}

////////*****PROFILE IMAGE PART THAT NEED TO BE CHANGED IN LATER TIME */
Widget getProfile(profileImg) {
  return SizedBox(
      height: 55,
      width: 55,
      child: Stack(
        children: [
          Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(profileImg), fit: BoxFit.cover))),
          Positioned(
              left: 18,
              bottom: -5,
              child: Container(
                  width: 20,
                  height: 20,
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFC2D55)),
                  child:
                      const Center(child: Icon(Icons.add, color: Colors.white, size: 15))))
        ],
      ));
}