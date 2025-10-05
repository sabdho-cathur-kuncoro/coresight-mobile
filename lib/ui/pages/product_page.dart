import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String screen;
  const ProductPage({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    Widget productTile({int? type, String? screen}) {
      return GestureDetector(
        onTap: () {
          if (screen?.toLowerCase() == 'pricing') {
            Navigator.pushNamed(
              context,
              '/pricing',
              arguments: {
                'productName': 'Milo Chocolate Drink Sachet 22g',
                'screen': screen,
              },
            );
          } else if (screen?.toLowerCase() == 'stock') {
            Navigator.pushNamed(
              context,
              '/stock',
              arguments: {
                'productName': 'KitKat 4 Finger Chocolate Bar 35g',
                'screen': screen,
              },
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: type == 1 ? lightRedColor : yellowColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  child: Image.asset(
                    width: 32,
                    height: 32,
                    'assets/icons/${type == 1 ? "ic_beverage.png" : "ic_snack.png"}',
                    color: whiteColor,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type == 1
                          ? 'Milo Chocolate Drink Sachet 22g'
                          : 'KitKat 4 Finger Chocolate Bar 35g',
                      style: blackTextStyle.copyWith(
                        fontSize: h5,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      type == 1 ? 'Beverages' : 'Snacks',
                      style: darkGreyTextStyle.copyWith(fontSize: h6),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_rounded, size: 16, color: blackColor),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: Header(
        title: screen,
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
          productTile(type: 1, screen: screen),
          productTile(type: 1, screen: screen),
          productTile(type: 1, screen: screen),
          productTile(type: 2, screen: screen),
          productTile(type: 2, screen: screen),
        ],
      ),
    );
  }
}
