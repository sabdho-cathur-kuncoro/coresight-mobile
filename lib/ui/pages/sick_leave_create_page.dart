import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/custom_date_picker.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class SickLeaveCreatePage extends StatelessWidget {
  const SickLeaveCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      GlobalToast.showSuccess('Data saved successfully!');
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: 'Create Sick Leave',
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
            // Photo
            TapToPhoto(onPressed: () {}),
            SizedBox(height: 16),

            // Date
            CustomDatePicker(
              label: 'Date',
              onDateSelected: (date) => {print("Selected Date: $date")},
            ),
            SizedBox(height: 16),

            // Description
            CustomTextInput(
              isTextArea: true,
              label: 'Description',
              hint: 'Type something here',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 30),

            Button(
              text: 'Submit Sick Leave',
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
