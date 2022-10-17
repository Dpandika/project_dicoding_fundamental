import 'package:flutter/material.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';

class DioDrink extends StatelessWidget {
  final dynamic drinkMenu;
  final String pictureId;
  const DioDrink(
      {required this.drinkMenu, required this.pictureId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "$BASE_IMAGE_URL/$pictureId",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  color: dioColorWhite1,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: dioColorSecond,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Center(
                            child: Text(
                              "MENU MINUMAN",
                              style: dioHeading3.copyWith(color: dioColorSecond),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                        color: dioColorSecond,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount: drinkMenu.foods?.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final drink = drinkMenu.drinks[index];
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                      color: dioColorPrime,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    drink.name,
                                    style: dioStyleSub2.copyWith(
                                      color: dioColorPrime,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Material(
                        color: dioColorPrime,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {},
                          child: SizedBox(
                            height: 60,
                            width: 20,
                            child: Center(
                              child: Text(
                                'PESAN SEKARANG',
                                style: dioBodyText2.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Material(
                        color: dioColorPrime,
                        child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            height: 60,
                            width: 20,
                            child: Center(
                              child: Text(
                                'LIHAT LOKASI',
                                style: dioBodyText2.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
