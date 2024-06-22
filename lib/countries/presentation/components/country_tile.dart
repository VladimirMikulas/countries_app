import 'package:countries_app/countries/data/api/models/country_details_model.dart';
import 'package:flutter/material.dart';


class CountryTile extends StatelessWidget {
  final CountryDetails country;

  CountryTile({required this.country});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: country.name?.common ?? '',
              child: CircleAvatar(
                backgroundImage: NetworkImage(country.flags?.png ?? ''),
              ),
            ),
            trailing: const Icon(
              Icons.navigate_next,
            ),
            title: Text('${country.name?.common}'),
            subtitle: Text(country.continents?.join(', ') ?? ''),
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountryDetailsPage(
                    countryDetails: country,
                  ),
                ),
              );*/
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
