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

      try {
        final countryResponce =
            await _countryRepositry.getCountry(event.region.toLowerCase());
        yield CountryListLoadSuccess(
            countryListings: countryResponce.countrylisting);
      } catch (e) {
        yield CountryListLoadError(error: e.toString());
      }
    }
  }
}
