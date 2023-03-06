import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class TravelHistory extends StatefulWidget {
  const TravelHistory({Key? key}) : super(key: key);

  @override
  State<TravelHistory> createState() => _TravelHistoryState();
}

class _TravelHistoryState extends State<TravelHistory> {
  List _elements = [
    {
      'source': 'Corner Plaza',
      'destination': "Malandela's Lodge",
      "date": "12/01/2023",
      "price": "E300"
    },
    {
      'source': "Malandela's Lodge",
      'destination': "Corner Plaza",
      "date": "12/01/2023",
      "price": "E350"
    },
    {
      'source': 'Corner Plaza',
      'destination': "Solani's",
      "date": "12/01/2023",
      "price": "E150"
    },
    {
      'source': 'Corner Plaza',
      'destination': "Malandela's Lodge",
      "date": "14/01/2023",
      "price": "E350"
    },
    {
      'source': 'Corner Plaza',
      'destination': "Malandela's Lodge",
      "date": "16/01/2023",
      "price": "E350"
    },
    {
      'source': 'Corner Plaza',
      'destination': "Malandela's Lodge",
      "date": "18/01/2023",
      "price": "E250"
    },
    {
      'source': 'Corner Plaza',
      'destination': "Malandela's Lodge",
      "date": "19/01/2023",
      "price": "E300"
    },
    {
      'source': 'Corner Plaza',
      'destination': "Malandela's Lodge",
      "date": "19/01/2023",
      "price": "E250"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Trips",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            )),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Corner Plaza - Malandela's",
                        style: TextStyle(color: Color(0xff333333)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Driver: ",
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                          TextButton(
                              onPressed: () {
                                showDriverAlert(context);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(40, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: Text("Sandile Dlamini",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(255, 174, 0, 1),
                                  )))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            GroupedListView<dynamic, String>(
                elements: _elements,
                stickyHeaderBackgroundColor: Color(0xff333333),
                shrinkWrap: true,
                groupBy: (element) => element['date'],
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: false,
                groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                    ),
                itemBuilder: (c, element) {
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 196, 196, 196),
                            width: 1)),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromRGBO(255, 167, 0, 1),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  element['source'],
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      // fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 95, 95, 95),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      element['destination'],
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          // fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Text(
                                  element["price"],
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 167, 0, 1),
                                      // fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

showDriverAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          title: Text(
            "Meet Your Driver",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff333333)),
          ),
          content: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        "Sabelo Dlamini",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        "7800 0000",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Car:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        "Toyota Corolla",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Color:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        "Red",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "License Plate #:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        "ASD 123 AH",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index <= 2 ? Icons.star : Icons.star_border,
                            color: Color.fromRGBO(255, 174, 0, 1),
                          );
                        }),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(241, 194, 91, 0.658),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              color: Color.fromRGBO(255, 174, 0, 1),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
