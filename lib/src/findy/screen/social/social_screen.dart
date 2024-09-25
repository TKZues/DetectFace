import 'package:carousel_slider/carousel_slider.dart';
import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/repositories/itemblog_repositories.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'https://ueh.edu.vn/images/upload/thumbnail/ueh-thumbnail-100936-062922.jpg',
    'https://wallpapers.com/images/featured/green-landscape-s287v90a9xykt123.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/022/897/701/small/3d-wallpaper-window-landscape-nature-detailed-colored-generative-ai-photo.jpg',
    'https://wallpapers-clan.com/wp-content/uploads/2024/07/beautiful-landscape-desktop-wallpaper-preview.jpg',
  ];

  final List<String> itemList = [
    'Hot News',
    'Sport',
    'Health',
    'Environment',
    'Sport',
    'Health',
    'Environment'
  ];

  // Tạo danh sách imageSliders dựa trên imgList
  List<Widget> get imageSliders => imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                children: [
                  Image.network(item, fit: BoxFit.cover, width: 1200),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding:  EdgeInsets.symmetric(
                            vertical: psHeight(10), horizontal: psWidth(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: psWidth(6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(psHeight(10))),
                                child: TextCustom(
                                  text: "Environment",
                                  color: AppColor.indicatorGreen,
                                  paddingX: 6,
                                  paddingY: 4,
                                  fontSize: psHeight(10),
                                ),
                              ),
                              SizedBox(
                                height: psHeight(4),
                              ),
                              const TextCustom(
                                text:
                                    "Mastering Off Grid Solar System: The Ultimate Guide to Energy Independence",
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: psHeight(4),
                              ),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(psHeight(20)),
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                      width: psWidth(40),
                                      height: psHeight(40),
                                    ),
                                  ),
                                  TextCustom(
                                    text: "Tikay",
                                    color: Colors.white,
                                    fontSize: psHeight(12),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ))
      .toList();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<ItemBlogRepositories>();
      repo.getitemBlog();
      repo.getblog("66e15f0a23f3cc6c718a9f3e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<ItemBlogRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          appBar: GFAppBar(
            backgroundColor: AppColor.appbarColor,
            centerTitle: true,
            title: TextCustom(
              text: "Confession",
              color: Colors.white,
              fontSize: psHeight(16),
            ),
            actions: <Widget>[
              GFIconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: psHeight(16),
                ),
                onPressed: () {},
                type: GFButtonType.transparent,
              ),
            ],
          ),
          body: ConsumerBase<ItemBlogRepositories>(
            onRepository: (rp) {
              return Column(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                      viewportFraction: 0.98,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: psWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: psWidth(15),
                            height: psHeight(3),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : AppColor.indicatorGreen)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: psWidth(10)),
                    width: double.maxFinite,
                    height: psHeight(30),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: psWidth(6), vertical: psHeight(2)),
                            margin:
                                EdgeInsets.symmetric(horizontal: psWidth(6)),
                            decoration: BoxDecoration(
                                color: AppColor.indicatorGreen,
                                borderRadius:
                                    BorderRadius.circular(psHeight(15))),
                            child: TextCustom(
                              text: rp.itemblogList[index].itemblogName ?? "",
                              color: Colors.white,
                              paddingX: 6,
                              paddingY: 4,
                              fontSize: psHeight(10),
                            ),
                          ),
                        );
                      },
                      itemCount: rp.itemblogList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: psWidth(6), vertical: psHeight(6)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(psHeight(15)),
                                    child: Image.network(
                                      rp.blogList[index].image??"",
                                      fit: BoxFit.cover,
                                      width: psWidth(80),
                                      height: psHeight(80),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      psHeight(20)),
                                              child: Image.asset(
                                                "assets/images/avatar.png",
                                                width: psWidth(20),
                                                height: psHeight(20),
                                              ),
                                            ),
                                            SizedBox(
                                              width: psWidth(4),
                                            ),
                                            TextCustom(
                                              text: rp.blogList[index].author??"",
                                              fontSize: psHeight(12),
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.textDefault,
                                            )
                                          ],
                                        ),
                                        TextCustom(
                                          text:
                                              rp.blogList[index].title??"",
                                          fontSize: psHeight(12),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        TextCustom(
                                          text:
                                              rp.blogList[index].description??"",
                                          fontSize: psHeight(10),
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: psWidth(10)),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.save_outlined)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: rp.blogList.length,
                      scrollDirection: Axis.vertical,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
