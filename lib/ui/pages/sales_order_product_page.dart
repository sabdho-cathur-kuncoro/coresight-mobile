import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/product_tile.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';

class SalesOrderProductPage extends StatefulWidget {
  const SalesOrderProductPage({super.key});

  @override
  State<SalesOrderProductPage> createState() => _SalesOrderProductPageState();
}

class _SalesOrderProductPageState extends State<SalesOrderProductPage> {
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
  Widget build(BuildContext context) {
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
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Choose Product',
                  style: blackTextStyle.copyWith(fontSize: h5),
                ),
              ),
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
          ProductTile(productName: 'Milo Chocolate Drink Sachet 22g'),
          ProductTile(productName: 'Milo Chocolate Drink Sachet 22g'),
          ProductTile(productName: 'Milo Chocolate Drink Sachet 22g'),
          SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 20),
        color: whiteColor,
        child: Button(
          text: 'Continue',
          onPressed: () {
            Navigator.pushNamed(context, '/so-preview');
          },
          bgColor: primaryColor,
          styleText: whiteTextStyle.copyWith(
            fontSize: h4,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
