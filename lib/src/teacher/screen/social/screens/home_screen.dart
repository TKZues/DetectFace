import 'package:findy/src/teacher/repositories/itemblog_repositories.dart';
import 'package:findy/src/teacher/screen/social/screens/addblog_screen.dart';
import 'package:findy/src/teacher/screen/social/screens/messages_screen.dart';
import 'package:findy/src/teacher/screen/social/widgets/post_widget.dart';
import 'package:findy/src/teacher/screen/social/widgets/story_widget.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/config/size_config.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});
  static const id = '/';

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<ItemBlogRepositories1>();
      repo.getblog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: context.read<ItemBlogRepositories1>(),
        child: ProgressHUD(
          child: Scaffold(
            //Base Architecture Of Flutter
            //Landing Page
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddBlogScreen(),
                        ));
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesPage(),
                        ));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            body: ConsumerBase<ItemBlogRepositories1>(
              onRepository: (repository) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      StoryWidget(),
                      GridView.builder(
                          itemCount: repository.blogList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: psHeight(1),
                            mainAxisSpacing: psHeight(1),
                            mainAxisExtent: psHeight(400),
                          ),
                          itemBuilder: (context, index) {
                            return PostWidget(
                              index: index,
                              repository: repository.blogList[index],
                            );
                          }),
                    ],
                  ),
                );
              },
              // bottomNavigationBar: BottomNavigationBar(
              //   selectedItemColor: Colors.black,
              //   unselectedItemColor: Colors.grey.shade700,
              //   type: BottomNavigationBarType.fixed,
              //   showSelectedLabels: false,
              //   showUnselectedLabels: false,
              //   items: const [
              //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              //     BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
              //     BottomNavigationBarItem(
              //         icon: Icon(Icons.camera_alt_outlined), label: ''),
              //     BottomNavigationBarItem(
              //         icon: Icon(Icons.shopping_bag_outlined), label: ''),
              //     BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
              //   ],
              // ),
            ),
          ),
        ));
  }
}
