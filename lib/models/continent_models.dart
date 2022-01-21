import 'package:flutter/material.dart';
import 'package:countrieslocator/constant.dart' as constant;

class ContinentModel {
  final String name;
  final String image;
  final Color color;

  ContinentModel(
      {required this.name, required this.image, required this.color});
}
final continents=[
  ContinentModel(name: "Asia", image: "assets/asia.jpg", color: constant.Constant.skyBlue),
  ContinentModel(name: "Africa", image: "assets/africa.jpg", color: constant.Constant.lightPink),
  ContinentModel(name: "Europe", image: "assets/europe.jpg", color: constant.Constant.lightPurple),
  ContinentModel(name: "Americas", image: "assets/north_america.jpg", color: constant.Constant.lightYellow),
  ContinentModel(name: "Oceania", image: "assets/australia.jpg", color: constant.Constant.darkYellow),
];