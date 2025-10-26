import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalFilterModal {
  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    int? initialMonth,
    int? initialYear,
    bool? isFiltered,
  }) async {
    return await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _FilterContent(
        initialMonth: initialMonth ?? DateTime.now().month,
        initialYear: initialYear ?? DateTime.now().year,
        isFiltered: isFiltered ?? false,
      ),
    );
  }
}

class _FilterContent extends StatefulWidget {
  final int initialMonth;
  final int initialYear;
  final bool isFiltered;

  const _FilterContent({
    required this.initialMonth,
    required this.initialYear,
    required this.isFiltered,
  });

  @override
  State<_FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<_FilterContent> {
  late int month;
  late int year;
  late bool isFiltered;

  @override
  void initState() {
    super.initState();
    month = widget.initialMonth;
    year = widget.initialYear;
    isFiltered = widget.isFiltered;
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final startYear = currentYear - 2;
    final endYear = currentYear + 5;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter by Month & Year',
              style: blackTextStyle.copyWith(
                fontSize: h3,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 20),

            // Dropdowns
            Row(
              children: [
                // Month Dropdown
                Expanded(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: month,
                    items: List.generate(12, (index) {
                      final monthValue = index + 1;
                      final monthLabel = DateFormat(
                        'MMMM',
                      ).format(DateTime(0, monthValue));
                      return DropdownMenuItem<int>(
                        value: monthValue,
                        child: Text(monthLabel, style: blackTextStyle),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => month = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),

                // Year Dropdown
                Expanded(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: year,
                    items: List.generate(endYear - startYear + 1, (i) {
                      final y = startYear + i;
                      return DropdownMenuItem<int>(
                        value: y,
                        child: Text('$y', style: blackTextStyle),
                      );
                    }),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => year = v);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Apply Filter button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'month': month,
                  'year': year,
                  'isFiltered': true,
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: primaryColor,
              ),
              child: Text('Apply Filter', style: whiteTextStyle),
            ),
            const SizedBox(height: 12),

            // Reset button
            OutlinedButton(
              onPressed: () {
                final now = DateTime.now();
                setState(() {
                  month = now.month;
                  year = now.year;
                });
                Navigator.pop(context, {
                  'month': month,
                  'year': year,
                  'isFiltered': false,
                });
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                side: BorderSide(color: primaryColor),
              ),
              child: Text('Reset', style: primaryTextStyle),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
