// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_detail.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_favorite_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_search.dart';
import 'package:project_dicoding_fundamental/utils/dio_result.dart';
import 'package:project_dicoding_fundamental/widgets/dio_searching_card.dart';

class DioFavorite extends StatefulWidget {
  static const DIO_NAME = '/Dio_Favorite';
  static const String dioMyFavoriteTitle = 'SUKA';
  const DioFavorite({Key? key}) : super(key: key);

  @override
  State<DioFavorite> createState() => _DioHome();
}

class _DioHome extends State<DioFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: dioColorWhite2),
        title: Text(
          "KESUKAANKU",
          style: dioHeading4.copyWith(color: dioColorWhite2),
        ),
      ),
      body: Consumer<DioProviderFavorite>(
        builder: (context, provider, child) {
          if (provider.state == DioResult.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) {
                final restaurant = provider.favorite[index];
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
              itemCount: provider.favorite.length,
            );
          } else {
            return Scaffold(
              backgroundColor: dioColorSecond,
              body: Center(
                child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: dioColorWhite2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Cari Restaurant Kesukaanmu!",
                          textAlign: TextAlign.center,
                          style:
                          dioHeading4.copyWith(color: dioColorPrime),
                        ),
                        const SizedBox(height: 20),
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.amber,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            hoverColor: dioColorPrime,
                            onTap: () {
                              Navigator.pushNamed(context, DioSearch.DIO_NAME);
                            },
                            child: Container(
                              height: 50,
                              width: 200,
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
                ),

              )
            );
          }
        },
      ),
    );
  }
}
