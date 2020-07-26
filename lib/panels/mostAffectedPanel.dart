import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;

  MostAffectedPanel(this.countryData);
  @override
  Widget build(BuildContext context) {
    countryData.sort((b, a) {
      return a['active'].compareTo(b['active']);
    });
    //print(countryData.length);
    //  countryData.reversed.toList();
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Text(
                'Most Affected Countries',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 10,
                      margin: EdgeInsets.all(10),
                      child: Text((i + 1).toString()),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Image.network(
                        countryData[i]['countryInfo']['flag'],
                        height: 30,
                        width: 50,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                    Text(
                      countryData[i]['country'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      //  margin: EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Active affected : ' +
                              countryData[i]['active'].toString()),
                          Text(
                            'Deaths : ' + countryData[i]['deaths'].toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
