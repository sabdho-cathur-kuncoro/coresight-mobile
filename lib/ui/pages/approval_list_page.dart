import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class ApprovalListPage extends StatelessWidget {
  const ApprovalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Approval List',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/approval-list-permit');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: backgroundBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_permit.png',
                      width: 32,
                      height: 32,
                      color: blackColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Permit Approval',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: blackColor,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/approval-list-sick-leave');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: backgroundBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_sick_leave.png',
                      width: 32,
                      height: 32,
                      color: blackColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sick Leave Approval',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: blackColor,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/approval-list-off-day');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: backgroundBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_off_day.png',
                      width: 32,
                      height: 32,
                      color: blackColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Off Day Approval',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: blackColor,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/approval-list-leave');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: backgroundBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_leave.png',
                      width: 32,
                      height: 32,
                      color: blackColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Leave Approval',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: blackColor,
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
