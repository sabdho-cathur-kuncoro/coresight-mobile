import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class ApprovalDetailPermitPage extends StatelessWidget {
  const ApprovalDetailPermitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = args['name'];
    final approvalType = args['approvalType'];
    final idApproval = args['idApproval'];
    final date = args['date'];
    final desc = args['desc'];

    void onSubmit(int type) {
      GlobalToast.showSuccess(
        'Submission ${type == 1 ? 'approved' : 'rejected'} successfully!',
      );
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: Header(
        title: idApproval,
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
                    approvalType,
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  SizedBox(height: 8),
                  Divider(color: strokeColor),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name', style: blackTextStyle),
                      Spacer(),
                      Text(
                        name,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filing Date', style: blackTextStyle),
                      Spacer(),
                      Text(
                        date,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Effective Date', style: blackTextStyle),
                      Spacer(),
                      Text(
                        date,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Description', style: blackTextStyle),
                      Spacer(),
                      Text(
                        desc,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
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
                    'Photo Attachment',
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  SizedBox(height: 8),
                  Divider(color: strokeColor),
                  SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/ic_image.png',
                        width: 56,
                        height: 56,
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 20),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.25,
              child: Button(
                text: 'Reject',
                borderRad: 20,
                onPressed: () {
                  onSubmit(2);
                },
                bgColor: redColor,
                styleText: whiteTextStyle.copyWith(
                  fontSize: h4,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.25,
              child: Button(
                text: 'Approve',
                borderRad: 20,
                onPressed: () {
                  onSubmit(1);
                },
                bgColor: greenColor,
                styleText: whiteTextStyle.copyWith(
                  fontSize: h4,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
