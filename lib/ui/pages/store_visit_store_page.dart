import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/store_tile.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';

class StoreVisitStorePage extends StatefulWidget {
  const StoreVisitStorePage({super.key});

  @override
  State<StoreVisitStorePage> createState() => _StoreVisitStorePageState();
}

class _StoreVisitStorePageState extends State<StoreVisitStorePage> {
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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final type = args['type'];
    return Scaffold(
      appBar: Header(
        title: 'Store Visit ${type == 1 ? 'Check In' : 'Check Out'}',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Choose Store',
                  style: blackTextStyle.copyWith(fontSize: h5),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                height: 40,
                child: TextFormField(
                  style: blackTextStyle.copyWith(fontSize: h6),
                  decoration: InputDecoration(
                    hintText: 'find a store',
                    hintStyle: greyTextStyle.copyWith(fontSize: h6),
                    filled: true,
                    fillColor: subtleGreyColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    suffixIcon: Icon(Icons.search, size: 16, color: blackColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          StoreTile(
            storeName: 'Alfanow',
            areaName: 'Bintaro',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/store-visit-zonation',
                arguments: {'type': type},
              );
            },
          ),
          StoreTile(
            storeName: 'Alfanow',
            areaName: 'Bintaro',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/store-visit-zonation',
                arguments: {'type': type},
              );
            },
          ),
          StoreTile(
            storeName: 'Alfanow',
            areaName: 'Bintaro',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/store-visit-zonation',
                arguments: {'type': type},
              );
            },
          ),
        ],
      ),
    );
  }
}
