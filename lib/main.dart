import 'package:clone/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: InmediateScreen(),
    theme: ThemeData(
      primaryColor: greenColor,
      accentColor: greenColor,
    ),
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
  int count = 1;
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              decoration: InputDecoration(
                hintText: "СУДА ПИШИ кол-во билетов",
              ),
              onChanged: (value) {
                count = int.tryParse(value);
              },
            ),
          ),
          RaisedButton(
            child: Text("Хуй"),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyApp(val, count)));
            },
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp(this.trainNumber, this.count);
  final int trainNumber;
  final int count;

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
          margin: EdgeInsets.only(top: 3),
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
          height: 48,
          child: TabBar(
            controller: tabController,
            indicatorColor: greenColor,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: false,
            labelPadding: EdgeInsets.all(0),
            labelStyle: TextStyle(color: Colors.red),
            labelColor: greenColor,
            unselectedLabelColor: greyColor,
            tabs: choices.map((Choice choice) {
              return Tab(
                child: Text(
                  choice.title,
                  // style: TextStyle(color: Colors.black),
                ),
                // icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
      ),
      body: TabBarView(
        physics: ScrollPhysics(),
        controller: tabController,
        children: choices.map((Choice choice) {
          if (choice.title == 'TRAVEL PASS') {
            // return SingleChildScrollView(
            //   child: Container(
            //     alignment: Alignment.center,
            //     child: Text("No regular tickets"),
            //   ),
            // );
            return Container(
              padding: EdgeInsets.only(left: 4, right: 4, top: 4),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Card(
                    color: Color.fromRGBO(255, 239, 239, 1),
                    child: Image.asset("images/reg_pass.png"),
            //     Image(
            //   image: AssetImage('images/price_logo.png'),
            //   height: 124,
            //   width: 124,
            // ),
                  ),
                ],
              ),
            );
          }
          return Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 4),
            child: ListView(
              children: <Widget>[
                ChoiceCard(
                  choice: choice,
                  isActive: true,
                  trainNumber: widget.trainNumber,
                  count: widget.count,
                  time: DateTime.now(),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                ChoiceCard(
                  choice: choice,
                  trainNumber: 1248,
                  count: 1,
                  time: DateTime(2020, DateTime.now().month,
                      DateTime.now().day - 1, 10, 12, 38),
                ),
              ],
            ),
          );
        }).toList(),
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
