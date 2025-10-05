import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/sos_facing_list.dart';
import 'package:coresight/ui/widgets/tap_to_photo.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:coresight/utils/sos_facing_controller.dart';
import 'package:flutter/material.dart';

class ShareOfShelfPage extends StatefulWidget {
  const ShareOfShelfPage({super.key});

  @override
  State<ShareOfShelfPage> createState() => _ShareOfShelfPageState();
}

class _ShareOfShelfPageState extends State<ShareOfShelfPage> {
  final SosFacingController controller = SosFacingController();

  void _submitForm() {
    final values = controller.getValues();
    print("Submitted values: $values");

    GlobalToast.showSuccess('Data saved successfully!');
    Navigator.pop(context);
    // Send values to API or handle form logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Share of Shelf',
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

            // Product in Category
            CustomTextInput(
              label: 'Product in Category',
              hint: 'choose a category',
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            ),
            SizedBox(height: 16),

            SosFacingList(controller: controller),
            SizedBox(height: 16),
            // SosFacing(label: 'Company Brand'),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text('+ Product', style: blackTextStyle),
            //   ),
            // ),
            // SizedBox(height: 4),

            // SosFacing(label: 'Competitor Brand'),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text('+ Product', style: blackTextStyle),
            //   ),
            // ),
            CustomTextInput(
              label: 'Note',
              hint: 'Type something here',
              isTextArea: true,
              labelStyle: blackTextStyle.copyWith(
                fontSize: h6,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundBlueColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Facing per Category',
                    style: blackTextStyle.copyWith(
                      fontSize: h5,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Company Product',
                          style: blackTextStyle.copyWith(fontSize: h5),
                        ),
                      ),
                      Text(
                        '6 Facing (33,3%)',
                        style: blackTextStyle.copyWith(
                          fontSize: h5,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Company Product',
                          style: blackTextStyle.copyWith(fontSize: h5),
                        ),
                      ),
                      Text(
                        '8 Facing (44,4%)',
                        style: blackTextStyle.copyWith(
                          fontSize: h5,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Competitor Product',
                          style: blackTextStyle.copyWith(fontSize: h5),
                        ),
                      ),
                      Text(
                        '4 Facing (22,3%)',
                        style: blackTextStyle.copyWith(
                          fontSize: h5,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 30),
            Button(
              text: 'Save Display Data',
              bgColor: primaryColor,
              styleText: whiteTextStyle.copyWith(
                fontSize: h4,
                fontWeight: semiBold,
              ),
              onPressed: _submitForm,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
