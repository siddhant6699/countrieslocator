import 'package:countrieslocator/country_bloc/country_bloc.dart';
import 'package:countrieslocator/country_bloc/country_event.dart';
import 'package:countrieslocator/country_bloc/country_state.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.continentName),
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
                  padding: const EdgeInsets.all(1.0),
                  child: ListView.builder(
                      itemCount: state.countryListings.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: Image.network(
                              state.countryListings[index].flag,
                              width: 70,
                            ),
                            tileColor: widget.color,
                            title: Text(
                              state.countryListings[index].name,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
                            ),
                          ),
                        );
                      }),
                );
              } else if (state is CountryListLoadError) {
                print(state.error.toString());
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Oops!',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
    );
  }
}
