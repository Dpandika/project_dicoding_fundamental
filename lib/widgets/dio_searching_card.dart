import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_favorite_provider.dart';
import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/widgets/dio_glass_efek.dart';

class DioSearchingCard extends StatelessWidget {
  final DioModel data;
  final Function() onTap;

  const DioSearchingCard({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProviderFavorite>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              color: dioColorWhite2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: dioColorPrime,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("$BASE_IMAGE_URL/${data.pictureId}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child: DioGlassEffect(
                              height: 35,
                              width: 65,
                              borderRadius: 8,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.rating.toString(),
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    size: 20,
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10, top: 5),
                  decoration: BoxDecoration(
                    color: dioColorWhite2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              data.name.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dioColorBlack1,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/lokasi.png',
                                  width: 14,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  data.city.toString(),
                                  style: dioLine,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<bool>(
                          future: provider.isFavoriteRestaurants(data.id!),
                          builder: (context, snapshot) {
                            var isFavorite = snapshot.data ?? false;
                            return Container(
                              height: 45,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                                icon: const Icon(
                                    Icons.favorite_outline_rounded),
                                onPressed: () {
                                  provider.dioAddFavorite(data);
                                },
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
