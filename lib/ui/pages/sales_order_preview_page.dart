import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/preview_product_tile.dart';
import 'package:flutter/material.dart';

class SalesOrderPreviewPage extends StatefulWidget {
  const SalesOrderPreviewPage({super.key});

  @override
  State<SalesOrderPreviewPage> createState() => _SalesOrderPreviewPageState();
}

class _SalesOrderPreviewPageState extends State<SalesOrderPreviewPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> productList = [
      {'name': 'Milo Chocolate Drink Sachet 22g', 'qty': 2},
      {'name': 'KitKat 4 Finger Chocolate Bar 35g', 'qty': 1},
    ];
    return Scaffold(
      appBar: Header(
        title: 'Sales Order',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text(
            'Preview Product',
            style: blackTextStyle.copyWith(fontSize: h4, fontWeight: semiBold),
          ),
          SizedBox(height: 20),
          ...productList.asMap().entries.map((entry) {
            final index = entry.key;
            final product = entry.value;

            return PreviewProductTile(
              productName: product['name'],
              initialQuantity: product['qty'],
              onDelete: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Product'),
                    content: const Text(
                      'Are you sure you want to delete this product?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  setState(() {
                    productList.removeAt(index);
                  });
                }
              },
            );
          }),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              color: whiteColor,
              child: Button(
                text: 'Go Back',
                onPressed: () {
                  Navigator.pop(context);
                },
                bgColor: Colors.transparent,
                borderWidth: 1,
                borderColor: primaryColor,
                styleText: primaryTextStyle.copyWith(
                  fontSize: h4,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              color: whiteColor,
              child: Button(
                text: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(context, '/so-submit');
                },
                bgColor: primaryColor,
                styleText: whiteTextStyle.copyWith(
                  fontSize: h4,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
