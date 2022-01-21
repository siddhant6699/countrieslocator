abstract class CountryEvent {}

class CountryListRequest extends CountryEvent {
  final String region;
  CountryListRequest({required this.region});
}
