import 'package:clone/cards/buy_ticket_container.dart';
import 'package:clone/cards/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

main() {
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

  CameraController controller;
  _InmediateScreenState() {
    getCameras();
  }

  getCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
    //   return Container();
    // }
    // return AspectRatio(
    //     aspectRatio: controller?.value?.aspectRatio,
    //     child: CameraPreview(controller));
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
          RaisedButton(
            child: Text("Хуй2"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp(this.trainNumber);
  final int trainNumber;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  bool isTicketBought = false;
  int numberOfTicketBought = 1;

  @override
  void initState() {
    tabController = TabController(length: choices.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
              GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Text(
                isTicketBought ? 'Fares paid' : 'Fare payment',
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
        controller: tabController,
        children: choices.map((Choice choice) {
          if (choice.title == 'TRAVEL PASS') {
            return Container(
              padding: EdgeInsets.only(left: 4, right: 4, top: 4),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Card(
                    color: Color.fromRGBO(255, 239, 239, 1),
                    child: Image.asset("images/reg_pass.png"),
                  ),
                ],
              ),
            );
          } else if (choice.title == 'TICKET') {
            if (!isTicketBought) {
              return BuyTicketCard(
                numberOfTickets: numberOfTicketBought,
                callBack: (int val) {
                  numberOfTicketBought = val;
                },
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
                    count: numberOfTicketBought,
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
          } else {
            return Container();
          }
        }).toList(),
      ),
      bottomNavigationBar: !isTicketBought
          ? Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 5.0, // soften the shadow
                  offset: Offset(
                    0.0,
                    -1.0,
                  ),
                ),
              ]),
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: RaisedButton(
                child: Text(
                  "Buy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                color: greenColor,
                onPressed: () {
                  setState(() {
                    isTicketBought = true;
                  });
                },
              ),
            )
          : null,
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
