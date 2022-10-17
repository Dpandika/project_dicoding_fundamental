// ignore_for_file: constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/data/model/dio_response.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_detail.dart';
import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/utils/dio_connection.dart';
import 'package:project_dicoding_fundamental/widgets/dio_searching_card.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_search_provider.dart';

class DioSearch extends StatefulWidget {
  static const DIO_NAME = '/Dio_Search';
  const DioSearch({Key? key}) : super(key: key);

  @override
  State<DioSearch> createState() => _DioHomes();
}

class _DioHomes extends State<DioSearch> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult isNone = ConnectivityResult.none;
    var provider = Provider.of<DioProviderRestaurantSearch>(
      context,
      listen: false,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: dioColorWhite1),
        title: Text(
          "CARI RESTAURANT",
          style: dioHeading4.copyWith(color: dioColorWhite2),
        ),
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.data != isNone) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Restaurant',
                        labelText: 'Cari di sini...',
                        contentPadding:
                        const EdgeInsets.only(left: 20, top: 35),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onChanged: (query) {
                        setState(() {});
                      },
                    ),
                  ),
                  FutureBuilder(
                    future: provider.searchingRestaurants(
                      searchController.text,
                    ),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data.runtimeType == DioToResponse) {
                          DioToResponse restaurantSnapshot = snapshot.data;
                          return Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.5 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2),
                              itemBuilder: (BuildContext context, index) {
                                final restaurant =
                                restaurantSnapshot.restaurant[index];
                                return DioSearchingCard(
                                  data: restaurant,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DioDetail.DIO_NAME,
                                      arguments: restaurant.id,
                                    );
                                  },
                                );
                              },
                              itemCount: restaurantSnapshot.restaurant.length,
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/restaurant.png'),
                                  const SizedBox(height: 30),
                                  DelayedDisplay(
                                    delay: const Duration(seconds: 1),
                                    child: Text(
                                      "PENCARIAN KOSONG? SEGERA CARI RESTAURANT KESUKAANMU!",
                                      style:
                                      dioHeading3.copyWith(color: dioColorSecond),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Text("ERROR --> ${provider.message}"),
                        );
                      }
                    },
                  ),
                ],
              );
            } else {
              return const DioConnection();
            }
          }),
    );
  }
}
