import 'package:findy/src/teacher/screen/scanlive/checkinout_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../constant/color.dart';
import '../../../../utils/config/size_config.dart';
import '../../../../widget/button/buttoncustom.dart';
import '../../../../widget/text/textcustom.dart';

class ScanBackGround extends StatefulWidget {
  final String subjectID;
  final String beginTime;
  final String endTime;
  const ScanBackGround(
      {super.key,
      required this.subjectID,
      required this.beginTime,
      required this.endTime});

  @override
  // ignore: library_private_types_in_public_api
  _ScanBackGroundState createState() => _ScanBackGroundState();
}

class _ScanBackGroundState extends State<ScanBackGround> {
  late GoogleMapController googleMapController;
  bool _makelocation = false;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};
  String address = "Chưa có địa chỉ";
  double latitude = 37.42796133580664;
  double longitude = -122.085749655962;
  Future<void> _updateLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        address = "${position.latitude} - ${position.longitude}";
        latitude = position.latitude;
        longitude = position.longitude;
        markers.clear();
        markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
        ));
      });

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14,
          ),
        ),
      );
      setState(() {
        _makelocation = true;
      });
    } catch (e) {
      // Display error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  String formattedDate = '';
  void _getFormattedDate() async {
    await initializeDateFormatting('vi', null);
    DateTime now = DateTime.now();
    setState(() {
      formattedDate =
          DateFormat('EEEE, d MMMM, dd/MM h:mm a', 'vi').format(now);
    });
  }

  @override
  void initState() {
    super.initState();
    _getFormattedDate();
    _updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Địa điểm",
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Positioned(
            left: psWidth(20),
            right: psWidth(20),
            bottom: psHeight(20),
            child: Container(
              width: MediaQuery.of(context).size.width - psWidth(150),
              height: psHeight(200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(psHeight(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: psWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: psHeight(10),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: psHeight(100),
                        height: psHeight(4),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(psHeight(15))),
                      ),
                    ),
                    SizedBox(
                      height: psHeight(10),
                    ),
                    TextCustom(
                      text: "Vị trí của bạn",
                      fontSize: psHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                    TextCustom(
                      text: "Hãy kết nối vị trí của bạn đến hệ thống",
                      fontSize: psHeight(12),
                      color: AppColor.textGrey,
                    ),
                    SizedBox(
                      height: psHeight(10),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: psWidth(6),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              text: address,
                              fontSize: psHeight(13),
                              fontWeight: FontWeight.bold,
                            ),
                            TextCustom(
                              text: formattedDate,
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              color: AppColor.textGrey,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonCustom(
                        title: "Lấy vị trí",
                        colorbtn: _makelocation
                            ? AppColor.btncheckin
                            : AppColor.greyLogin,
                        colortitle:
                            _makelocation ? AppColor.kGreen : AppColor.white,
                        onTap: () {
                          _makelocation
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckInOutScreen(
                                      location: address,
                                      latitude: latitude,
                                      longitude: longitude,
                                      subjectID: widget.subjectID,
                                      beginTime: widget.beginTime,
                                      endTime: widget.endTime,
                                    ),
                                  ),
                                )
                              : () {};
                        },
                        paddingX: 100,
                        paddingY: 12,
                      ),
                    ),
                    SizedBox(
                      height: psHeight(20),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(bottom: psHeight(250)),
      //   child: FloatingActionButton(
      //     onPressed: _updateLocation,
      //     shape: const CircleBorder(),
      //     backgroundColor: AppColor.greenMain,
      //     child: const Icon(Icons.location_on_outlined),
      //   ),
      // ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
