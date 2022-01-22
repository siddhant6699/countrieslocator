import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_cache/json_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'country_responce.dart';

class CountryRepositry {
  final baseUrl = 'restcountries.com';
  final client = http.Client();

  Future<CountryResponce> getCountry(String region, bool isOnline) async {
    final prefs = await SharedPreferences.getInstance();
    final JsonCacheMem jsonCache = JsonCacheMem(JsonCachePrefs(prefs));
    if (isOnline == true) {
      final uri = Uri.https(baseUrl, '/v3.1/region/$region');
      final response = await client.get(uri);
      final json = jsonDecode(response.body);

      Map<String, dynamic> map = {"data": json};

      await jsonCache.refresh(region, map);
      return CountryResponce.fromJSON(json);
    } else {
      final Map<String, dynamic>? localData = await jsonCache.value(region);

      return CountryResponce.fromJSON(localData!["data"]);
    }
  }
}
