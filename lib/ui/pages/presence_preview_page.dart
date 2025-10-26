import 'dart:io';
import 'package:coresight/blocs/presence/presence_bloc.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    final LatLng location = args['location'] as LatLng;
    // final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
    // final String formattedTime = DateFormat('hh:mm:ss').format(DateTime.now());

    void onSubmit() {
      context.read<PresenceBloc>().add(
        PresenceRequested(photoPath: photoPath, location: location, type: type),
      );
      // GlobalToast.showSuccess(
      //   '${type == 1 ? 'Clock In' : 'Clock Out'} successfully!',
      // );
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
      body: BlocConsumer<PresenceBloc, PresenceState>(
        listener: (context, state) {
          if (state is PresenceFailed) {
            GlobalToast.showError(state.e);
          }
          if (state is PresenceSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            GlobalToast.showSuccess(state.msg);
          }
        },
        builder: (context, state) {
          return Image.file(
            File(photoPath),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            fit: BoxFit.cover,
          );
        },
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
