// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/bottomsheet/radiotextfield.dart';
import 'package:flutter/material.dart';
import '../../../../../constant/color.dart';

class BottomSheetCustom extends StatefulWidget {
  final String label;
  final TextEditingController RoadTextEditingController;

  const BottomSheetCustom({
    Key? key,
    required this.RoadTextEditingController, required this.label,
  }) : super(key: key);

  @override
  State<BottomSheetCustom> createState() => _BottomSheetCustomState();
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {

  
  String roadid = "";
  String? jsonListRoad;

  // Mock list of roads
  final List<Map<String, String>> _listRoad = [
    {'id': '1', 'name': 'Road 1'},
    {'id': '2', 'name': 'Road 2'},
    {'id': '3', 'name': 'Road 3'},
    {'id': '4', 'name': 'Road 4'},
    {'id': '5', 'name': 'Road 5'},
  ];

  List<Map<String, String>> _listofRoad = [];
  Map<String, String>? _selectedRoad;

  // ignore: prefer_final_fields
  bool _isLoading = false;
  bool _bottomSheetCalled = false;

  void onTextFieldTapError(
    final String title,
    final void Function(String)? onJsonListChanged,
  ) {
    TextEditingController filtercontroller = TextEditingController();
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              if (_bottomSheetCalled == true) {
                // _fetchAndShowBottomSheet(setState);
              }

              return Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: psHeight(4), horizontal: psHeight(14)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chọn đường",
                        style: TextStyle(
                          fontSize: psHeight(12),
                          fontWeight: FontWeight.w700,
                          color: AppColor.topTitle,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColor.topTitle,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: psWidth(8), vertical: psHeight(4)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    child: TextField(
                      controller: filtercontroller,
                      decoration: InputDecoration(
                          hintText: 'Tìm kiếm',
                          prefixIcon: const Icon(Icons.search,
                              color: AppColor.topTitle),
                          suffixIcon: filtercontroller.text.isEmpty
                              ? const Icon(Icons.abc, color: AppColor.topTitle)
                              : IconButton(
                                  icon: const Icon(Icons.cancel,
                                      color: AppColor.topTitle),
                                  onPressed: () {
                                    setState(() {
                                      filtercontroller.text = '';
                                      _listofRoad = _listRoad;
                                    });
                                  },
                                ),
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[100],
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ))),
                      onChanged: (value) {
                        String query = filtercontroller.text.toLowerCase();
                        setState(() {
                          _listofRoad = _listRoad
                              .where((element) =>
                                  element['name']
                                      ?.toLowerCase()
                                      .contains(query) ??
                                  false)
                              .toList();
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _listofRoad.isNotEmpty
                          ? ListView.builder(
                              itemCount: _listofRoad.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    _listofRoad[index]['name'] ?? "",
                                    style: TextStyle(fontSize: psHeight(14)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Radio<Map<String, String>>(
                                    activeColor: AppColor.topTitle,
                                    value: _listofRoad[index],
                                    groupValue: _selectedRoad,
                                    onChanged: (Map<String, String>? value) {
                                      setState(() {
                                        _selectedRoad = value;
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text("Không có dữ liệu")),
                ),
              ]);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return RadioTextField(
      textEditingController: widget.RoadTextEditingController,
      text: widget.label,
      hintText: widget.label,
      error: "Vui lòng chọn đơn vị hành chính",
      onTap: () {
        _bottomSheetCalled = true;

        onTextFieldTapError(
          widget.label,
          (value) {
            setState(() {
              jsonListRoad = value;
            });
          },
        );
      },
      onPressclear: () {
        widget.RoadTextEditingController.clear();
        setState(() {
          widget.RoadTextEditingController.clear();
        });
      },
    );
  }
}
