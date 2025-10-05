import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/utils/sos_facing_controller.dart';
import 'package:flutter/material.dart';

class SosFacingList extends StatefulWidget {
  final SosFacingController controller;
  const SosFacingList({super.key, required this.controller});

  @override
  State<SosFacingList> createState() => _SosFacingListState();
}

class _SosFacingListState extends State<SosFacingList> {
  // Two separate lists for each section
  // List<Map<String, String>> companyInputs = [
  //   {"label": "Company Brand", "facing": "0"},
  // ];
  // List<Map<String, String>> competitorInputs = [
  //   {"label": "Competitor Brand", "facing": "0"},
  // ];

  // void _addRow(List<Map<String, String>> inputs, String label) {
  //   setState(() {
  //     inputs.add({"label": label, "facing": "0"});
  //   });
  // }

  // void _removeRow(List<Map<String, String>> inputs, int index) {
  //   setState(() {
  //     if (inputs.length > 1) {
  //       inputs.removeAt(index);
  //     }
  //   });
  // }

  Future<void> _confirmDelete({
    required bool isCompany,
    required int index,
  }) async {
    final confirmed = await ConfirmationBottomSheet.show(
      context: context,
      title: "Delete Row",
      message: "Are you sure you want to delete this row?",
      confirmText: "Delete",
      confirmColor: redColor,
    );

    if (confirmed) {
      setState(() {
        if (isCompany) {
          widget.controller.removeCompanyRow(index);
        } else {
          widget.controller.removeCompetitorRow(index);
        }
      });
    } else {
      setState(() {}); // rebuild so row reappears
    }
  }

  Widget _buildSection({
    required String title,
    required List<Map<String, String>> inputs,
    required bool isCompany,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rows
        ...inputs.asMap().entries.map((entry) {
          int index = entry.key;

          return Dismissible(
            key: ValueKey("$title-$index"),
            direction: DismissDirection.endToStart,
            background: Container(
              color: redColor,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: whiteColor),
            ),
            confirmDismiss: (_) async {
              await _confirmDelete(isCompany: isCompany, index: index);
              return false; // prevent auto-dismiss
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Label Input (fixed to section type)
                  Expanded(
                    flex: 7,
                    child: CustomTextInput(
                      label: entry.value["label"]!,
                      hint: 'Type something here',
                      initialValue: entry.value["name"] ?? "",
                      onChanged: (val) {
                        setState(() {
                          entry.value["name"] = val;
                        });
                      },
                      labelStyle: blackTextStyle.copyWith(
                        fontSize: h6,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Facing Input
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomTextInput(
                        label: 'Facing',
                        hint: '0',
                        textAlign: TextAlign.center,
                        initialValue: entry.value["facing"] ?? "0",
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            entry.value["facing"] = val;
                          });
                        },
                        labelStyle: blackTextStyle.copyWith(
                          fontSize: h6,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        // Add Button for this section
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (isCompany) {
                  widget.controller.addCompanyRow();
                } else {
                  widget.controller.addCompetitorRow();
                }
              });
            },
            child: Row(
              children: [
                Icon(Icons.add, size: 16, color: blackColor),
                SizedBox(width: 4),
                Text("Add $title", style: blackTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSection(
          title: "Company Brand",
          inputs: widget.controller.companyInputs,
          isCompany: true,
        ),
        const SizedBox(height: 20),
        _buildSection(
          title: "Competitor Brand",
          inputs: widget.controller.competitorInputs,
          isCompany: false,
        ),
      ],
    );
  }
}
