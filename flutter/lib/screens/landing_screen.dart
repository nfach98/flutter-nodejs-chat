import 'package:flutter/material.dart';

import 'login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 48),
                  Text(
                    "Welcome to Whatsapp",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 28,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/background_landing.png",
                      color: Colors.greenAccent[700],
                      height: 340,
                      width: 340,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                        children: [
                          TextSpan(
                            text: "Agree and Continue to accept the ",
                            style: TextStyle(
                              color: Colors.grey
                            )
                          ),
                          TextSpan(
                            text: "Whatsapp Terms of Service and Privacy Policy",
                            style: TextStyle(
                              color: Colors.greenAccent[700]
                            )
                          ),
                        ]
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 48,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        color: Colors.greenAccent[700],
                        child: Center(
                          child: Text(
                            "AGREE AND CONTINUE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}