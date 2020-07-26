import 'dart:convert';

import 'package:covid_19/Data/source.dart';
import 'package:covid_19/panels/infoPanel.dart';
import 'package:covid_19/panels/mostAffectedPanel.dart';
import 'package:covid_19/panels/worldwidePanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) {
        return ThemeData(
          fontFamily: 'Circular',
          primaryColor: primaryBlack,
          brightness: brightness == Brightness.dark
              ? Brightness.dark
              : Brightness.light,
          scaffoldBackgroundColor: brightness == Brightness.dark
              ? Colors.blueGrey[900]
              : Colors.white,
        );
      },
      themedWidgetBuilder: (context, data) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: data,
          home: Home(),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopContainer(),
              worldData != null
                  ? WorldWidePanel(worldData)
                  : CircularProgressIndicator(),
              worldData != null
                  ? Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.blueGrey[100]),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'All Over Chart',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Text('Today Chart',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              PieChart(
                                showChartValuesOutside: false,
                                chartType: ChartType.ring,
                                chartRadius: 100,
                                chartLegendSpacing: 90.0,
                                chartValueBackgroundColor: Colors.grey[900],
                                colorList: [Colors.orange[300],Colors.blue[300],Colors.green[300],Colors.red[400]],
                                dataMap: {
                                  'Confirmed': worldData['cases'].toDouble(),
                                  'Active': worldData['active'].toDouble(),
                                  'Recovered':
                                      worldData['recovered'].toDouble(),
                                  'Deaths': worldData['deaths'].toDouble(),
                                },
                              ),
                              PieChart(
                                chartType: ChartType.ring,
                                chartRadius: 100,
                                showLegends: false,
                                colorList: [Colors.orange[300],Colors.green[300],Colors.red[400]],
                                dataMap: {
                                  'Confirmed': worldData['todayCases'].toDouble(),
                               //   'Active': worldData['active'].toDouble(),
                                  'Recovered':
                                      worldData['todayRecovered'].toDouble(),
                                  'Deaths': worldData['todayDeaths'].toDouble(),
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : CircularProgressIndicator(),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(countryData),
              InfoPanel(),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      color: Colors.orange[100],
      child: Text(
        DataSource.quote,
        style: TextStyle(
            color: Colors.orange[800],
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    );
  }
}
