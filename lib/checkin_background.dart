import 'package:carousel_slider/carousel_slider.dart';
import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/screen/login/login_screen.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/button/buttoncustom.dart';
import 'package:flutter/material.dart';

class CheckinBackground extends StatefulWidget {
  const CheckinBackground({super.key});

  @override
  State<CheckinBackground> createState() => _CheckinBackgroundState();
}

class _CheckinBackgroundState extends State<CheckinBackground> {
  int _currentIndex = 0;
  final int _totalSlides = 3;
  final CarouselController _carouselController = CarouselController();
  final CarouselController _textCarouselController =
      CarouselController(); // New controller for the text carousel

  final List<Map<String, String>> _items = [
    {
      'image': 'assets/images/checkin.png',
      'title': 'Check-in hàng ngày',
      'description':
          'Người dùng có thể bắt đầu phiên làm việc bằng cách thực hiện thao tác check-in. Màn hình hiển thị thời gian hiện tại và xác nhận thời gian check-in khi người dùng bấm nút. Dữ liệu sẽ được lưu vào hệ thống để theo dõi.'
    },
    {
      'image': 'assets/images/checkout.png',
      'title': 'Check-out cuối ngày',
      'description':
          'Người dùng có thể check-out sau khi kết thúc công việc. Dữ liệu sẽ được lưu để tính toán tổng thời gian làm việc trong ngày.'
    },
    {
      'image': 'assets/images/attendance.png',
      'title': 'Xem lịch sử điểm danh',
      'description':
          'Màn hình tổng quan về lịch sử check-in và check-out của người dùng, hiển thị số giờ làm việc hàng ngày.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          // Image Carousel
          CarouselSlider(
            carouselController: _carouselController,
            items: _items.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.asset(
                    item['image'] ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 0.97,
              scrollPhysics: const NeverScrollableScrollPhysics()
            ),
          ),
          const SizedBox(height: 20),
          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _items.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 15.0,
                  height: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: (_currentIndex == entry.key
                        ? Colors.green
                        : Colors.grey.withOpacity(0.4)),
                  ),
                ),
              );
            }).toList(),
          ),
          // Text Carousel
          CarouselSlider(
            carouselController: _textCarouselController,
            items: _items.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Text(
                        item['title'] ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          item['description'] ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 0.97,
              height: 200.0,
              enlargeCenterPage: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          ButtonCustom(
            title: _currentIndex == _totalSlides - 1 ? "Login" : "Next",
            colorbtn: AppColor.btncheckin,
            colortitle: AppColor.kGreen,
            onTap: () {
              if (_currentIndex == _totalSlides - 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              } else {
                setState(() {
                  _currentIndex++;
                });
                _carouselController.animateToPage(_currentIndex);
                _textCarouselController.animateToPage(_currentIndex);
              }
            },
            paddingX: 140,
            paddingY: 12,
          ),
          SizedBox(
            height: psHeight(10),
          ),
          ButtonCustom(
            title: "Skip",
            colorbtn: Colors.white,
            colortitle: Colors.black,
            onTap: () {},
            paddingX: 140,
            paddingY: 12,
            boxBorder: Border.all(width: 1, color: AppColor.textGrey),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
