import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_favorite_provider.dart';
import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/widgets/dio_glass_efek.dart';

class DioCommendCard extends StatelessWidget {
  final DioModel data;
  final Function() onTap;

  const DioCommendCard({
    Key? key,
    required this.onTap,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProviderFavorite>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
              future: provider.isFavoriteRestaurants(data.id!),
              builder: (context, snapshot) {
                var isFavorite = snapshot.data ?? false;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onTap,
                  child: SizedBox(
                    height: 290,
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 190,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$BASE_IMAGE_URL/${data.pictureId}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 15),
                              child: DioGlassEffect(
                                height: 36,
                                width: 66,
                                borderRadius: 9,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.rating.toString(),
                                      style: dioStyleSub2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      size: 23,
                                      color: Colors.amber,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15, bottom: 10),
                            decoration: const BoxDecoration(
                              color: dioColorWhite2,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        data.name.toString(),
                                        style: dioHeading4.copyWith(
                                          color: dioColorPrime,
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
                                          Expanded(
                                            child: Text(
                                              data.city.toString(),
                                              style: dioLine,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
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
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
