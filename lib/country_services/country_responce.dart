class CountryListing {
  final name;
  final flag;

  CountryListing({required this.name, required this.flag});

  factory CountryListing.fromJSON(Map<String, dynamic> json) {
    final name = json['name']['common'];
    final flag = json['flags']['png'];
    return CountryListing(name: name, flag: flag);
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
