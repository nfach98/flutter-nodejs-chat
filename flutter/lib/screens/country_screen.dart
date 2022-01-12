import 'package:chat/model/country_model.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  final Function(CountryModel) setCountryData;
  final CountryModel selectedCountry;

  const CountryScreen({Key? key, required this.setCountryData, required this.selectedCountry}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<CountryModel> countries = [
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
        ),
        title: Text("Choose a country"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.teal,
            ),
            onPressed: () {

            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (_, index) => card(
          country: countries[index]
        ),
      ),
    );
  }

  Widget card({required CountryModel country}) {
    return InkWell(
      onTap: () {
        widget.setCountryData(country);
        Navigator.pop(context);
      },
      child: Card(
        margin: EdgeInsets.all(2),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          child: Row(
            children: [
              Text(country.flag),
              SizedBox(width: 16),
              Text(
                country.name,
                style: TextStyle(
                  color: widget.selectedCountry.code == country.code
                    ? Colors.teal
                    : Colors.black,
                  fontWeight: widget.selectedCountry.code == country.code
                    ? FontWeight.w700
                    : FontWeight.normal,
                ),
              ),
              Expanded(
                child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        country.code,
                        style: TextStyle(
                          color: widget.selectedCountry.code == country.code
                            ? Colors.teal
                            : Colors.black,
                          fontWeight: widget.selectedCountry.code == country.code
                            ? FontWeight.w700
                            : FontWeight.normal,
                        ),
                      )
                    ],
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
