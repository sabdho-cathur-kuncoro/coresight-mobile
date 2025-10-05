import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityTile extends StatefulWidget {
  final String type;
  final String typeId;
  final int status;
  final VoidCallback? onPressed;
  const ActivityTile({
    super.key,
    required this.type,
    required this.typeId,
    this.status = 1,
    this.onPressed,
  });

  @override
  State<ActivityTile> createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
  final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.type,
                  style: blackTextStyle.copyWith(
                    fontSize: h4,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  widget.typeId,
                  style: greyTextStyle.copyWith(fontSize: h5),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: greyColor, thickness: 0.5),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submission Date',
                      style: greyTextStyle.copyWith(fontSize: h5),
                    ),
                    Text(
                      formattedDate,
                      style: blackTextStyle.copyWith(
                        fontSize: h4,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.status == 1
                        ? yellowColor
                        : widget.status == 2
                        ? greenColor
                        : widget.status == 3
                        ? redColor
                        : greyColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.status == 1
                        ? 'Pending Approval'
                        : widget.status == 2
                        ? 'Approved'
                        : widget.status == 3
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
          ],
        ),
      ),
    );
  }
}
