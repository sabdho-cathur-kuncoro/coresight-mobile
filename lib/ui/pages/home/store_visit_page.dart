import 'package:coresight/ui/pages/product_page.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:coresight/shared/theme.dart';

class StoreVisitPage extends StatefulWidget {
  const StoreVisitPage({super.key});

  @override
  State<StoreVisitPage> createState() => _StoreVisitPageState();
}

class _StoreVisitPageState extends State<StoreVisitPage> {
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Store Visit',
                      style: blackTextStyle.copyWith(
                        fontSize: h2,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: Text(
                        'Insight at every store. Growth at every step.',
                        style: blackTextStyle.copyWith(
                          fontSize: h6,
                          letterSpacing: header,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Card Info
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current store visit',
                        style: whiteTextStyle.copyWith(fontSize: h5),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffFF962A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            'assets/icons/ic_visit.png',
                            color: whiteColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(height: 1, thickness: 0.5, color: whiteColor),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_store.png',
                        width: 18,
                        height: 18,
                        color: whiteColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Store Alfanow',
                        style: whiteTextStyle.copyWith(
                          fontSize: h5,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_visit.png',
                        width: 18,
                        height: 18,
                        color: whiteColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Tangerang Selatan',
                        style: whiteTextStyle.copyWith(
                          fontSize: h5,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(height: 1, thickness: 0.5, color: whiteColor),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Check In: 14:25',
                        style: whiteTextStyle.copyWith(fontSize: h5),
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Check Out: --:--',
                        style: whiteTextStyle.copyWith(fontSize: h5),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Main Menu
            Text(
              'Main Menu',
              style: blackTextStyle.copyWith(
                fontSize: h4,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 16),

            // Pricing, Stock, SOS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(screen: 'Pricing'),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_pricing.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Pricing',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(screen: 'Stock'),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_stock.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Stock',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sos');
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_sos.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'SOS',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Rental Display, Competitor Pricing, Sales Order
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/rental-display');
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_rental.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Rental Display',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/competitor-pricing');
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_competitor_pricing.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Competitor Pricing',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/so-product');
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_sales_order.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Sales Order',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            // Promotion, Check In, Check Out
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/promotion');
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: (0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_promotion.png',
                                color: primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Promotion',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/store-visit',
                        arguments: {'type': 1},
                      );
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: tealColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_check_in.png',
                                color: whiteColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Check In',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/store-visit',
                        arguments: {'type': 2},
                      );
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: subtleRedColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/icons/ic_check_out.png',
                                color: whiteColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Check Out',
                            style: primaryTextStyle.copyWith(
                              fontSize: h5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
