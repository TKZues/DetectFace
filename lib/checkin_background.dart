import 'package:findy/src/login/login_screen.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';

class CheckinBackground extends StatefulWidget {
  const CheckinBackground({super.key});

  @override
  State<CheckinBackground> createState() => _CheckinBackgroundState();
}

class _CheckinBackgroundState extends State<CheckinBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
            title: "Check-in hàng ngày",
            bodyWidget: Center(
              child: Text(
                "Người dùng có thể bắt đầu phiên làm việc bằng cách thực hiện thao tác check-in. Màn hình hiển thị thời gian hiện tại và xác nhận thời gian check-in khi người dùng bấm nút. Dữ liệu sẽ được lưu vào hệ thống để theo dõi.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  )
                ]),
              ),
            ),
            image: Image.asset("assets/images/checkout.png",
                width: psWidth(300), fit: BoxFit.cover)),
        PageViewModel(
            title: "Check-in hàng ngày",
            bodyWidget: Center(
              child: Text(
                "Người dùng có thể bắt đầu phiên làm việc bằng cách thực hiện thao tác check-in. Màn hình hiển thị thời gian hiện tại và xác nhận thời gian check-in khi người dùng bấm nút. Dữ liệu sẽ được lưu vào hệ thống để theo dõi.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  )
                ]),
              ),
            ),
            image: Image.asset("assets/images/checkout.png",
                width: psWidth(300), fit: BoxFit.cover)),
        PageViewModel(
            title: "Check-out cuối ngày",
            bodyWidget: Center(
              child: Text(
                "Người dùng có thể check-out sau khi kết thúc công việc. Dữ liệu sẽ được lưu để tính toán tổng thời gian làm việc trong ngày.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  )
                ]),
              ),
            ),
            image: Image.asset(
              "assets/images/checkout.png",
             width: psWidth(300), fit: BoxFit.cover
            )),
        PageViewModel(
            title: "Xem lịch sử điểm danh",
            bodyWidget: Center(
              child: Text(
                "Màn hình tổng quan về lịch sử check-in và check-out của người dùng, hiển thị số giờ làm việc hàng ngày.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  )
                ]),
              ),
            ),
            image: Image.asset(
              "assets/images/checkout.png",
              width: psWidth(300), fit: BoxFit.cover
            )),
      ],
      onDone: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      },
      showSkipButton: true,
      showNextButton: true,
      nextFlex: 1,
      dotsFlex: 2,
      animationDuration: 1000,
      curve: Curves.fastOutSlowIn,
      dotsDecorator: DotsDecorator(
          spacing: const EdgeInsets.all(5),
          activeColor: const Color(0xff20D5B2),
          // activeSize: Size.square(10),
          // size: Size.square(5),
          activeSize: const Size(20, 10),
          size: const Size.square(10),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      skip: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xff20D5B2),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(4, 4))
            ]),
        child: const Center(
          child: Text(
            "Skip",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      next: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xff20D5B2), width: 2)),
        child: const Center(
          child: Icon(
            Icons.navigate_next,
            size: 30,
            color: Color(0xff20D5B2),
          ),
        ),
      ),
      done: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xff20D5B2),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 40,
                  offset: const Offset(4, 4))
            ]),
        child: const Center(
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }
}
