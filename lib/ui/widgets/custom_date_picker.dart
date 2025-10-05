import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.label,
    this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate; // always initialized

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    // trigger callback immediately with default date
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateSelected(_selectedDate);
    });
  }

  Future<void> _pickDate() async {
    // final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top label
        Text(
          widget.label,
          style: blackTextStyle.copyWith(fontSize: h6, fontWeight: semiBold),
        ),
        const SizedBox(height: 8),

        // Date box
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: primaryColor, width: 0.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
                const Icon(Icons.calendar_today_rounded, size: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
