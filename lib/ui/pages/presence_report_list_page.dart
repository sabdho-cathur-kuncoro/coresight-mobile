import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PresenceReportListPage extends StatefulWidget {
  const PresenceReportListPage({super.key});

  @override
  State<PresenceReportListPage> createState() => _PresenceReportListPageState();
}

class _PresenceReportListPageState extends State<PresenceReportListPage> {
  final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: lightBackgroundColor,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Presence Report',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/presence-report-detail',
                arguments: {
                  'employeeName': 'John Doe',
                  'date': '2025-09-26',
                  'clockInTime': '08:10',
                  'clockOutTime': '05:05',
                  'clockInPhoto': '',
                  'clockOutPhoto': '',
                  'clockInLocation': const LatLng(-6.200000, 106.816666),
                  'clockOutLocation': const LatLng(-6.210000, 106.822222),
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Presence Date',
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                      Text(formattedDate, style: blackTextStyle),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(height: 1, color: strokeColor, thickness: 0.5),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Clock In', style: blackTextStyle),
                          SizedBox(width: 10),
                          Text('08:00', style: blackTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Clock Out', style: blackTextStyle),
                          SizedBox(width: 10),
                          Text('--:--', style: blackTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
