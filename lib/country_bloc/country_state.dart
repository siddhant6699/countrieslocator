import 'package:countrieslocator/country_services/country_responce.dart';

abstract class CountryState {}

class CountryListInitial extends CountryState {}

class CountryListLoadInProgress extends CountryState {}

class CountryListLoadSuccess extends CountryState {
  final List<CountryListing> countryListings;
  CountryListLoadSuccess({required this.countryListings});
}

class CountryListLoadError extends CountryState {
  final error;
  CountryListLoadError({required this.error});
}
