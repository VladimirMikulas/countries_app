import 'package:countries_app/countries/domain/models/country_details_ui_model.dart';
import 'package:countries_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CountryDetailsPage extends StatelessWidget {
  final CountryDetailsUiModel countryDetails;
  List<({String label, String data})> detailItemsData =
  <({String label, String data})>[];

  CountryDetailsPage({required this.countryDetails});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    detailItemsData = [
      (label: l10n.capitalDetailItemLabel, data: countryDetails.capital
          .join(', ')),
      (label: l10n.populationDetailItemLabel, data: '${countryDetails
          .population}'),
      (label: l10n.continentsDetailItemLabel, data: countryDetails.continents
          .join(', ')),
      (label: l10n.currenciesDetailItemLabel, data: countryDetails.currencies
          .join(', ')),
      (label: l10n.languagesDetailItemLabel, data: countryDetails.languages
          .join(', ')),
      (label: l10n.timezonesDetailItemLabel, data: countryDetails.timezones
          .join(', ')),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(countryDetails.commonName),
        actions: <Widget>[
          Visibility(
            visible: countryDetails.coordinates != null,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  MapsLauncher.launchCoordinates(
                    countryDetails.coordinates?.latitude ?? -1,
                    countryDetails.coordinates?.longitude ?? -1,);
                },
                child: const Icon(
                  Icons.map,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: _detailItems(detailItemsData),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailItems(List<({String label, String data})> itemsData) {
    return Column(
      children: [
        for (final item in itemsData)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.label,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Flexible(
                child: Text(
                  item.data,
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
