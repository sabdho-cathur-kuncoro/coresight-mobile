import 'package:flutter/material.dart';
import 'package:coresight/shared/theme.dart';

class StoreTile extends StatefulWidget {
  final String storeName;
  final String areaName;
  final VoidCallback onPressed;

  const StoreTile({
    super.key,
    required this.storeName,
    required this.areaName,
    required this.onPressed,
  });

  @override
  State<StoreTile> createState() => _StoreTileState();
}

class _StoreTileState extends State<StoreTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: subtleBlueColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                child: Image.asset(
                  width: 24,
                  height: 24,
                  'assets/icons/ic_store.png',
                  color: blackColor,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.storeName,
                    style: blackTextStyle.copyWith(
                      fontSize: h5,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    widget.areaName,
                    style: darkGreyTextStyle.copyWith(fontSize: h6),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded, size: 16, color: blackColor),
          ],
        ),
      ),
    );
  }
}
