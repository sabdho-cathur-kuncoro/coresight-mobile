import 'package:coresight/blocs/auth/auth_bloc.dart';
import 'package:coresight/blocs/dashboard/dashboard_bloc.dart';
import 'package:coresight/models/store_visit_model.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/donut_chart_shimmer.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class _ChartSection {
  final String label;
  final int value;
  final Color color;

  _ChartSection({
    required this.label,
    required this.value,
    required this.color,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
    context.read<DashboardBloc>().add(DashboardFetch());
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'EEEE, MMMM d yyyy',
    ).format(DateTime.now());

    Widget donutChart(StoreVisitModel? storeVisit) {
      if (storeVisit == null) {
        return DonutChartShimmer();
      }
      final int totalVisit = int.tryParse(storeVisit.totalVisit) ?? 0;
      final int targetVisit = int.tryParse(storeVisit.targetVisit) ?? 0;

      // Progress math
      final int done = totalVisit.clamp(0, targetVisit);
      final int remaining = (targetVisit - done).clamp(0, targetVisit);
      final int percent = targetVisit == 0
          ? 0
          : ((done / targetVisit) * 100).clamp(0, 100).round();

      // 1) Data for the CHART (Target becomes 0 when complete)
      final List<_ChartSection> chartData = [
        _ChartSection(label: 'Done', value: done, color: tealColor),
        _ChartSection(label: 'Target', value: remaining, color: strokeColor),
      ];

      // 2) Data for the LEGEND (always show the real target value)
      final List<_ChartSection> legendData = [
        _ChartSection(label: 'Done', value: done, color: tealColor),
        _ChartSection(label: 'Target', value: targetVisit, color: strokeColor),
      ];

      int? touchedIndex;

      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = constraints.biggest.shortestSide;
                    final baseRadius = size / 4;
                    final touchedRad = size / 3;
                    final centerRadius = size / 3;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            centerSpaceRadius: centerRadius,
                            sectionsSpace: 2,
                            startDegreeOffset: -90,
                            pieTouchData: PieTouchData(
                              touchCallback: (event, response) {
                                setState(() {
                                  final i = response
                                      ?.touchedSection
                                      ?.touchedSectionIndex;
                                  touchedIndex = (i != null && i >= 0)
                                      ? i
                                      : null;
                                });
                              },
                            ),
                            sections: List.generate(chartData.length, (i) {
                              final s = chartData[i];
                              final isTouched = i == touchedIndex;
                              return PieChartSectionData(
                                color: s.color,
                                value: s.value.toDouble(),
                                title: '',
                                radius: isTouched ? touchedRad : baseRadius,
                              );
                            }),
                          ),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubic,
                        ),

                        // Center label shows percent (100% when complete)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$percent%',
                              style: TextStyle(
                                fontSize: size / 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              touchedIndex == 0
                                  ? 'Done'
                                  : touchedIndex == 1
                                  ? 'Target'
                                  : 'Total',
                              style: TextStyle(
                                fontSize: size / 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Legend uses legendData (so "Target" shows targetVisit)
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 10,
                children: legendData.map((s) {
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: s.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            s.label,
                            style: blackTextStyle.copyWith(fontSize: h6),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${s.value}',
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/signin',
                  (route) => false,
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            children: [
              // Top Content
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text(
                              'Hi, ${state is AuthSuccess ? state.user.name : ''}',
                              style: blackTextStyle.copyWith(
                                fontSize: h2,
                                fontWeight: semiBold,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Let`s make today count',
                        style: blackTextStyle.copyWith(
                          fontSize: h5,
                          letterSpacing: header,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: greyTextStyle.copyWith(fontSize: h6),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: greyColor,
                            size: 24,
                          ),
                        ),
                        // The red dot positioned on the top right corner
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: redColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: whiteColor,
                                width: 1.5,
                              ), // white border around dot
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Store Visit & Clock In / Out
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Store Visit Box
                  Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width / 2.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft, // Gradient starts here
                        end: Alignment.centerRight,
                        colors: [orangeColor, softOrangeColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: orangeColor.withValues(
                            alpha: 0.3,
                          ), // Match the dominant color
                          blurRadius: 12, // Controls softness
                          offset: Offset(0, 6), // X: 0, Y: 6 (downward shadow)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xffFF972D),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              'assets/icons/ic_visit.png',
                              color: whiteColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Today Store Visit',
                          style: whiteTextStyle.copyWith(fontSize: h6),
                        ),
                        Divider(color: whiteColor, thickness: 0.5),
                        SizedBox(height: 8),
                        BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            final totalVisit =
                                (state is DashboardLoaded &&
                                    state
                                            .dashboard
                                            .todayActivities
                                            ?.totalVisit !=
                                        null)
                                ? '${state.dashboard.todayActivities!.totalVisit}'
                                : '0';
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  totalVisit,
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 48,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Image.asset(
                                  'assets/icons/ic_store.png',
                                  width: 32,
                                  height: 32,
                                  color: whiteColor,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Store Clock In/Out
                  Column(
                    children: [
                      // Clock In
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: 88,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: orangeColor.withValues(alpha: (0.2)),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: orangeColor.withValues(
                                alpha: 0.1,
                              ), // Match the dominant color
                              blurRadius: 12, // Controls softness
                              offset: Offset(
                                0,
                                6,
                              ), // X: 0, Y: 6 (downward shadow)
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icons/ic_clock_in.png',
                                  width: 24,
                                  height: 24,
                                  color: blackColor,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Clock In',
                                  style: blackTextStyle.copyWith(
                                    fontSize: h6,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                final timeClockIn =
                                    (state is DashboardLoaded &&
                                        state.dashboard.incomingAttendance !=
                                            null)
                                    ? DateFormat('HH:mm').format(
                                        DateTime.parse(
                                          state.dashboard.incomingAttendance!,
                                        ),
                                      )
                                    : '--:--';
                                return Container(
                                  width: 56,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 8,
                                  ),
                                  // width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment
                                          .centerLeft, // Gradient starts here
                                      end: Alignment.centerRight,
                                      colors: [orangeColor, softOrangeColor],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      timeClockIn,
                                      style: whiteTextStyle.copyWith(
                                        fontSize: h6,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),

                      // Clock Out
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: 88,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: orangeColor.withValues(alpha: (0.2)),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: orangeColor.withValues(
                                alpha: 0.1,
                              ), // Match the dominant color
                              blurRadius: 12, // Controls softness
                              offset: Offset(
                                0,
                                6,
                              ), // X: 0, Y: 6 (downward shadow)
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icons/ic_clock_out.png',
                                  width: 24,
                                  height: 24,
                                  color: blackColor,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Clock Out',
                                  style: blackTextStyle.copyWith(
                                    fontSize: h6,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                final timeClockOut =
                                    (state is DashboardLoaded &&
                                        state.dashboard.repeatAttendance !=
                                            null)
                                    ? DateFormat('HH:mm').format(
                                        DateTime.parse(
                                          state.dashboard.repeatAttendance!,
                                        ),
                                      )
                                    : '--:--';
                                return Container(
                                  width: 56,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 8,
                                  ),
                                  // width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment
                                          .centerLeft, // Gradient starts here
                                      end: Alignment.centerRight,
                                      colors: [orangeColor, softOrangeColor],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      timeClockOut,
                                      style: whiteTextStyle.copyWith(
                                        fontSize: h6,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Report Monthly
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Report Monthly',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  // Text('See all', style: blackTextStyle.copyWith(fontSize: 12)),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 245,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        final storeVisit = (state is DashboardLoaded)
                            ? state.dashboard.storeVisitMonthly
                            : null;

                        return Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width / 2.1,
                          decoration: BoxDecoration(
                            color: subtleGreyColor,
                            border: Border.all(color: strokeColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Store Visit',
                                style: blackTextStyle.copyWith(
                                  fontSize: h5,
                                  fontWeight: semiBold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              donutChart(storeVisit),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        final todayActivities = (state is DashboardLoaded)
                            ? state.dashboard.todayActivities
                            : null;
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width / 2.4,
                              decoration: BoxDecoration(
                                color: subtleGreyColor,
                                borderRadius: BorderRadius.circular(20),
                                border: BoxBorder.all(color: strokeColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Activity',
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Attendance',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                        ),
                                      ),
                                      Text(
                                        '7',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pricing',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                        ),
                                      ),
                                      Text(
                                        todayActivities?.totalPricing ?? '0',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Stock',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                        ),
                                      ),
                                      Text(
                                        todayActivities?.totalStock ?? '0',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 10),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width / 2.4,
                              decoration: BoxDecoration(
                                color: subtleGreyColor,
                                borderRadius: BorderRadius.circular(20),
                                border: BoxBorder.all(color: strokeColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Survey',
                                    style: blackTextStyle.copyWith(
                                      fontSize: h6,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Instore',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                        ),
                                      ),
                                      Text(
                                        '11',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Expired',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                        ),
                                      ),
                                      Text(
                                        '8',
                                        style: blackTextStyle.copyWith(
                                          fontSize: h6,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Today Activities
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Today Activities',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: subtleGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_task_done.png',
                          width: 24,
                          height: 24,
                          color: blackColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Completed tasks and visits',
                          style: blackTextStyle.copyWith(fontSize: h6),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.remove_red_eye, color: blackColor),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Teams
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Teams Tracking',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: subtleGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/ic_team.png',
                                width: 18,
                                height: 17,
                                color: blackColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Teams',
                                style: blackTextStyle.copyWith(
                                  fontSize: h6,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '17',
                          style: blackTextStyle.copyWith(
                            fontSize: h6,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(height: 1, thickness: 0.5, color: blackColor),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Clock In',
                          style: blackTextStyle.copyWith(fontSize: h6),
                        ),
                        Spacer(),
                        Text(
                          '70',
                          style: blackTextStyle.copyWith(
                            fontSize: h6,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Clock Out',
                          style: blackTextStyle.copyWith(fontSize: h6),
                        ),
                        Spacer(),
                        Text(
                          '68',
                          style: blackTextStyle.copyWith(
                            fontSize: h6,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Store Visit',
                          style: blackTextStyle.copyWith(fontSize: h6),
                        ),
                        Spacer(),
                        Text(
                          '124',
                          style: blackTextStyle.copyWith(
                            fontSize: h6,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Survey',
                          style: blackTextStyle.copyWith(fontSize: h6),
                        ),
                        Spacer(),
                        Text(
                          '37',
                          style: blackTextStyle.copyWith(
                            fontSize: h6,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Approval
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Action',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/approval-list');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: tealColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_approval.png',
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Approval',
                        style: tealTextStyle.copyWith(fontWeight: semiBold),
                      ),
                      Spacer(),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: tealColor,
                        ),
                        child: Center(
                          child: Text(
                            '10',
                            style: whiteTextStyle.copyWith(fontSize: h6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Survey
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Survey',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/survey-inhouse');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_store.png',
                            width: 24,
                            height: 24,
                            color: blackColor,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Program Display Lebaran – Snack A',
                                style: blackTextStyle.copyWith(
                                  fontSize: h6,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                'Alfanow Jl. Merdeka',
                                style: blackTextStyle.copyWith(fontSize: h6),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: blackColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_store.png',
                          width: 24,
                          height: 24,
                          color: blackColor,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Program Display Lebaran – Snack A',
                              style: blackTextStyle.copyWith(
                                fontSize: h6,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              'Alfanow Jl. Merdeka',
                              style: blackTextStyle.copyWith(fontSize: h6),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: blackColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/survey-expired',
                    arguments: {'productName': 'Susu UHT'},
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_warning.png',
                            width: 24,
                            height: 24,
                            color: redColor,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expired Product - Susu UHT',
                                style: blackTextStyle.copyWith(
                                  fontSize: h6,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                'Alfanow Jl. Merdeka',
                                style: blackTextStyle.copyWith(fontSize: h6),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: blackColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
