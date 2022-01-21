// ignore_for_file: prefer_const_constructors

import 'package:countrieslocator/country_bloc/country_bloc.dart';
import 'package:countrieslocator/country_bloc/country_event.dart';
import 'package:countrieslocator/country_bloc/country_state.dart';
import 'package:countrieslocator/country_services/country_responce.dart';
import 'package:countrieslocator/views/detailedcountryscreen_view.dart';
import 'package:flutter/material.dart';
import 'package:countrieslocator/constant.dart' as constant;
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryScreen extends StatefulWidget {
  final String continentName;
  final Color color;
  const CountryScreen(
      {Key? key, required this.continentName, required this.color})
      : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.continentName.toUpperCase()),
          centerTitle: true,
        ),
        body: BlocProvider(
            create: (context) => CountryBloc()
              ..add(CountryListRequest(region: widget.continentName)),
            child: BlocBuilder<CountryBloc, CountryState>(
              builder: (context, state) {
                if (state is CountryListLoadInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CountryListLoadSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: searchController,
                          onChanged: (text) {
                            
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            )),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  //color: Colors.grey,
                                  ),
                            ),
                            hintText: 'Search county...',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemCount: state.countryListings.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _navigateToDetailPage(
                                          countryListing:
                                              state.countryListings[index],
                                          color: widget.color);
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      child: Container(
                                        color: widget.color,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              state.countryListings[index].flag,
                                              height: 100,
                                              width: 125,
                                            ),
                                            Text(
                                                state.countryListings[index]
                                                    .name,
                                                overflow: TextOverflow.ellipsis,
                                                style: constant
                                                    .Constant.titleStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                } else if (state is CountryListLoadError) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Oops!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You may need to try again later',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ));
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }

  void _navigateToDetailPage(
      {required CountryListing countryListing, required Color color}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailedScreen(countryDetails: countryListing, color: color),
        ));
  }
}
