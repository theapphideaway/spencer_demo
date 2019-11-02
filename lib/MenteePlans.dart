import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenteePlans extends StatefulWidget {
  MenteePlansState createState() => MenteePlansState();
}

const planTypes = [
  "College",
  "Military",
  "Trade School",
  "Straight To Work",
];

class MenteePlansState extends State<MenteePlans> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: Padding(
        padding: EdgeInsets.only(top: 550),
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
                      itemCount: planTypes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () =>
                            {Navigator.pop(context, planTypes[index])},
                            title: Text(planTypes[index]));
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
