import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class CompetitorPricing extends StatelessWidget {
  const CompetitorPricing({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      GlobalToast.showSuccess('Data saved successfully!');
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: 'Competitor Pricing',
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

            // Product Category
            CustomTextInput(
              label: 'Product Category',
              hint: 'Choose a category',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            ),
            SizedBox(height: 16),

            // Product Name
            CustomTextInput(
              label: 'Product Name',
              hint: 'Type something here',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 16),

            // Sell Price
            CustomTextInput(
              label: 'Sell Price',
              hint: 'Rp. xxx',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 16),

            // Footnote
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
              text: 'Save Competitor Data',
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
