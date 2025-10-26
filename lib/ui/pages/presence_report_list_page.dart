import 'package:coresight/blocs/presence/presence_bloc.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/global_filter_modal.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PresenceReportListPage extends StatefulWidget {
  const PresenceReportListPage({super.key});

  @override
  State<PresenceReportListPage> createState() => _PresenceReportListPageState();
}

class _PresenceReportListPageState extends State<PresenceReportListPage> {
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  bool isFiltered = false;
  final String formattedDate = DateFormat('dd-MM-yy').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: lightBackgroundColor,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
    context.read<PresenceBloc>().add(PresenceFetch(month: month, year: year));
  }

  void _openFilter() async {
    final result = await GlobalFilterModal.show(
      context,
      initialMonth: month,
      initialYear: year,
      isFiltered: isFiltered,
    );

    if (result != null) {
      setState(() {
        month = result['month']!;
        year = result['year']!;
        isFiltered = result['isFiltered'] == true;
      });

      if (!mounted) return;

      context.read<PresenceBloc>().add(PresenceFetch(month: month, year: year));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Presence Report',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
        trailing: IconButton(
          icon: Icon(
            Icons.filter_list_rounded,
            color: isFiltered ? blueColor : blackColor,
          ),
          onPressed: _openFilter,
        ),
      ),
      backgroundColor: lightBackgroundColor,
      body: BlocBuilder<PresenceBloc, PresenceState>(
        builder: (context, state) {
          if (state is PresenceLoaded) {
            final list = state.data;
            if (list.isEmpty) {
              return const Center(child: Text('No attendance data'));
            }
            return ListView.builder(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 32,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final date = DateFormat(
                  'EEEE, dd-MM-yy',
                ).format(DateTime.parse(item.createdDate!));
                final clockInTime = item.incomingAttendance != null
                    ? DateFormat(
                        'HH:mm',
                      ).format(DateTime.parse(item.incomingAttendance!))
                    : '--:--';
                final clockOutTime = item.repeatAttendance != null
                    ? DateFormat(
                        'HH:mm',
                      ).format(DateTime.parse(item.repeatAttendance!))
                    : '--:--';
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/presence-report-detail',
                      arguments: {
                        'date': DateFormat(
                          'yyyy-MM-dd',
                        ).format(DateTime.parse(item.createdDate!)),
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: strokeColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Presence Date',
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(date, style: blackTextStyle),
                          ],
                        ),
                        SizedBox(height: 8),
                        Divider(height: 1, color: strokeColor, thickness: 0.5),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Clock In', style: blackTextStyle),
                                SizedBox(width: 10),
                                Text(clockInTime, style: blackTextStyle),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Clock Out', style: blackTextStyle),
                                SizedBox(width: 10),
                                Text(clockOutTime, style: blackTextStyle),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is PresenceFailed) {
            return Center(
              child: Text('Error: ${state.e}', style: redTextStyle),
            );
          }

          return Container();
        },
      ),
    );
  }
}
