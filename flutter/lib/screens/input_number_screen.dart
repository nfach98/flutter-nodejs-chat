import 'package:chat/custom_ui/contact_button_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/model/country_model.dart';
import 'package:chat/screens/country_screen.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputNumberScreen extends StatefulWidget {
  const InputNumberScreen({Key? key}) : super(key: key);

  @override
  _InputNumberScreenState createState() => _InputNumberScreenState();
}

class _InputNumberScreenState extends State<InputNumberScreen> {
  CountryModel country = CountryModel(name: "India", code: "+91", flag: "🇮🇳");
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              wordSpacing: 1
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "Whatsapp will send an SMS message to verifiy your number",
              style: TextStyle(
                  fontSize: 16
              ),
            ),
            SizedBox(height: 4),
            Text(
              "What's my number?",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.cyan[800]
              ),
            ),
            SizedBox(height: 16),
            countryCard(),
            SizedBox(height: 16),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (_phoneController.text.isNotEmpty) showMyDialog();
                else showEmptyDialog();
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.tealAccent[400],
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CountryScreen(
          setCountryData: setCountry,
          selectedCountry: country,
        )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.teal,
                width: 2
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(country.flag),
                      SizedBox(width: 16),
                      Text(
                        country.name,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      )
                    ],
                  )
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 28,
            )
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.teal,
                    width: 2
                ),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "+",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  Text(
                    country.code.substring(1),
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.teal,
                      width: 2
                  ),
                ),
              ),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                    hintText: "Phone number"
                ),
                style: TextStyle(
                    fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void setCountry(CountryModel country) {
    setState(() => this.country = country);
  }

  Future<void> showMyDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("We will be verifying your phone number"),
                  Text(country.code + " " + _phoneController.text),
                  SizedBox(height: 12),
                  Text(
                    "Is this OK, or would you like to edit the number?",
                    style: TextStyle(
                        fontSize: 13.5
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                    "EDIT"
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(
                    "OK"
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(
                    number: _phoneController.text,
                    countryCode: country.code,
                  )));
                },
              )
            ],
          );
        }
    );
  }

  Future<void> showEmptyDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("There is no number you entered"),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                    "OK"
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }
}