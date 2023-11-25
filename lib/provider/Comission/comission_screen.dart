

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/back_widget.dart';
import '../../main.dart';

class CommissionScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return CommissionScreenState();
  }

}


class CommissionScreenState extends State<CommissionScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          "Commission",
          textColor: white,
          showBack: true,
          backWidget: BackWidget(),
          color: context.primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                color: Color(0xAB98FCA6), // Color of the container
                border: Border.all(
                  color: Colors.green[500]!, // Dark green border color
                  width: 3.0, // 2dp border width
                ),
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Current Provider commission : 80%',
                    style: TextStyle(
                      color: Color(0xFF727171),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xAB98FCA6), // Color of the container
                  border: Border.all(
                    color: Colors.green[500]!, // Dark green border color
                    width: 3.0, // 2dp border width
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Current Referral commission : 7%',
                    style: TextStyle(
                      color: Color(0xFF727171),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xAB98FCA6), // Color of the container
                  border: Border.all(
                    color: Colors.green[500]!, // Dark green border color
                    width: 3.0, // 2dp border width
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Current Admin commission : 8.00%',
                    style: TextStyle(
                      color: Color(0xFF727171),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xAB98FCA6), // Color of the container
                  border: Border.all(
                    color: Colors.green[500]!, // Dark green border color
                    width: 3.0, // 2dp border width
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Current City Manager commission : 5.00%',
                    style: TextStyle(
                      color: Color(0xFF727171),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Provider Commission %"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xDBD1D1FF), // Color of the container
                  borderRadius: BorderRadius.circular(5.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '80%',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 14.0,
                      ),
                  ),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Referral Commission %"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xDBD1D1FF), // Color of the container
                  borderRadius: BorderRadius.circular(5.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '7.00%',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14.0,
                    ),
                  ),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Admin Commission %"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xDBD1D1FF), // Color of the container
                  borderRadius: BorderRadius.circular(5.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '8.00%',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14.0,
                    ),
                  ),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("City Manager Commission %"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity -20,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xDBD1D1FF), // Color of the container
                  borderRadius: BorderRadius.circular(5.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '5.00%',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14.0,
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
    );
  }

}