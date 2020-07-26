import 'package:covid_19/Data/source.dart';
import 'package:covid_19/Pages/CountryPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorldWidePanel extends StatelessWidget {
  final Map worldData;
  WorldWidePanel(this.worldData);

  @override
  Widget build(BuildContext context) {
    var formattedDate = (DateFormat('dd-MM-yyyy hh:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(worldData['updated'])));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Worldwide',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Text(
                    'Regional',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: primaryBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
          Container(
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green[100],
            ),
            child: Text(
              'Updated at $formattedDate',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 5),
          GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2),
            children: <Widget>[
              StatusPanel(
                  Colors.red[100],
                  Colors.red,
                  'CONFIRMED',
                  worldData['cases'].toString(),
                  worldData['todayCases'].toString()),
              StatusPanel(Colors.blue[100], Colors.blue[900], 'ACTIVE',
                  worldData['active'].toString(), ''),
              StatusPanel(
                  Colors.green[100],
                  Colors.green[900],
                  'RECOVERED',
                  worldData['recovered'].toString(),
                  worldData['todayRecovered'].toString()),
              StatusPanel(
                  Colors.grey[300],
                  Colors.grey[900],
                  'DEATHS',
                  worldData['deaths'].toString(),
                  worldData['todayDeaths'].toString()),
              
            ],
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String countTotal;
  final String countToday;

  StatusPanel(this.panelColor, this.textColor, this.title, this.countTotal,
      this.countToday);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 500,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: panelColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: textColor)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Total : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black)),
              Text(countTotal,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(countToday == '' ? '' : 'Today : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black)),
              Text(countToday,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor)),
            ],
          ),
        ],
      ),
    );
  }
}
