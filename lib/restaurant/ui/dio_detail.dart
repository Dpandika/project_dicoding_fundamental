// ignore_for_file: constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/utils/dio_connection.dart';
import 'package:project_dicoding_fundamental/widgets/dio_card_menu.dart';
import 'package:project_dicoding_fundamental/widgets/dio_review.dart';
import 'package:project_dicoding_fundamental/widgets/dio_glass_efek.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/menus/dio_drink.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/menus/dio_food.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_favorite_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_detail_provider.dart';

class DioDetail extends StatelessWidget {
  static const DIO_NAME = '/Dio_Detail';
  final String id;
  const DioDetail({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DioProviderRestaurantDetail>(
      context,
      listen: false,
    );
    final Connectivity connectivity = Connectivity();
    ConnectivityResult isNone = ConnectivityResult.none;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data != isNone) {
            return FutureBuilder<dynamic>(
              future: provider.getDetailsRestaurants(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData) {
                  DioModel restaurant = snapshot.data;
                  return Stack(
                    children: [
                      dioBackgroundDetail(context, restaurant),
                      appBar(context, restaurant),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          content(context, restaurant),
                          bottomBar(context, restaurant),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                        "ERROR: --> ${provider.message}",
                    ),
                  );
                }
              },
            );
          } else {
            return const DioConnection();
          }
        },
      ),
    );
  }
}

Widget dioBackgroundDetail(BuildContext context, DioModel restaurant) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.54,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(39),
      ),
      image: DecorationImage(
        image: NetworkImage(
          '$BASE_IMAGE_URL/${restaurant.pictureId}',
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: dioColorBlack1.withOpacity(0.41),
      ),
    ),
  );
}

Widget appBar(BuildContext context, DioModel data) => SafeArea(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DioGlassEffect(
          height: 51,
          width: 51,
          borderRadius: 12,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: dioColorWhite2,
            ),
          ),
        ),
        Consumer<DioProviderFavorite>(
          builder: (context, provider, child) {
            return FutureBuilder<bool>(
              future: provider.isFavoriteRestaurants(data.id!),
              builder: (context, snapshot) {
                var isFavorite = snapshot.data ?? false;
                return DioGlassEffect(
                  height: 51,
                  width: 51,
                  borderRadius: 12,
                  child: isFavorite
                      ? IconButton(
                    color: Colors.red,
                    icon: const Icon(Icons.favorite_rounded),
                    onPressed: () {
                      provider.dioNotFavorite(
                        data.id!,
                      );
                    },
                  )
                      : IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.favorite_outline_rounded),
                    onPressed: () {
                      provider.dioAddFavorite(data);
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  ),
);

Widget content(BuildContext context, DioModel restaurant) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              restaurant.name.toString(),
              style: dioHeading2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/lokasi.png',
                  width: 21,
                  color: dioColorWhite2,
                ),
                const SizedBox(width: 5),
                Text(
                  restaurant.city.toString(),
                  style: dioStyleSub2,
                ),
                const Spacer(),
                Row(
                  children: [
                    RatingBarIndicator(
                      unratedColor: dioColorWhite2,
                      itemSize: 23.0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      rating: restaurant.rating!.toDouble(),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      " (${restaurant.rating})",
                      style: dioStyleSub2,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 11),
      Container(
        height: MediaQuery.of(context).size.height * 0.52,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 21),
        decoration: const BoxDecoration(
          color: dioColorWhite2,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36),
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 21, right: 21),
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: dioColorPrime,
                borderRadius: BorderRadius.circular(21),
              ),
              child: SizedBox(
                height: 41,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = restaurant.categories![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: dioColorWhite2,
                        ),
                        child: Center(
                          child: Text("${category.name}",
                            style: dioBodyText1.copyWith(
                              color: dioColorSecond,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: restaurant.categories!.length,
                ),
              ),
            ),
            const SizedBox(height: 11),
            Center(
              child: Text(
                "DESKRIPSI",
                style: dioHeading4.copyWith(
                  letterSpacing: 3,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              restaurant.description.toString(),
              textAlign: TextAlign.center,
              style: dioLine,
            ),
            const SizedBox(height: 11),
            Center(
              child: Text(
                "MENU",
                style: dioHeading4.copyWith(
                  letterSpacing: 3,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DioCardsMenu(
                    imageUrl: "assets/makanan.png",
                    name: 'MAKANAN',
                    description: 'Temukan makanan favoritmu!',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DioFood(
                              foodMenu: restaurant.menus,
                              pictureId: restaurant.pictureId.toString(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DioCardsMenu(
                    imageUrl: "assets/minuman.png",
                    name: 'MINUMAN',
                    description: 'Temukan minuman favoritemu!',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DioDrink(
                              drinkMenu: restaurant.menus,
                              pictureId: restaurant.pictureId.toString(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                "APA KATA MEREKA?",
                style: dioHeading4.copyWith(
                  letterSpacing: 3,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final reviewer = restaurant.customerReviews![index];
                return DioReview(
                  name: reviewer.name.toString(),
                  review: reviewer.review.toString(),
                  date: reviewer.date.toString(),
                );
              },
              itemCount: restaurant.customerReviews!.length,
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    ],
  );
}

Widget bottomBar(BuildContext context, DioModel restaurant) => Container(
  height: 80,
  width: MediaQuery.of(context).size.width,
  padding: const EdgeInsets.only(left: 25, right: 15),
  decoration: const BoxDecoration(
    color: dioColorPrime,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lokasi Kami",
              style: dioStyleSub2,
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/lokasi.png',
                  width: 12,
                  color: dioColorWhite2,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    restaurant.address.toString(),
                    style: dioBodyText2.copyWith(
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(width: 10),
      Material(
        borderRadius: BorderRadius.circular(12),
        color: dioColorSecond,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: SizedBox(
            height: 60,
            width: 120,
            child: Center(
              child: Text(
                'LIHAT',
                style: dioBodyText2.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ),
      )
    ],
  ),
);
