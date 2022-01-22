import 'dart:io';
import 'package:countrieslocator/country_bloc/country_event.dart';
import 'package:countrieslocator/country_bloc/country_state.dart';
import 'package:countrieslocator/country_services/repositry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final _countryRepositry = CountryRepositry();

  CountryBloc() : super(CountryListInitial());
  @override
  Stream<CountryState> mapEventToState(CountryEvent event) async* {
    if (event is CountryListRequest) {
      yield CountryListLoadInProgress();

      Future<bool> hasNetwork() async {
        try {
          final result = await InternetAddress.lookup('example.com');
          return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        } on SocketException catch (_) {
          return false;
        }
      }

      bool isOnline = await hasNetwork();

      try {
        final countryResponce = await _countryRepositry.getCountry(
            event.region.toLowerCase(), isOnline);
        yield CountryListLoadSuccess(
            countryListings: countryResponce.countrylisting);
      } catch (e) {
        yield CountryListLoadError(error: e.toString());
      }
    }
  }
}
