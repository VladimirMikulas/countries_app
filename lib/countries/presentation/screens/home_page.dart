import 'package:countries_app/countries/data/country_repository.dart';
import 'package:countries_app/countries/data/models/country_model.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../components/country_tile.dart';
import '../components/loading_widget.dart';

enum SortType { name, continent }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Country> _countries = <Country>[];
  List<Country> _countriesFiltered = <Country>[];
  List<Country> _countriesDisplay = <Country>[];
  bool _isLoading = true;
  SortType sorting = SortType.name;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  void loadCountries() {
    fetchCountries().then((value) {
      setState(() {
        _isLoading = false;
        _countries.addAll(value);
        sortCountries(SortType.name, _countries);
        _countriesDisplay.addAll(_countries);
        print(_countriesDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0
                    ? _searchBar()
                    : CountryTile(country: _countriesDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _countriesDisplay.length + 1,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            onPressed: _openFilterDialog,
            child: const Icon(Icons.filter_list_alt),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: const Offset(5, 5))
                    ],
                  ),
                  child: TextFormField(
                    onChanged: (searchText) {
                      searchText = searchText.toLowerCase();
                      setState(() {
                        _countriesDisplay = _countriesFiltered.where((c) {
                          final name = '${c.name?.common} ${c.name?.official}'
                              .toLowerCase();
                          final continent =
                              c.continents?.join(' ').toLowerCase() ?? '';
                          return name.contains(searchText) ||
                              continent.contains(searchText);
                        }).toList();
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search here...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  sortCountriesListView(
                    sorting == SortType.name
                        ? SortType.continent
                        : SortType.name,
                  );
                }, // Handle your callback
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: const Offset(5, 5),
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.sort,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void sortCountries(SortType type, List<Country> countries) {
    countries.sort((a, b) {
      switch (type) {
        case SortType.name:
          final nameA = a.name?.common?.toLowerCase();
          final nameB = b.name?.common?.toLowerCase();
          if (nameA != null && nameB != null) {
            return nameA.compareTo(nameB);
          }
          return 0;
        case SortType.continent:
          final nameA = a.continents != null && a.continents!.isNotEmpty
              ? a.continents?.first.toLowerCase()
              : null;
          final nameB = b.continents != null && b.continents!.isNotEmpty
              ? b.continents?.first.toLowerCase()
              : null;
          if (nameA != null && nameB != null) {
            return nameA.compareTo(nameB);
          }
          return 0;
      }
    });
  }

  void sortCountriesListView(SortType type) {
    setState(() {
      sorting = type;
    });
    sortCountries(type, _countriesDisplay);
  }

  Future<void> _openFilterDialog() async {
    setState(() {
      _isLoading = true;
    });
    await FilterListDialog.display<Country>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      headlineText: 'Select Countries',
      hideSearchField: true,
      height: 500,
      listData: _countries,
      selectedListData: _countriesFiltered,
      choiceChipLabel: (item) {
        if (item != null && item.name != null && item.name?.common != null) {
          return item.name?.common;
        } else {
          return '';
        }
      },
      validateSelectedItem: (list, val) => list != null && list.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (user, query) {
        return false;
      },
      onApplyButtonClick: (list) {
        setState(() {
          _countriesFiltered = list != null ? List.from(list) : List.empty();
          _countriesDisplay = _countriesFiltered;
          sortCountriesListView(sorting);
        });
        Navigator.pop(context);
      },
      onCloseWidgetPress: () {
        Navigator.pop(context);
      },
    ).whenComplete(
      () => setState(() {
        _isLoading = false;
      }),
    );
  }
}
