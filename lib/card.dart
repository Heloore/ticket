import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'TICKET'),
  const Choice(title: 'TRAVEL PASS'),
];

class ChoiceCard extends StatefulWidget {
  ChoiceCard({Key key, this.choice, this.isActive = false, this.trainNumber})
      : ticketSeries = _generateTicketSeries(),
        super(key: key);

  final Choice choice;
  final bool isActive;
  final int trainNumber;
  final String ticketSeries;

  static String _generateTicketSeries() {
    String result = "";
    var rng = new Random();
    for (var i = 0; i < 9; i++) {
      result += rng.nextInt(10).toString();
    }
    return result;
  }

  @override
  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  static final DateTime now = DateTime.now();
  Timer timer;

  bool isActive;

  Color greenColor;
  Color greyColor;

  Duration hour = Duration(hours: 1);
  String timerString = "";

  @override
  void initState() {
    isActive = widget.isActive;
    greenColor = isActive ? Color(0xFF8dc444) : Color(0xFF888888);
    greyColor = isActive ? Color(0xFF757575) : Color(0xFF888888);

    if (isActive) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        hour = hour - Duration(seconds: 1);
        setState(() {
          timerString = hour.toString().substring(2, 7);
        });
        if (hour.inSeconds == 0) {
          isActive = false;
          timer.cancel();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null && timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Flex(
      direction: Axis.vertical,
      // height: 408,
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
      children: <Widget>[
        Card(
          color: Colors.white,
          child: Container(
            // foregroundDecoration: BoxDecoration(
            //   color: Colors.grey,
            //   backgroundBlendMode: BlendMode.saturation,
            // ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildUpperRow(),
                _buildWagonAndCentralIcon(),
                Container(
                  margin: EdgeInsets.only(top: 18, bottom: 9),
                  child: _buildLowerRow(),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "One-time ticket",
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 10,
                      ),
                    ),
                    _buildTimer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimer() {
    return isActive
        ? Container(
            margin: EdgeInsets.only(top: 12, bottom: 6),
            child: Text(
              timerString,
              style: TextStyle(
                color: greenColor,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          )
        : Container();
  }

  Widget _buildLowerRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 19),
          child: _buildLowerRowElement(
              "Date", intl.DateFormat("dd.MM.yyyy").format(now)),
        ),
        Container(
          margin: EdgeInsets.only(left: 47),
          child:
              _buildLowerRowElement("Time", intl.DateFormat.Hms().format(now)),
        ),
        Container(
          margin: EdgeInsets.only(left: 62),
          child: _buildLowerRowElement("Standard", "1 pcs."),
        ),
      ],
    );
  }

  Widget _buildLowerRowElement(String topText, String bottomTextWidget) {
    return Column(
      children: <Widget>[
        Text(topText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: greyColor,
              fontSize: 12,
            )),
        Text(
          bottomTextWidget,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isActive ? Colors.black : greyColor),
        ),
      ],
    );
  }

  Widget _buildUpperRow() {
    return Row(
      children: <Widget>[
        _buildImageCard(Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          child: Image(
            image: AssetImage('images/city_emblem.png'),
            height: 64,
            width: 64,
          ),
        )),
        Padding(padding: EdgeInsets.only(right: 5)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Днiпро",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: isActive ? Colors.black : greyColor),
            ),
            Text(
              "КП Днiпровський електротранспорт ДМР",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: isActive ? Colors.black : greyColor),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Series",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: greyColor,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text(
                  widget.ticketSeries,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: isActive ? Colors.black : greyColor),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildWagonAndCentralIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildImageCard(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Image(
              image: AssetImage('images/price_logo.png'),
              height: 124,
              width: 124,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 15)),
        Text(
          "№${widget.trainNumber}",
          style: TextStyle(
            color: isActive ? Colors.black : greyColor,
            fontWeight: FontWeight.w400,
            fontSize: 34,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 3)),
        Text(
          "Wagon",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: greyColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(Container imageContainer) {
    Widget redactedImage = isActive
        ? imageContainer
        : Container(
            foregroundDecoration: BoxDecoration(
              color: Colors.grey,
              backgroundBlendMode: BlendMode.saturation,
            ),
            child: imageContainer,
          );
    return Card(
      child: redactedImage,
    );
  }
}
