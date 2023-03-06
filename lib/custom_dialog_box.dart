import 'dart:ui';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox(
      {Key? key, required this.fromAddress, required this.toAddress})
      : super(key: key);

  final String fromAddress;
  final String toAddress;

  @override
  State<CustomDialogBox> createState() => _State();
}

class _State extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
                border: Border.all(),
                color: Color(0xff333333),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.location_on,
                        color: Color.fromRGBO(255, 167, 0, 1),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '${widget.fromAddress}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Color.fromRGBO(255, 167, 0, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.circle,
                        color: Color(0xff757575),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '${widget.toAddress}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "E180.00",
                      style: TextStyle(
                          fontSize: 50,
                          color: Color.fromRGBO(255, 167, 0, 1),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'CONFIRM RIDE',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w700),
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 167, 0, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 15.0,
                minimumSize: const Size.fromHeight(50)),
          ),
        ],
      ),
    );
  }
}
