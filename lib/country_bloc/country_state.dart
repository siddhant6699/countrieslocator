import 'package:countrieslocator/country_services/country_responce.dart';

abstract class CountryState {}

class CountryListInitial extends CountryState {}

class CountryListLoadInProgress extends CountryState {}

class CountryListLoadSuccess extends CountryState {
  final List<CountryListing> countryListings;
  final bool isOnline;
  CountryListLoadSuccess(
      {required this.countryListings, required this.isOnline});
}

class CountryListLoadError extends CountryState {
  final String error;
  CountryListLoadError({required this.error});
}
