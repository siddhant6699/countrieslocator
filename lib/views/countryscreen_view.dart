// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<CountryBloc>(context)
        .add(CountryListRequest(region: widget.continentName));
  }

  List<CountryListing> searchList = [];
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
          backgroundColor: widget.color,
          title: Text(
            widget.continentName.toUpperCase(),
            style: constant.Constant.titleStyle,
          ),
          centerTitle: true,
        ),
        body: BlocListener(
          listener: (context, state) {
            if (state is CountryListLoadSuccess) {
              searchList = state.countryListings;
            }
          },
          bloc: BlocProvider.of<CountryBloc>(context),
          child: BlocBuilder<CountryBloc, CountryState>(
            builder: (context, state) {
              if (state is CountryListLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (state is CountryListLoadSuccess) {
                return countryCard(state);
              } else if (state is CountryListLoadError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Oops!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You may need to try again later',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget countryCard(CountryListLoadSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            controller: searchController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (text) {
              if (text.trimRight().isEmpty) {
                searchList = state.countryListings;
              } else {
                final filteredList = state.countryListings.where((element) {
                  return element.name
                      .toLowerCase()
                      .contains(text.toLowerCase().trimRight());
                }).toList();
                searchList = filteredList;
              }
              setState(() {});
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.grey,
              )),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: GestureDetector(
                      onTap: () {
                        _navigateToDetailPage(
                          countryListing: searchList[index],
                          color: widget.color,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          color: widget.color,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                  height: 100,
                                  width: 125,
                                  imageUrl: searchList[index].flag,
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                  placeholder: (context, url) => Center(
                                          child:
                                              const CircularProgressIndicator(
                                        color: Colors.white,
                                      ))),
                              Text(searchList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: constant.Constant.titleStyle),
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
  }

  void _navigateToDetailPage({
    required CountryListing countryListing,
    required Color color,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailedScreen(countryDetails: countryListing, color: color),
        ));
  }
}
