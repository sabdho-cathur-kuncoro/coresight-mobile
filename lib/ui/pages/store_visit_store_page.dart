import 'package:coresight/blocs/store_visit/store_visit_bloc.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/store_tile.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<StoreVisitBloc>().add(RegionStoreFetch());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // 🔍 Search bar (static)
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
                      suffixIcon: Icon(
                        Icons.search,
                        size: 16,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Expanded(
              child: BlocBuilder<StoreVisitBloc, StoreVisitState>(
                builder: (context, state) {
                  if (state is StoreVisitInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is StoreVisitFailed) {
                    return Center(child: Text('Error: ${state.e}'));
                  }

                  if (state is StoreLoaded) {
                    final list = state.data;
                    if (list.isEmpty) {
                      return const Center(child: Text('No store data'));
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return StoreTile(
                          storeName: item.storeName ?? '-',
                          areaName: item.areaName ?? '-',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/store-visit-zonation',
                              arguments: {
                                'type': type,
                                'storeId': item.storeId,
                                'storeName': item.storeName,
                                'areaName': item.areaName,
                                'storeLatitude': item.latitude,
                                'storeLongitude': item.longitude,
                              },
                            );
                          },
                        );
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
