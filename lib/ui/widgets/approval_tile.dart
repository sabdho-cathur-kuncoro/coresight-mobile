import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';

class ApprovalTile extends StatelessWidget {
  final String approvalType;
  final String name;
  final String idApproval;
  final String date;
  final int status;
  final VoidCallback? onPressed;
  const ApprovalTile({
    super.key,
    required this.approvalType,
    required this.idApproval,
    required this.name,
    required this.date,
    this.status = 1,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: strokeColor),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  approvalType,
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
                Spacer(),
                Text(idApproval, style: blackTextStyle),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: strokeColor),
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
                Text('Submission Date', style: blackTextStyle),
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
                Text('Status', style: blackTextStyle),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 1
                        ? yellowColor
                        : status == 2
                        ? greenColor
                        : status == 3
                        ? redColor
                        : greyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status == 1
                        ? 'Pending Approval'
                        : status == 2
                        ? 'Approved'
                        : status == 3
                        ? 'Rejected'
                        : 'Unknown',
                    style: whiteTextStyle.copyWith(
                      fontSize: h6,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
