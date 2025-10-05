import 'package:coresight/shared/theme.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
  int? touchedIndex;

  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  final List<_ChartSection> data = [
    _ChartSection(label: 'Done', value: 25, color: tealColor),
    _ChartSection(label: 'To Do', value: 75, color: strokeColor),
  ];

  int get totalValue => data.fold(0, (sum, item) => sum + item.value);
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'EEEE, MMMM d yyyy',
    ).format(DateTime.now());

    Widget donutChart() {
      return Column(
        children: [
          const SizedBox(height: 10),

          // === Donut Chart ===
          SizedBox(
            height: 100, // changing this value to test resizing
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                final size = width < height ? width : height;

                final reversedData = data.reversed.toList();

                // Radius values based on size
                final baseRadius = size / 4; // Smaller = thinner ring
                final touchedRadius = size / 3;
                final centerRadius = size / 3; // Bigger = thinner ring

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
                            try {
                              setState(() {
                                final index = response
                                    ?.touchedSection
                                    ?.touchedSectionIndex;
                                touchedIndex = (index != null && index >= 0)
                                    ? index
                                    : null;
                              });
                            } catch (e) {
                              print('Touch error: $e');
                            }
                          },
                        ),
                        sections: List.generate(data.length, (index) {
                          final isTouched = index == touchedIndex;
                          final section = reversedData[index];
                          final double radius = isTouched
                              ? touchedRadius
                              : baseRadius;

                          return PieChartSectionData(
                            color: section.color,
                            value: section.value.toDouble(),
                            title: '',
                            radius: radius,
                          );
                        }),
                      ),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    ),

                    // Center Label
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (touchedIndex != null &&
                                  touchedIndex! >= 0 &&
                                  touchedIndex! < reversedData.length)
                              ? '${reversedData[touchedIndex!].value}%'
                              : '$totalValue%',
                          style: TextStyle(
                            fontSize: size / 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          touchedIndex != null
                              ? reversedData[touchedIndex!].label
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

          // Legend
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: data.map((section) {
              return Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: section.color,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        section.label,
                        style: blackTextStyle.copyWith(fontSize: h6),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${section.value}',
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          children: [
            // Top Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, John Doe',
                      style: blackTextStyle.copyWith(
                        fontSize: h1,
                        fontWeight: semiBold,
                      ),
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
                  width: MediaQuery.of(context).size.width / 2.2,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '3',
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
                      ),
                    ],
                  ),
                ),

                // Store Clock In/Out
                Column(
                  children: [
                    // Clock In
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
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
                          Container(
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
                                '08:00',
                                style: whiteTextStyle.copyWith(
                                  fontSize: h6,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    // Clock Out
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
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
                          Container(
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
                                '--:--',
                                style: whiteTextStyle.copyWith(
                                  fontSize: h6,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 30),

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
                Text('See all', style: blackTextStyle.copyWith(fontSize: 12)),
              ],
            ),

            SizedBox(height: 16),

            // Report Monthly
            SizedBox(
              height: 245,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width / 2.1,
                    decoration: BoxDecoration(
                      color: subtleGreyColor,
                      border: BoxBorder.all(color: strokeColor),
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
                        SizedBox(height: 10),
                        donutChart(),
                      ],
                    ),
                  ),
                  Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Attendance',
                                  style: blackTextStyle.copyWith(fontSize: h6),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pricing',
                                  style: blackTextStyle.copyWith(fontSize: h6),
                                ),
                                Text(
                                  '25',
                                  style: blackTextStyle.copyWith(
                                    fontSize: h6,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Stock',
                                  style: blackTextStyle.copyWith(fontSize: h6),
                                ),
                                Text(
                                  '18',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Instore',
                                  style: blackTextStyle.copyWith(fontSize: h6),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expired',
                                  style: blackTextStyle.copyWith(fontSize: h6),
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
            SizedBox(height: 16),
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

            // Today Activities
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
            SizedBox(height: 16),
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
                            'Expired Product - Susu UHT E',
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
          ],
        ),
      ),
    );
  }
}
