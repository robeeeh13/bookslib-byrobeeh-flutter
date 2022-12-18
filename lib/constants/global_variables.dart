import 'package:flutter/material.dart';

String uri = 'https://smiling-outerwear-goat.cyclic.app';
// String uri = 'http://169.254.155.212:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const appBarGradientBlue = LinearGradient(
    colors: [
      Color.fromARGB(255, 5, 83, 161),
      Color.fromARGB(255, 5, 83, 161),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const blueColor = Color(0xff0095FF);

  // STATIC IMAGES FOR CAROULSER CATEGORIES
  static const List<String> carouselImages = [
    'https://i.ibb.co/ZhDxs9Y/carousel2fix.png',
    'https://s3.envato.com/files/262098075/Image_Preview_TheBookPromotion.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Novel',
      'image': 'assets/img/novel_category.jpg',
    },
    {
      'title': 'Majalah',
      'image': 'assets/img/majalah_category.jpg',
    },
    {
      'title': 'Kamus',
      'image': 'assets/img/kamus_category.jpg',
    },
    {
      'title': 'Komik',
      'image': 'assets/img/komik_category.jpg',
    },
    {
      'title': 'Manga',
      'image': 'assets/img/manga_category.jpg',
    },
    {
      'title': 'Ensiklopedia',
      'image': 'assets/img/ensiklopedia_category.jpg',
    },
    {
      'title': 'Biografi',
      'image': 'assets/img/biografi_category.jpg',
    },
  ];
}
