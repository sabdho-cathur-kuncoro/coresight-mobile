import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/custom_date_picker.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class SurveyExpiredPage extends StatelessWidget {
  const SurveyExpiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productName = args['productName'];
    void onSubmit() {
      GlobalToast.showSuccess('Data saved successfully!');
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: 'Survey Expired Product',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
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

            // Product Cateogry
            CustomTextInput(
              label: 'Product Category',
              hint: 'select a product category',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            ),
            SizedBox(height: 16),

            // Expired Date
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomDatePicker(
                label: 'Expired Date',
                onDateSelected: (date) => {
                  print("Selected Expired Date: $date"),
                },
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
              text: 'Save Survey',
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
