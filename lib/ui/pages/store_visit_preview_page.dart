import 'dart:io';
import 'package:coresight/blocs/store_visit/store_visit_bloc.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:coresight/utils/convert_photo_to_base64.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class StoreVisitPreviewPage extends StatefulWidget {
  const StoreVisitPreviewPage({super.key});

  @override
  State<StoreVisitPreviewPage> createState() => _StoreVisitPreviewPageState();
}

class _StoreVisitPreviewPageState extends State<StoreVisitPreviewPage> {
  String? salesId;
  String? userName;
  late dynamic photoPath;
  late int type;
  late String storeId;
  late String storeName;
  late String areaName;
  late LatLng storeLocation;
  late LatLng location;
  late String formattedDate;
  late String formattedTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    photoPath = args['photoPath'];
    location = args['location'];
    type = args['type'];
    storeId = args['storeId'];
    storeName = args['storeName'];
    areaName = args['areaName'];
    storeLocation = args['storeLocation'];
    final rawDate = args['date'];
    final date = DateFormat('dd-MM-yy HH:mm:ss').parse(rawDate);
    formattedDate = DateFormat('dd-MM-yy').format(date);
    formattedTime = DateFormat('HH:mm:ss').format(date);
  }

  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: lightBackgroundColor,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = const FlutterSecureStorage();
    final idSales = await storage.read(key: 'sales_id');
    final username = await storage.read(key: 'name');

    setState(() {
      userName = username ?? '';
      salesId = idSales ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      final base64Photo = convertToBase64(photoPath);

      if (!mounted) return;

      context.read<StoreVisitBloc>().add(
        StoreVisitRequested(
          salesId: salesId ?? '',
          storeId: storeId,
          username: userName ?? '',
          filePhotoFile: base64Photo,
          type: type,
        ),
      );

      // You can navigate or show a toast here
      // if (!mounted) return;
      // Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: 'Store Visit ${type == 1 ? 'Check In' : 'Check Out'}',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: BlocConsumer<StoreVisitBloc, StoreVisitState>(
        listener: (context, state) {
          if (state is StoreVisitSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            GlobalToast.showSuccess(state.msg);
          }
          if (state is StoreVisitFailed) {
            GlobalToast.showError(state.e);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        insetPadding: EdgeInsets.all(16), // fullscreen
                        backgroundColor: blackColor,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.file(
                                File(photoPath),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: whiteColor,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(File(photoPath), fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // STORE
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: subtleBlueColor,
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            'assets/icons/ic_store.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  'Store',
                                  style: blackTextStyle.copyWith(fontSize: h6),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Text(
                                    'Area',
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(height: 1, color: blackColor, thickness: 1),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  storeName,
                                  style: blackTextStyle.copyWith(
                                    fontSize: h6,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Text(
                                    areaName,
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // LOCATION
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: subtleBlueColor,
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            'assets/icons/ic_visit.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  'Latitude',
                                  style: blackTextStyle.copyWith(fontSize: h6),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Text(
                                    'Longitude',
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(height: 1, color: blackColor, thickness: 1),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  location.latitude.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: h6,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Text(
                                    location.longitude.toString(),
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // DATE & TIME
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: subtleBlueColor,
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            'assets/icons/ic_clock.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  'Date',
                                  style: blackTextStyle.copyWith(fontSize: h6),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Text(
                                    'Time',
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(height: 1, color: blackColor, thickness: 1),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  formattedDate,
                                  style: blackTextStyle.copyWith(
                                    fontSize: h6,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Text(
                                    formattedTime,
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: onSubmit,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: type == 1 ? tealColor : subtleRedColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/${type == 1 ? 'ic_check_in' : 'ic_check_out'}.png',
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: 10),
                Text(
                  'Check ${type == 1 ? 'In' : 'Out'}',
                  style: whiteTextStyle.copyWith(
                    fontSize: h4,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Container(
        //       width: MediaQuery.of(context).size.width / 2.2,
        //       height: 48,
        //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //       decoration: BoxDecoration(
        //         color: subtleRedColor,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.popUntil(context, (route) => route.isFirst);
        //         },
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Image.asset(
        //               'assets/icons/ic_check_out.png',
        //               width: 24,
        //               height: 24,
        //             ),
        //             SizedBox(width: 10),
        //             Text(
        //               'Check Out',
        //               style: whiteTextStyle.copyWith(
        //                 fontSize: h4,
        //                 fontWeight: semiBold,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Container(
        //       width: MediaQuery.of(context).size.width / 2.2,
        //       height: 48,
        //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //       decoration: BoxDecoration(
        //         color: tealColor,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.popUntil(context, (route) => route.isFirst);
        //         },
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Image.asset(
        //               'assets/icons/ic_check_in.png',
        //               width: 24,
        //               height: 24,
        //             ),
        //             SizedBox(width: 10),
        //             Text(
        //               'Check In',
        //               style: whiteTextStyle.copyWith(
        //                 fontSize: h4,
        //                 fontWeight: semiBold,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
