import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/custom_date_picker.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class SalesOrderSubmitPage extends StatelessWidget {
  const SalesOrderSubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      GlobalToast.showSuccess('Data saved successfully!');
      Navigator.popUntil(context, (route) => route.isFirst);
    }

    return Scaffold(
      appBar: Header(
        title: 'Sales Order',
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
            SizedBox(height: 20),

            // Photo
            TapToPhoto(onPressed: () {}),
            SizedBox(height: 16),

            // Type of Sales
            CustomTextInput(
              label: 'Type of Sales',
              hint: 'choose a type',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            ),
            SizedBox(height: 16),

            // Delivery Date
            CustomDatePicker(
              label: 'Delivery Date',
              onDateSelected: (date) => {
                print("Selected Delivery Date: $date"),
              },
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
              text: 'Submit Order',
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
