// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:countrieslocator/country_services/repositry.dart';
import 'package:countrieslocator/models/continent_models.dart';
import 'package:countrieslocator/views/countryscreen_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ContinentScreen extends StatefulWidget {
  const ContinentScreen({Key? key}) : super(key: key);

  @override
  _ContinentScreenState createState() => _ContinentScreenState();
}

class _ContinentScreenState extends State<ContinentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Globe"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: CarouselSlider.builder(
              itemCount: continents.length,
              itemBuilder: (context, itemIndex, realIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryScreen(
                            continentName: continents[itemIndex].name.toLowerCase(),
                            color: continents[itemIndex].color,
                          ),
                        ));
                  },
                  child: Card(
                    color: continents[itemIndex].color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        child: Image.asset(
                          continents[itemIndex].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        continents[itemIndex].name,
                        style: GoogleFonts.lato(fontSize: 25),
                      ),
                    ]),
                  ),
                );
              },
              options: CarouselOptions(
                height: 380,
                autoPlay: true,
                viewportFraction: 0.63,
                scrollDirection: Axis.vertical,
                enlargeCenterPage: true,
              ),
            )),
      ),
    );
  }
}
