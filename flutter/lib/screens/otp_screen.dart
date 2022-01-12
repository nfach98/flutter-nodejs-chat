import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  final String countryCode;

  const OtpScreen({Key? key, required this.number, required this.countryCode}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style: TextStyle(
            color: Colors.teal[800],
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {

            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          children: [
            SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We have sent an SMS with a code to ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "${widget.countryCode} ${widget.number}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: "\nWrong number?",
                    style: TextStyle(
                      color: Colors.cyan[800],
                      fontSize: 14,
                    ),
                  ),
                ]
              )
            ),
            SizedBox(height: 8),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(
                fontSize: 16,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) { },
            ),
            SizedBox(height: 20),
            Text(
              "Enter 6-digit code",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
            ),

            SizedBox(height: 32),

            bottomButton(
              text: "Resend SMS",
              icon: Icons.message
            ),
            SizedBox(height: 12),
            Divider(thickness: 1.5),
            SizedBox(height: 12),
            bottomButton(
              text: "Call me",
              icon: Icons.phone
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomButton({required String text, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: 24,
        ),
        SizedBox(width: 24),
        Text(
          text,
          style: TextStyle(
            color: Colors.teal,
          ),
        )
      ],
    );
  }
}
