import 'package:countries_app/countries/domain/get_countries.dart';
import 'package:countries_app/countries/domain/models/country_details_ui_model.dart';
import 'package:countries_app/countries/presentation/components/country_tile.dart';
import 'package:countries_app/countries/presentation/components/loading_widget.dart';
import 'package:countries_app/l10n/l10n.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

enum SortType { name, continent }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CountryDetailsUiModel> _countries = <CountryDetailsUiModel>[];
  List<CountryDetailsUiModel> _countriesFiltered = <CountryDetailsUiModel>[];
  List<CountryDetailsUiModel> _countriesDisplay = <CountryDetailsUiModel>[];
  bool _isLoading = true;
  SortType sorting = SortType.name;
  late AppLocalizations l10n;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  void loadCountries() {
    GetCountries().call().then((value) {
      setState(() {
        _isLoading = false;
        _countries.addAll(value);
        sortCountries(SortType.name, _countries);
        _countriesFiltered.addAll(_countries);
        _countriesDisplay.addAll(_countries);
        print(_countriesDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.countriesAppBarTitle),
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
                          final name = '${c.commonName} ${c.officialName}'
                              .toLowerCase();
                          final continent =
                              c.continents.join(' ').toLowerCase();
                          return name.contains(searchText) ||
                              continent.contains(searchText);
                        }).toList();
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: l10n.searchBarHint,
                      prefixIcon: const Icon(Icons.search),
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

  void sortCountries(SortType type, List<CountryDetailsUiModel> countries) {
    countries.sort((a, b) {
      switch (type) {
        case SortType.name:
          final nameA = a.commonName.toLowerCase();
          final nameB = b.commonName.toLowerCase();
          return nameA.compareTo(nameB);
        case SortType.continent:
          final nameA = a.continents.first.toLowerCase();
          final nameB = b.continents.first.toLowerCase();
          return nameA.compareTo(nameB);
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
    await FilterListDialog.display<CountryDetailsUiModel>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      headlineText: l10n.filterDialogHeadline,
      hideSearchField: true,
      height: 500,
      listData: _countries,
      selectedListData: _countriesFiltered,
      choiceChipLabel: (item) {
        return item?.commonName ?? '';
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
