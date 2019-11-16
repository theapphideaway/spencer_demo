import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MentorIndustries extends StatefulWidget {
  MentorIndustriesState createState() => MentorIndustriesState();
}

const incidentTypes = [
  "Accountants",
  "Agriculture",
  "Air Transport",
  "Airlines",
  "Alcoholic Beverages",
  "Alternative Energy Production & Services",
  "Attorneys/Law Firms",
  "Banking",
  "Car Dealers",
  "Computer Software",
  "Construction",
  "Credit Unions",
  "Cruise Ships & Lines",
  "Defense",
  "Dentists",
  "Doctors & Other Health Professionals",
  "Education",
  "Farming",
  "Finance / Credit Companies",
  "Food & Beverage",
  "Foundations, Philanthropists & Non-Profits",
  "Funeral Services",
  "Gambling & Casinos",
  "Garbage Collection/Waste Management",
  "General Contractors",
  "Government Employees",
  "Health Professionals",
  "Hospitals & Nursing Homes",
  "Hotels, Motels & Tourism",
  "Insurance",
  "Lawyers / Law Firms",
  "Livestock",
  "Lobbyists",
  "Lodging / Tourism",
  "Logging, Timber & Paper Mills",
  "Manufacturing, Misc",
  "Mining",
  "Mortgage Bankers & Brokers",
  "Motion Picture Production & Distribution",
  "Music Production",
  "Newspaper, Magazine & Book Publishing",
  "Non-profits, Foundations & Philanthropists",
  "Nutritional & Dietary Supplements",
  "Oil & Gas",
  "Pharmaceuticals / Health Products",
  "Physicians & Other Health Professionals",
  "Printing & Publishing",
  "Private Equity & Investment Firms",
  "Professional Sports",
  "Publishing & Printing",
  "Radio/TV Stations",
  "Railroads",
  "Real Estate",
  "Religious Organizations/Clergy",
  "Restaurants & Drinking Establishments",
  "Retail Sales",
  "Schools/Education",
  "Teachers/Education",
  "Timber, Logging & Paper Mills",
  "Transportation",
  "Transportation Unions",
  "Trash Collection/Waste Management",
];

class MentorIndustriesState extends State<MentorIndustries> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                new Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Icon(Icons.clear)),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      itemCount: incidentTypes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () =>
                            {Navigator.pop(context, incidentTypes[index])},
                            title: Text(incidentTypes[index]));
                      },
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
