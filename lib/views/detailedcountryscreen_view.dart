import 'package:cached_network_image/cached_network_image.dart';
import 'package:countrieslocator/country_services/country_responce.dart';
import 'package:flutter/material.dart';
import 'package:countrieslocator/constant.dart';

class DetailedScreen extends StatefulWidget {
  final CountryListing countryDetails;
  final Color color;
  const DetailedScreen(
      {Key? key, required this.countryDetails, required this.color})
      : super(key: key);

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.pureblack,
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(
          widget.countryDetails.name,
          style: Constant.titleStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          height: 350,
          child: Card(
            margin: const EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: widget.color,
            elevation: 10,
            child: Column(
              children: [
                CachedNetworkImage(
                    height: 105,
                    width: 105,
                    imageUrl: widget.countryDetails.flag,
                    errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.grey,
                          size: 55,
                        ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        ))),
                Text(
                  widget.countryDetails.countryCode,
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Capital:',
                            style: Constant.contentStyle,
                          ),
                          Text(
                            'Currency:',
                            style: Constant.contentStyle,
                          ),
                          Text(
                            'Dialing Code:',
                            style: Constant.contentStyle,
                          ),
                          Text(
                            'Population:',
                            style: Constant.contentStyle,
                          ),
                          Text(
                            'Demonym:',
                            style: Constant.contentStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.countryDetails.capital,
                            style: Constant.contentStyle,
                          ),
                          Text(
                            widget.countryDetails.currency!.name,
                            style: Constant.contentStyle,
                          ),
                          Text(
                            widget.countryDetails.dialingCodeRoot +
                                widget.countryDetails.dialingCodeSuffix,
                            style: Constant.contentStyle,
                          ),
                          Text(
                            gen(widget.countryDetails.population.toString()),
                            style: Constant.contentStyle,
                          ),
                          Text(
                            widget.countryDetails.demonyms!.f,
                            style: Constant.contentStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String gen(String num) {
    double n = double.parse(num);
    if (n > 999999 && n < 999999999) {
      return "${(n / 1000000).toStringAsFixed(1)} Million";
    } else if (n > 999999999) {
      return "${(n / 1000000000).toStringAsFixed(1)} Billion";
    } else {
      return n.toStringAsFixed(1);
    }
  }
}
