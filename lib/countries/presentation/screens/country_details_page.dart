import 'package:countries_app/countries/data/api/models/country_details_model.dart';
import 'package:flutter/material.dart';

import '../../domain/models/country_details_ui_model.dart';

class CountryDetailsPage extends StatelessWidget {
  final CountryDetailsUiModel countryDetails;

  CountryDetailsPage({required this.countryDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(countryDetails.commonName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Hero(
                  tag: countryDetails.commonName,
                  child: Image(
                    image: NetworkImage(countryDetails.flag),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                countryDetails.officialName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                '${countryDetails.population}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    countryDetails.capital.join(', '),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 20),
                    child: Text(
                      '${countryDetails.coordinates?.latitude},${countryDetails.coordinates?.longitude}',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
