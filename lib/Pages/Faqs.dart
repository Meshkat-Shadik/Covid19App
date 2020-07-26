import 'package:covid_19/Data/source.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQs')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpansionTile(
            title:
                Text(DataSource.questionAnswers[index]['question'].toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(DataSource.questionAnswers[index]['answer'].toString()),
              )
            ],
          );
        },
        itemCount: DataSource.questionAnswers.length,
      ),
    );
  }
}
