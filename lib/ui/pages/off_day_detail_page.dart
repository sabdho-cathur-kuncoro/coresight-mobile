import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OffDayDetailPage extends StatelessWidget {
  const OffDayDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
    return Scaffold(
      appBar: Header(
        title: 'Detail',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Off Day',
                    style: blackTextStyle.copyWith(
                      fontSize: h5,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(height: 1, color: strokeColor, thickness: 0.5),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filing Date', style: blackTextStyle),
                      Text(
                        formattedDate,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Submission Date', style: blackTextStyle),
                      Text(
                        formattedDate,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Description', style: blackTextStyle),
                      Text(
                        'Off Day',
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(height: 1, color: strokeColor, thickness: 0.5),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: orangeColor, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Edit',
                        style: orangeTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Approval',
                    style: blackTextStyle.copyWith(
                      fontSize: h5,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(height: 1, color: strokeColor, thickness: 0.5),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status', style: blackTextStyle),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: yellowColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Pending Approval',
                          style: whiteTextStyle.copyWith(
                            fontSize: h6,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Approved By', style: blackTextStyle)],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Approved Date', style: blackTextStyle)],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Description', style: blackTextStyle)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 20),
        color: Colors.transparent,
        child: Button(
          text: 'Request Cancel',
          onPressed: () {},
          bgColor: redColor,
          borderRad: 20,
          styleText: whiteTextStyle.copyWith(
            fontSize: h4,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
