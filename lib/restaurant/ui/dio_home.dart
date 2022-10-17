// ignore_for_file: constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_detail.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_search.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_restaurant_provider.dart';
import 'package:project_dicoding_fundamental/utils/dio_result.dart';
import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/utils/dio_connection.dart';
import 'package:project_dicoding_fundamental/widgets/dio_commend_card.dart';
import 'package:project_dicoding_fundamental/widgets/dio_seat_card.dart';

class DioHome extends StatelessWidget {
  static const DIO_NAME = '/Dio_Home';
  const DioHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult isNone = ConnectivityResult.none;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: connectivity.onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.data != isNone) {
              return Column(
                children: [
                  dioMyBar(context, width),
                  content(context),
                ],
              );
            } else {
              return const DioConnection();
            }
          },
        ),
      ),
    );
  }
}

Widget dioMyBar(BuildContext context, width) => Container(
  padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
  width: width,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DIO CODING",
              style: dioHeading3.copyWith(
                color: dioColorPrime,
                letterSpacing: 2,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
              decoration: BoxDecoration(
                color: dioColorSecond,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Restaurantku",
                style: dioStyleSub1.copyWith(
                  letterSpacing: 1,
                  color: dioColorWhite2,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      Material(
        borderRadius: BorderRadius.circular(12),
        color: dioColorSecond,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          hoverColor: dioColorPrime,
          onTap: () {
            Navigator.pushNamed(context, DioSearch.DIO_NAME);
          },
          child: Container(
            height: 55,
            width: 55,
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              "assets/cari.png",
              color: dioColorWhite2,
            ),
          ),
        ),
      ),
    ],
  ),
);

Widget content(BuildContext context) => Consumer<DioProviderRestaurant>(
  builder: (context, provider, child) {
    if (provider.state == DioResult.loading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (provider.state == DioResult.hasData) {
      final restaurantMyData = provider.restaurantsList.restaurant;
      return Expanded(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            MyRestaurantLists(restaurantMyData),
            TrendsRestaurant(restaurantMyData),
          ],
        ),
      );
    } else if (provider.state == DioResult.noData) {
      return Expanded(
        child:  Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: dioColorPrime,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              provider.message,
              style: dioHeading3.copyWith(
                color: dioColorWhite2,
              ),
            ),
          ),
        ),
      );
    } else if (provider.state == DioResult.error) {
      return Expanded(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: dioColorPrime,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              provider.message,
              style: dioHeading3.copyWith(
                color: dioColorWhite2,
              ),
            ),
          ),
        ),
      );
    } else {
      return const Expanded(
        child: SizedBox(),
      );
    }
  },
);

class MyRestaurantLists extends StatelessWidget {
  final List<DioModel> myData;
  const MyRestaurantLists(this.myData, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 55),
            decoration: BoxDecoration(
              color: dioColorPrime,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "List Restaurant Kami",
              style: dioHeading3.copyWith(
                color: dioColorWhite2,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            height: 275,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final restaurant = myData[index];
                return Row(
                  children: [
                    const SizedBox(width: 15),
                    DioCommendCard(
                      data: restaurant,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DioDetail.DIO_NAME,
                          arguments: restaurant.id,
                        );
                      },
                    ),
                  ],
                );
              },
              itemCount: myData.length,
            ),
          ),
        )
      ],
    );
  }
}

class TrendsRestaurant extends StatelessWidget {
  final List<DioModel> data;
  const TrendsRestaurant(this.data, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
              decoration: BoxDecoration(
                color: dioColorPrime,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Restaurant Terbaik",
                style: dioHeading3.copyWith(
                  color: dioColorWhite2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final restaurant = data[index];
              if (restaurant.rating! >= 4.6) {
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    DioSeatCard(
                      pictureId: restaurant.pictureId.toString(),
                      name: restaurant.name.toString(),
                      description: restaurant.description.toString(),
                      rating: restaurant.rating!.toDouble(),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DioDetail.DIO_NAME,
                          arguments: restaurant.id,
                        );
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
            itemCount: data.length,
          ),
        ],
      ),
    );
  }
}
