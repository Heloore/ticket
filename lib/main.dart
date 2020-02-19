import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            titleSpacing: 10,
            title: Container(
              margin: EdgeInsets.only(top: 25),
              // height: 50,
              // color: Colors.red,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.grey[600],
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Text(
                    'Fares paid',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            bottom: MyCustomAppBar(
              height: 64,
              child: TabBar(
                indicatorColor: Colors.greenAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: false,
                tabs: choices.map((Choice choice) {
                  return Tab(
                    child: Text(
                      choice.title,
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(choice.icon),
                  );
                }).toList(),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 4, left: 4, right: 4),
            child: TabBarView(
              children: choices.map((Choice choice) {
                return ListView(
                  children: <Widget>[
                    ChoiceCard(choice: choice),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    ChoiceCard(choice: choice),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'TICKET'),
  const Choice(title: 'TRAVEL PASS'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Container(
      height: 408,
      // decoration: BoxDecoration(boxShadow: [
      // BoxShadow(
      //   color: Colors.grey.withOpacity(.5),
      //   blurRadius: 100.0, // soften the shadow
      //   spreadRadius: 0.1, //extend the shadow
      //   offset: Offset(
      //     3.0,
      //     1.0,
      //   ),
      // ),
      // ]),
      child: Card(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Card(
                    child: Icon(Icons.arrow_back, size: 64),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Днiпро",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "КП Днiпровський електротранспорт ДМР",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Series",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          Text(
                            "730039290",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(child: Icon(Icons.arrow_back, size: 128)),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Text("№1364",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 34
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget child;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
