import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/activity_tile.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PermitListPage extends StatefulWidget {
  const PermitListPage({super.key});

  @override
  State<PermitListPage> createState() => _PermitListPageState();
}

class _PermitListPageState extends State<PermitListPage> {
  final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: lightBackgroundColor,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Permit',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Button(
                  text: '+ Create New',
                  onPressed: () {
                    Navigator.pushNamed(context, '/permit-create');
                  },
                  height: 40,
                  bgColor: primaryColor,
                  styleText: whiteTextStyle.copyWith(
                    fontSize: h5,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: subtleBlueColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'assets/icons/ic_filter.png',
                    color: blackColor,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ActivityTile(
            type: 'Permit',
            typeId: 'P-1009250001',
            onPressed: () {
              Navigator.pushNamed(context, '/permit-detail');
            },
          ),
          ActivityTile(type: 'Permit', typeId: 'P-1009250002', status: 2),
          ActivityTile(type: 'Permit', typeId: 'P-1009250003', status: 3),
        ],
      ),
    );
  }
}
