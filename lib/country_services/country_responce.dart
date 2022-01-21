class CountryListing {
  final String name;
  final String flag;
  final String dialingCodeRoot;
  final String dialingCodeSuffix;
  final int population;
  final String capital;
  final String countryCode;
  Currency? currency;
  Demonyms? demonyms;

  CountryListing({
    required this.name,
    required this.flag,
    required this.dialingCodeRoot,
    required this.dialingCodeSuffix,
    required this.countryCode,
    required this.population,
    required this.currency,
    required this.capital,
    required this.demonyms,
  });

  factory CountryListing.fromJSON(Map<String, dynamic> json) {
    final String name = json['name']['common'];
    final String flag = json['flags']['png'];
    final String dialingCodeRoot = json['idd']['root'];
    final String dialingCodeSuffix = json['idd']['suffixes'][0];
    final int population = json['population'];
    final String countryCode = json["cioc"] ?? "No Country Code";
    final List<dynamic> capitalArray = json['capital'] ?? ['No Capital Found'];
    final String capital = capitalArray[0];

    Currency? currency;
    Map<String, dynamic> cMap = json["currencies"];
    cMap.forEach((k, v) {
      currency = Currency.fromJSON(cMap[k]);
    });

    Demonyms? demonyms;
    Map<String, dynamic>? dMap = json["demonyms"];
    if (dMap != null) {
      dMap.forEach((k, v) {
        demonyms = Demonyms.fromJson(dMap[k]);
      });
    }

    return CountryListing(
      name: name,
      flag: flag,
      dialingCodeRoot: dialingCodeRoot,
      dialingCodeSuffix: dialingCodeSuffix,
      countryCode: countryCode,
      population: population,
      currency: currency,
      capital: capital,
      demonyms: demonyms,
    );
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

class Currency {
  final String name;
  final String? symbol;

  Currency({required this.name, required this.symbol});

  factory Currency.fromJSON(Map<String, dynamic> json) {
    return Currency(name: json["name"], symbol: json["symbol"]);
  }
}

class Demonyms {
  final String f;
  Demonyms({required this.f});

  factory Demonyms.fromJson(Map<String, dynamic> json) {
    return Demonyms(f: json["f"]);
  }
}
