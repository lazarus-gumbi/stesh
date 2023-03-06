import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stesh/Debit_card.dart';
import 'package:stesh/custom_dialog.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<Debit_card> cards_info = [];

  void add_card(Debit_card debit_card) {
    setState(() {
      cards_info.add(debit_card);
    });
  }

  void _handle_delete(int index) {
    setState(() {
      cards_info.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Wallet"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cards",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333),
                        fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        //TODO: the button should then submit the from and to addresses
                        //TODO: implement path drawing
                        //Display details
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return (CustomDialog(
                                add_card: add_card,
                              ));
                            });
                      },
                      icon: Icon(
                        FontAwesomeIcons.add,
                        color: Color(0xffffa700),
                        size: 20,
                      ))
                ],
              ),
              cards_info.length != 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: cards_info.length,
                          itemBuilder: (context, i) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  //<-- SEE HERE
                                  side: BorderSide(
                                      color: Colors.black54, width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xffD9D9D9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.creditCard,
                                          color: Color(0xff333333),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "" +
                                                  cards_info[i]
                                                      .card_number
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "" + cards_info[i].cardholder,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () => {_handle_delete(i)},
                                        icon: Icon(
                                          FontAwesomeIcons.trash,
                                          color: Color(0xffffa700),
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Text(
                      "You do not have any linked cards",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
