// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:countrieslocator/country_bloc/country_bloc.dart';
import 'package:countrieslocator/models/continent_models.dart';
import 'package:countrieslocator/views/countryscreen_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:countrieslocator/constant.dart' as constant;

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
      body: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      itemCount: continents.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => CountryBloc(),
                                    child: CountryScreen(
                                        color: continents[index].color,
                                        continentName: continents[index].name),
                                  ),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: continents[index].color,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  child: Image.asset(
                                    continents[index].image,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(continents[index].name,
                                    style: constant.Constant.titleStyle),
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(
                            1, index.isEven ? 1.25 : 1.05);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
