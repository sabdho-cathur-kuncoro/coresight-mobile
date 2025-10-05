import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productName = args['productName'];
    final screen = args['screen'];

    void onSubmit() {
      GlobalToast.showSuccess('Data saved successfully!');
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: screen,
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
            Text(
              'Alfanow',
              style: blackTextStyle.copyWith(
                fontSize: h2,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 4),
            Text(productName, style: blackTextStyle.copyWith(fontSize: h5)),
            SizedBox(height: 30),

            // Photo
            TapToPhoto(onPressed: () {}),
            SizedBox(height: 16),

            // Stocks Available?
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: subtleGreyColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: greyColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are stocks available?',
                    style: blackTextStyle.copyWith(fontSize: h5),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('Yes'),
                        ],
                      ),
                      SizedBox(width: 30),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('No'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Reason Out of Stock (Conditional if stocks 0)
            CustomTextInput(
              label: 'Reason Out of Stock',
              hint: 'choose a reason',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            ),
            SizedBox(height: 16),

            // Stocks
            CustomTextInput(
              label: 'Stocks',
              hint: '0',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 16),

            CustomTextInput(
              isTextArea: true,
              label: 'Note',
              hint: 'Type something here',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 30),
            Button(
              text: 'Save Stock',
              bgColor: primaryColor,
              styleText: whiteTextStyle.copyWith(
                fontSize: h4,
                fontWeight: semiBold,
              ),
              onPressed: onSubmit,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
