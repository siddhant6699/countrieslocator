import 'package:flutter/foundation.dart';

class CountryListing {
  final String name;
  final String flag;
  final String countryCodeRoot;
  final String countryCodeSuffix;
  final int population;
  ////final String capital;
  Currency? currency;
  // final String currencySymbol;

  //final String demonyms;

  //final String postalCode

  CountryListing({
    required this.name,
    required this.flag,
    required this.countryCodeRoot,
    required this.countryCodeSuffix,
    required this.population,
    this.currency,
  });
  //required this.capital,

  //required this.demonyms});
  //required this.currency,
  // required this.currencySymbol,
  //
  // });

  // required this.countryCodeSuffix,

  factory CountryListing.fromJSON(Map<String, dynamic> json) {
    final String name = json['name']['common'];
    final String flag = json['flags']['png'];
    final String countryCodeRoot = json['idd']['root'];
    final String countryCodeSuffix = json['idd']['suffixes'][0];
    final int population = json['population'];
    //final String capitalArray = json['capital'] ?? ['No Capital Found'];
    //final String capital = capitalArray[0];
    //print(json['capital']);

    Currency? currency;

    Map<String, dynamic> cMap = json["currencies"];

    cMap.forEach((k, v) {
      currency = Currency.fromJSON(cMap[k]);
      print("Key : $k, Value : $v");
    });

    // final String currencySymbol = json['currencies']['symbol'];

    //final String demonyms = json['eng']['f'];

    // final String countryCodeSuffix = json['idd']['suffixes'];

    // print(name);
    // print(flag);
    // print(countryCodeSuffix);
    // print(countryCodeRoot);
    // print(population);
    ////print(capital);
    //print(currency);
    // print(currencySymbol);
    // print(demonyms);
    return CountryListing(
      name: name,
      flag: flag,
      countryCodeRoot: countryCodeRoot,
      countryCodeSuffix: countryCodeSuffix,
      population: population,
      currency: currency,
    );

    ////capital: capital,
    //demonyms: demonyms);
    //currency: currency,
    // currencySymbol: currencySymbol,
    // );

    // countryCodeSuffix: countryCodeSuffix,
  }
}

class CountryResponce {
  final List<CountryListing> countrylisting;

  CountryResponce({required this.countrylisting});

  factory CountryResponce.fromJSON(List<dynamic> json) {
    final countrylisting = (json)
        .map((listingjson) => CountryListing.fromJSON(listingjson))
        .toList();
    return CountryResponce(countrylisting: countrylisting);
  }
}
// {
//     "currencies": {
//         "INR": {
//             "name": "Indian rupee",
//             "symbol": "₹"
//         }
//     }
// }

class Currency {
  final String name;
  final String symbol;

  Currency({required this.name, required this.symbol});

  factory Currency.fromJSON(Map<String, dynamic> json) {
    return Currency(name: json["name"], symbol: json["symbol"]);
  }
}
