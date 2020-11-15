import 'package:flutter/material.dart';

import '../main.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final FocusNode focusNode = FocusNode();
  final RegExp _numeric = RegExp(r'^-?[0-9]+$');

  bool showPassword = false;
  bool isPasswordCorrect = true;

  String password;

  bool validate(String value) {
    if (value.trim().length != 4) {
      return false;
    }
    if (!_numeric.hasMatch(value)) {
      return false;
    }
    return true;
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      titleSpacing: 10,
      title: Container(
        margin: EdgeInsets.only(top: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: greyColor,
                  ),
                  onTap: () {},
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(
                  'Session recover',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.people,
              color: greyColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
              child: Image.asset(
                "images/privat_logo_login.png",
              ),
            ),
            Text(
              "Enter password Privat24",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 20)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password Privat24",
                    style: TextStyle(
                      fontSize: 12,
                      color: isPasswordCorrect ? greenColor : Colors.red,
                    ),
                  ),
                  Stack(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: isPasswordCorrect ? greenColor : Colors.red,
                        ),
                        child: TextField(
                          focusNode: focusNode,
                          cursorHeight: 28,
                          cursorColor: greenColor,
                          keyboardType: TextInputType.number,
                          obscureText: !showPassword,
                          autofocus: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                            if (!isPasswordCorrect) {
                              setState(() {
                                isPasswordCorrect = true;
                              });
                            }
                          },
                          onSubmitted: (_) {
                            if (validate(password)) {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InmediateScreen(int.parse(password))));
                            } else {
                              setState(() {
                                isPasswordCorrect = false;
                              });
                              focusNode.requestFocus();
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          splashRadius: 20,
                          icon: Icon(
                            showPassword ? Icons.visibility_off : Icons.visibility,
                            color: greyColor,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  isPasswordCorrect
                      ? Padding(padding: const EdgeInsets.only(bottom: 30))
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Incorrect password",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: greenColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          color: greenColor,
          onPressed: () {
            if (validate(password)) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InmediateScreen(int.parse(password))));
            } else {
              setState(() {
                isPasswordCorrect = false;
              });
            }
          },
        ),
      ),
    );
  }
}
