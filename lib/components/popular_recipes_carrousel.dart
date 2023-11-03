import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PopularRecipesCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> popularRecipesImages = [
      'lib/img/cat.jpg', // Ajoutez le chemin de vos images ici
      'lib/img/burger.jpg',
      'lib/img/sel.jpg',
      // Ajoutez autant d'images que vous le souhaitez
    ];

    final List<String> recipeNames = [
      'Recette 1', // Remplacez par le nom de la recette
      'Recette 2',
      'Recette 3',
      // Ajoutez les noms des recettes correspondants
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            enlargeCenterPage: true,
          ),
          items: popularRecipesImages.asMap().entries.map((entry) {
            final int index = entry.key;
            final String imagePath = entry.value;
            final String recipeName = recipeNames[index];

            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          recipeName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: popularRecipesImages.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
