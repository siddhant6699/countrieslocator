import 'dart:convert';
import 'package:http/http.dart' as http;
import 'country_responce.dart';

class CountryRepositry {
  final baseUrl = 'restcountries.com';
  final client = http.Client();

  Future<CountryResponce> getCountry(String region) async {
    final uri = Uri.https(baseUrl, '/v3.1/region/$region');
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return CountryResponce.fromJSON(json);
  }
}
