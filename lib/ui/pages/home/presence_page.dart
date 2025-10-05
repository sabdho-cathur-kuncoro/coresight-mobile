import 'package:coresight/shared/theme.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';

class PresencePage extends StatefulWidget {
  const PresencePage({super.key});

  @override
  State<PresencePage> createState() => _PresencePageState();
}

class _PresencePageState extends State<PresencePage> {
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Activity',
                      style: blackTextStyle.copyWith(
                        fontSize: h2,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: Text(
                        'Track your work day with ease.',
                        style: blackTextStyle.copyWith(
                          fontSize: h6,
                          letterSpacing: header,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),

            // Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/presence-zonation',
                      arguments: {'type': 1},
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: (0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/ic_mdi_clock_in.png',
                          width: 48,
                          height: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Clock In',
                              style: blackTextStyle.copyWith(
                                fontSize: h5,
                                fontWeight: semiBold,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/presence-zonation',
                      arguments: {'type': 2},
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: (0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/ic_mdi_clock_out.png',
                          width: 48,
                          height: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Clock Out',
                              style: blackTextStyle.copyWith(
                                fontSize: h5,
                                fontWeight: semiBold,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            // Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/sick-leave');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: (0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/ic_sick_leave.png',
                          width: 48,
                          height: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sick Leave',
                              style: blackTextStyle.copyWith(
                                fontSize: h5,
                                fontWeight: semiBold,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/permit');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: (0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/ic_permit.png',
                          width: 48,
                          height: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Permit',
                              style: blackTextStyle.copyWith(
                                fontSize: h5,
                                fontWeight: semiBold,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            // Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/offday');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: (0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/ic_off_day.png',
                          width: 48,
                          height: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Off Day',
                              style: blackTextStyle.copyWith(
                                fontSize: h5,
                                fontWeight: semiBold,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/leave');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: (0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/ic_leave.png',
                          width: 48,
                          height: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Leave',
                              style: blackTextStyle.copyWith(
                                fontSize: h5,
                                fontWeight: semiBold,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            // Report Presence
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/presence-report');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: (0.1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/ic_report.png',
                      width: 48,
                      height: 48,
                      color: primaryColor,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Presence Report',
                          style: blackTextStyle.copyWith(
                            fontSize: h5,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          'Check your attendance history',
                          style: blackTextStyle.copyWith(
                            fontSize: h6,
                            letterSpacing: header,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
