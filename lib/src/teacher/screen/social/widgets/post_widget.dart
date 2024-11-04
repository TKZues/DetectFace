// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:findy/src/teacher/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import 'package:findy/src/teacher/model/itemblog_model.dart';
import 'package:findy/src/teacher/repositories/itemblog_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/text/textcustom.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';

// ignore: must_be_immutable
class PostWidget extends StatelessWidget {
  int index;
  BlogModel repository;
  PostWidget({
    Key? key,
    required this.index,
    required this.repository,
  }) : super(key: key);

  // final List postItems = [
  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        AssetImage("assets/images/profile/photo-5.jpeg"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    repository.username??"",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/images/verification-badge.png',
                    height: 13,
                  ),
                  Expanded(child: Container()), //Take all space left
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Image.network(
                repository.image ?? "",
                width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.comment_outlined)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.send_outlined)),
                Expanded(child: Container()),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.bookmark_outline)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage:
                      AssetImage("assets/images/profile/photo-5.jpeg"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Liked by ',
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: repository.username,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: ' and '),
                        const TextSpan(
                          text: '225 other persons',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          repository.username ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            repository.description ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'See more',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'See 20 comments',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '4 min ago - ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade400),
                        ),
                        const Text(
                          'translate',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ]),
            )
          ],
        );
      }
  }

