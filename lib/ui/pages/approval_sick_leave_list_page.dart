import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/approval_tile.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApprovalSickLeaveListPage extends StatelessWidget {
  const ApprovalSickLeaveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now());
    return Scaffold(
      appBar: Header(
        title: 'Sick Leave Approval',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
          ApprovalTile(
            approvalType: 'Sick Leave',
            idApproval: 'SL-1009250001',
            name: 'John Doe',
            date: formattedDate,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/approval-detail-sick-leave',
                arguments: {
                  'approvalType': 'Sick Leave',
                  'idApproval': 'SL-1009250001',
                  'name': 'John Doe',
                  'date': formattedDate,
                  'desc': 'Medical Checkup',
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
