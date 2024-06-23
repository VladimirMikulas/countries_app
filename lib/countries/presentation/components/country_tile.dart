import 'package:countries_app/countries/domain/models/country_details_ui_model.dart';
import 'package:countries_app/countries/presentation/screens/country_details_page.dart';
import 'package:flutter/material.dart';


class CountryTile extends StatelessWidget {
  final CountryDetailsUiModel country;

  CountryTile({required this.country});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: country.commonName,
              child: CircleAvatar(
                backgroundImage: NetworkImage(country.flag),
              ),
            ),
            trailing: const Icon(
              Icons.navigate_next,
            ),
            title: Text(country.commonName),
            subtitle: Text(country.continents.join(', ')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountryDetailsPage(
                    countryDetails: country,
                  ),
                ),
              );
            },
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
