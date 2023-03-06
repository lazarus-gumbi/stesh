import 'dart:ui';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:stesh/wallet_screen.dart';

import 'Debit_card.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Function add_card;

  CustomDialog({Key? key, required this.add_card}) : super(key: key);

  final _card_number_controller = TextEditingController();

  final _expiry_date_controller = TextEditingController();

  final _cvc_controller = TextEditingController();

  final _cardholder_name_controller = TextEditingController();

  // formatter for card number
  var maskFormatter = new MaskTextInputFormatter(
      mask: '####-####-####-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void handleSubmit() {
    print(_card_number_controller.text);
    String c_number =
        _card_number_controller.text.replaceAll(RegExp('[^0-9]'), "");
    Debit_card db_card = Debit_card(
        int.parse(c_number),
        _expiry_date_controller.text,
        int.parse(_cvc_controller.text),
        _cardholder_name_controller.text);

    add_card(db_card);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 0,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  color: Color(0xff333333),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add new card",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Divider(
                    color: Colors.white60,
                  ),
                  TextField(
                    controller: _card_number_controller,
                    inputFormatters: [maskFormatter],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black45),
                        ),
                        hintText: '0000-0000-0000-0000',
                        labelText: 'Card Number',
                        suffixIcon: Icon(Icons.credit_card),
                        iconColor: Colors.black45),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _expiry_date_controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black45),
                              ),
                              hintText: 'MM/YY',
                              labelText: 'Expiary Date',
                              labelStyle: TextStyle(fontSize: 12),
                              suffixIcon: Icon(Icons.date_range),
                              iconColor: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _cvc_controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black45),
                              ),
                              hintText: '000',
                              labelText: 'CVC',
                              suffixIcon: Icon(Icons.info),
                              iconColor: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _cardholder_name_controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black45),
                        ),
                        hintText: 'John Doe',
                        labelText: "Cardholder's Name",
                        suffixIcon: Icon(Icons.person),
                        iconColor: Colors.black45),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                handleSubmit();
                //  TODO: confirm all fields are filled then add to the cards datastructure
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Add Card',
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
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

// contentBox(context) {
  
//   return }
