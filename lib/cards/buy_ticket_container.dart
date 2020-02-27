import 'package:flutter/material.dart';

class BuyTicketCard extends StatefulWidget {
  final Function(int number) callBack;
  final int numberOfTickets;

  const BuyTicketCard({Key key, this.callBack, this.numberOfTickets})
      : super(key: key);

  @override
  _BuyTicketCardState createState() => _BuyTicketCardState();
}

const Color greenColor = Color(0xFF8dc444);
const Color greyColor = Color(0xFF757575);

class _BuyTicketCardState extends State<BuyTicketCard> {
  int numberOfTickets;
  static const int defaultTicketValue = 6;

  @override
  void initState() {
    numberOfTickets = widget.numberOfTickets;
    super.initState();
  }

  void increment() {
    setState(() {
      numberOfTickets = numberOfTickets + 1;
    });
    widget.callBack(numberOfTickets);
  }

  void decrementTicketNumber() {
    if (numberOfTickets > 1) {
      setState(() {
        numberOfTickets = numberOfTickets - 1;
      });
      widget.callBack(numberOfTickets);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 4),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.only(top: 4, left: 5, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildUpperRow(),
                        _buildMiddleRow(),
                        _buildBottomRow(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total payable:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "${defaultTicketValue * numberOfTickets}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: greenColor,
                        ),
                        children: [
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '00',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' UAH',
                            style: TextStyle(
                              fontSize: 12,
                              color: greyColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '**785 Card for payments',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(padding: EdgeInsets.only(left: 5)),
                      Text(
                        "3746.26 UAH",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: greyColor)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpperRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: <Widget>[
            Checkbox(
              onChanged: (bool value) {},
              value: true,
            ),
            Text(
              "Проїзд(загальний)",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: "${defaultTicketValue * numberOfTickets}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '.00',
                style: TextStyle(fontSize: 12),
              ),
              TextSpan(
                text: ' UAH',
                style: TextStyle(
                  fontSize: 12,
                  color: greyColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleRow() {
    return Container(
      padding: EdgeInsets.only(top: 7, left: 52),
      child: Text(
        "Number of tickets",
        style: TextStyle(
          fontSize: 12,
          color: greyColor,
        ),
      ),
    );
  }

  Widget _buildBottomRow() {
    return Container(
      padding: EdgeInsets.only(top: 18, left: 48, bottom: 13),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      "$numberOfTickets",
                      style: TextStyle(color: greenColor, fontSize: 32),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "TICKETS",
                      style: TextStyle(color: greyColor, fontSize: 16),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: greyColor.withOpacity(0.1)))),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                radius: 20,
                child: Icon(
                  Icons.add_circle_outline,
                  color: greenColor,
                  size: 24,
                ),
                onTap: increment,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
              InkWell(
                radius: 20,
                child: Icon(
                  Icons.remove_circle_outline,
                  color: greenColor,
                  size: 24,
                ),
                onTap: decrementTicketNumber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
