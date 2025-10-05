import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/custom_date_picker.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class RentalDisplayPage extends StatelessWidget {
  const RentalDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      GlobalToast.showSuccess('Data saved successfully!');
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: 'Rental Display',
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
            Center(
              child: Text(
                'Alfanow',
                style: blackTextStyle.copyWith(
                  fontSize: h2,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Photo
            TapToPhoto(onPressed: () {}),
            SizedBox(height: 16),

            // Type of Display
            CustomTextInput(
              label: 'Type of Display',
              hint: 'Choose a type display',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            ),
            SizedBox(height: 16),

            // Start / End Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CustomDatePicker(
                    label: 'Start Date',
                    onDateSelected: (date) => {
                      print("Selected Start Date: $date"),
                    },
                  ),
                ),
                Text('to', style: blackTextStyle, textAlign: TextAlign.center),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CustomDatePicker(
                    label: 'End Date',
                    onDateSelected: (date) => {
                      print("Selected End Date: $date"),
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Rent Price
            CustomTextInput(
              label: 'Rent Price',
              hint: 'Rp. xxx',
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
              text: 'Save Rental Display',
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
