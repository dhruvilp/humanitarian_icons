import 'package:flutter/material.dart';

import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Humanitarian Icons App',
      home: ExampleWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        title: Text('Humanitarian Icons App'),
      ),
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 768 ? 8 : 4,
        scrollDirection: Axis.vertical,
        children: List.generate(iconList.length, (index) {
          return Center(
            child: TextButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => SimpleDialog(
                    backgroundColor: Colors.black87,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            iconList[index],
                            size: 40.0,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          iconNames[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(
                iconList[index],
                color: Colors.red,
                size: 50.0,
              ),
            ),
          );
        }),
      ),
    );
  }
}
