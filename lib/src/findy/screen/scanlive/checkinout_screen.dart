import 'package:findy/src/findy/screen/scanlive/scan_live.dart';
import 'package:findy/widget/button/buttoncustom.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../constant/color.dart';
import '../../../../utils/config/size_config.dart';

class CheckInOutScreen extends StatefulWidget {
  final String location;
  final double latitude;
  final double longitude;
  const CheckInOutScreen(
      {super.key,
      required this.location,
      required this.latitude,
      required this.longitude});

  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late GoogleMapController googleMapController;

  // Remove the static keyword
  late CameraPosition initialCameraPosition;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(widget.latitude, widget.longitude),
    ));

    // Initialize the initialCameraPosition here
    initialCameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 14,
    );

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgbackColor.withOpacity(0.01),
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        leading: GFIconButton(
          icon: Container(
            padding: EdgeInsets.symmetric(
                horizontal: psWidth(3), vertical: psHeight(4)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(psHeight(4)),
              color: AppColor.backgbackColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.backiconColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          type: GFButtonType.transparent,
        ),
        searchBar: true,
        title: TextCustom(
          text: "Quản lý môn học",
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
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [_checkinTab(), _checkoutTab()]))
        ],
      ),
    );
  }

  Widget _checkinTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: psHeight(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColor.greyBorder, width: 1))),
              child: Row(
                children: [
                  _item("Date", "January 4th"),
                  _item("Lớp", "21DTH3"),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColor.greyBorder, width: 1))),
              child: Row(
                children: [
                  _item("Time", "6:30 PM"),
                  _item("Chi Nhánh", "Tăng Nhơn Phú"),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  _item("Location", widget.location),
                  Expanded(
                    child: ButtonCustom(
                      title: "Add",
                      colorbtn: const Color(0xffE3EDEC),
                      colortitle: const Color(0xff38AC70),
                      onTap: () {},
                      paddingX: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(psHeight(15))),
              width: MediaQuery.of(context).size.width - psWidth(40),
              height: psHeight(200),
              child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
                markers: markers,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                },
              ),
            ),
            SizedBox(height: psHeight(20),),
            Align(
              alignment: Alignment.center,
              child: ButtonCustom(
                title: "Get Derection",
                colorbtn: AppColor.btncheckin,
                colortitle: AppColor.kGreen,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FaceDetectorApp(),
                    ),
                  );
                },
                paddingX: 100,
                paddingY: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkoutTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: psHeight(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColor.greyBorder, width: 1))),
              child: Row(
                children: [
                  _item("Date", "January 4th"),
                  _item("Lớp", "21DTH3"),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColor.greyBorder, width: 1))),
              child: Row(
                children: [
                  _item("Time", "6:30 PM"),
                  _item("Chi Nhánh", "Tăng Nhơn Phú"),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  _item("Location", widget.location),
                  Expanded(
                    child: ButtonCustom(
                      title: "Add",
                      colorbtn: const Color(0xffE3EDEC),
                      colortitle: const Color(0xff38AC70),
                      onTap: () {},
                      paddingX: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(psHeight(15))),
              width: MediaQuery.of(context).size.width - psWidth(40),
              height: psHeight(200),
              child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
                markers: markers,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                },
              ),
            ),
            SizedBox(height: psHeight(20),),
            Align(
              alignment: Alignment.center,
              child: ButtonCustom(
                title: "Get Derection",
                colorbtn: AppColor.btncheckin,
                colortitle: AppColor.kGreen,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FaceDetectorApp(),
                    ),
                  );
                },
                paddingX: 100,
                paddingY: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String label, String description) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: psHeight(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              text: label,
              color: AppColor.greyMain,
              fontSize: psHeight(12),
            ),
            SizedBox(
              height: psHeight(6),
            ),
            TextCustom(
              text: description,
              fontSize: psHeight(14),
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: psHeight(60),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: TabBar(
        labelStyle: TextStyle(
            color: AppColor.topTitle,
            fontSize: psWidth(14),
            fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(
          color: Color(0xFF3EB075),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black54,
        padding: EdgeInsets.zero,
        controller: tabController,
        tabs: const [
          Tab(
            text: "Checkin",
          ),
          Tab(text: "Checkout"),
        ],
      ),
    );
  }
}
