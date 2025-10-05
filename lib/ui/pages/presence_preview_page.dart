import 'dart:io';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class PresencePreviewPage extends StatefulWidget {
  const PresencePreviewPage({super.key});

  @override
  State<PresencePreviewPage> createState() => _PresencePreviewPageState();
}

class _PresencePreviewPageState extends State<PresencePreviewPage> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final photoPath = args['photoPath'];
    final type = args['type'];
    // final LatLng location = args['location'];
    // final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
    // final String formattedTime = DateFormat('hh:mm:ss').format(DateTime.now());

    void onSubmit() {
      GlobalToast.showSuccess(
        '${type == 1 ? 'Clock In' : 'Clock Out'} successfully!',
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    }

    return Scaffold(
      appBar: Header(
        title: type == 1 ? 'Clock In' : 'Clock Out',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: Image.file(
        File(photoPath),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        fit: BoxFit.cover,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                child: Button(
                  text: 'Go Back',
                  bgColor: Colors.transparent,
                  borderWidth: 1,
                  borderColor: primaryColor,
                  styleText: primaryTextStyle,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                child: Button(
                  text: type == 1 ? 'Clock In' : 'Clock Out',
                  onPressed: onSubmit,
                  bgColor: primaryColor,
                  styleText: whiteTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
