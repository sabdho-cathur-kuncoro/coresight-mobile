import 'package:flutter/material.dart';
import 'package:coresight/shared/theme.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color bgColor;
  final VoidCallback? onPressed;
  final Widget? trailing;

  const Header({
    super.key,
    required this.title,
    required this.bgColor,
    required this.onPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
      height: statusBarHeight + kToolbarHeight,
      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 32,
                    color: blackColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: blackTextStyle.copyWith(
                    fontSize: h4,
                    fontWeight: semiBold,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(24 + kToolbarHeight);
}
