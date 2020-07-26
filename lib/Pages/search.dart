import 'package:covid_19/Data/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'CountryPage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search({this.countryList});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : primaryBlack,
      brightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 150,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.grey[300],
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: ListRow(
                country: suggestionList[index]['country'].toString(),
                flagUrl:
                    suggestionList[index]['countryInfo']['flag'].toString(),
                confirmed: suggestionList[index]['cases'].toString(),
                active: suggestionList[index]['active'].toString(),
                recovered: suggestionList[index]['recovered'].toString(),
                deaths: suggestionList[index]['deaths'].toString(),
              ),
            ),
            onTap: () {
              Alert(
                context: context,
                image:
                    Image.network(suggestionList[index]['countryInfo']['flag']),
                title: suggestionList[index]['country'],

                content: Card(
                  child: Column(
                    children: <Widget>[
                      Text('TODAY\'s Statistics',
                          style: TextStyle(fontSize: 16)),
                      Divider(thickness: 1, color: Colors.grey[500]),
                      MyRow(
                          'Today Cases',
                          suggestionList[index]['todayCases'].toString(),
                          Colors.blue),
                      MyRow(
                          'Today Deaths',
                          suggestionList[index]['todayDeaths'].toString(),
                          Colors.red),
                      MyRow(
                          'Today Recovered',
                          suggestionList[index]['todayRecovered'].toString(),
                          Colors.green),
                      SizedBox(height: 5),
                      Text('TOTAL Statistics', style: TextStyle(fontSize: 16)),
                      Divider(thickness: 1, color: Colors.grey[500]),
                      MyRow(
                          'Total Cases',
                          suggestionList[index]['cases'].toString(),
                          Colors.blue),
                      MyRow(
                          'Total Deaths',
                          suggestionList[index]['deaths'].toString(),
                          Colors.red),
                      MyRow(
                          'Total Recovered',
                          suggestionList[index]['recovered'].toString(),
                          Colors.green),
                      SizedBox(height: 5),
                      Text('Country INFO', style: TextStyle(fontSize: 16)),
                      Divider(thickness: 1, color: Colors.grey[500]),
                      MyRow('Total Population',
                          suggestionList[index]['population'].toString(), null),
                      MyRow('Continent',
                          suggestionList[index]['continent'].toString(), null),
                    ],
                  ),
                ),
                style: alertStyle,
                // desc: "Your Score is $x",
                buttons: [
                  DialogButton(
                    child: Text(
                      "okay",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(116, 116, 191, 1.0),
                      Color.fromRGBO(52, 138, 199, 1.0)
                    ]),
                  ),
                ],
              ).show();
            },
          );
        });
  }
}
