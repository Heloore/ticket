import 'package:clone/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: InmediateScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

const Color greenColor = Color(0xFF8dc444);
const Color greyColor = Color(0xFF757575);

class InmediateScreen extends StatefulWidget {
  @override
  _InmediateScreenState createState() => _InmediateScreenState();
}

class _InmediateScreenState extends State<InmediateScreen> {
  int val = 1384;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("ВВеди сюда номер вагона и нажми на хуй"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              decoration: InputDecoration(
                hintText: "СУДА ПИШИ",
              ),
              onChanged: (value) {
                val = int.tryParse(value);
              },
            ),
          ),
          RaisedButton(
            child: Text("Хуй"),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyApp(val)));
            },
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp(this.trainNumber);
  final trainNumber;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: choices.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        titleSpacing: 10,
        title: Container(
          margin: EdgeInsets.only(top: 25),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.arrow_back,
                color: greyColor,
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
            controller: tabController,
            indicatorColor: greenColor,
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
          controller: tabController,
          children: choices.map((Choice choice) {
            if (choice.title == 'TRAVEL PASS') {
              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Text("No regular tickets"),
                ),
              );
            }
            return ListView(
              children: <Widget>[
                ChoiceCard(
                    choice: choice,
                    isActive: true,
                    trainNumber: widget.trainNumber),
                Padding(padding: EdgeInsets.only(top: 5)),
                ChoiceCard(choice: choice, trainNumber: widget.trainNumber),
              ],
            );
          }).toList(),
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
