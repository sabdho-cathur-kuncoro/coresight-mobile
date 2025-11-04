import 'package:coresight/blocs/product/product_bloc.dart';
import 'package:coresight/models/product_model.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  final String screen;
  const ProductPage({super.key, required this.screen});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: lightBackgroundColor,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
    context.read<ProductBloc>().add(ProductFetch());
  }

  @override
  Widget build(BuildContext context) {
    Widget productTile({int? type, String? screen, required ProductModel product}) {
      return GestureDetector(
        onTap: () {
          if (screen?.toLowerCase() == 'pricing') {
            Navigator.pushNamed(
              context,
              '/pricing',
              arguments: {
                'productName': product.productName,
                'productId': product.productId,
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
                      product.productName ?? '-',
                      style: blackTextStyle.copyWith(
                        fontSize: h5,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      product.categoryName ?? '-',
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
        title: widget.screen,
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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
                SizedBox(height: 16),
              ],
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductFailed) {
                    return Center(child: Text('Error: ${state.e}'));
                  }

                  if (state is ProductLoaded) {
                    final list = state.data;
                    if (list.isEmpty) {
                      return const Center(child: Text('No attendance data'));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return productTile(type: 1, screen: widget.screen, product: item);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
