// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'Navbar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  String? selected;
  double? totalInterest;
  double? monthlyInterest;
  double? monthlyInstallment;

  void loancalculation() {
    final amount = int.parse(_controller1.text) - int.parse(_controller2.text);
    final tinterest =
        amount * (double.parse(_controller3.text) / 100) * int.parse(selected!);
    final minstall = (amount + tinterest) / (int.parse(selected!) * 12);
    final minterest = tinterest / (int.parse(selected!) * 12);
    setState(() {
      totalInterest = tinterest;
      monthlyInterest = minterest;
      monthlyInstallment = minstall;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: (AppBar(
          leading: const Icon(
            Icons.notes,
            size: 30,
            color: Colors.black,
          ),
          toolbarHeight: 30,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.black,
              ),
            )
          ],
        )),
        body: body());
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 170,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(500),
                bottomRight: Radius.circular(30),
              )),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Loan',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Calculator',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputForm(
                  title: "Total Amount",
                  hintText: "e.g 9000",
                  controller: _controller1),
              inputForm(
                  title: "Down Payment",
                  hintText: "e.g 4000",
                  controller: _controller2),
              inputForm(
                  title: "Interest", hintText: "3.5", controller: _controller3),
              Text(
                'Loan Period',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  loanPeriod("1"),
                  loanPeriod("2"),
                  loanPeriod("3"),
                  loanPeriod("4"),
                  loanPeriod("5"),
                  loanPeriod("6"),
                ],
              ),
              Row(
                children: [
                  loanPeriod("7"),
                  loanPeriod("8"),
                  loanPeriod("9"),
                  loanPeriod("10"),
                  loanPeriod("11"),
                  loanPeriod("12"),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  loancalculation();
                  Future.delayed(Duration.zero);
                  showModalBottomSheet(
                      isDismissible: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Results'),
                                const SizedBox(
                                  height: 15,
                                ),
                                result(
                                    title: "Total Interest",
                                    amount: totalInterest!),
                                result(
                                    title: "Monthly Interest",
                                    amount: monthlyInterest!),
                                result(
                                    title: "Montly Installment",
                                    amount: monthlyInstallment!),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade600,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Center(
                                        child: Text("Recalculate"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text("Calculate",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget result({String? title, required double amount}) {
    return ListTile(
      title: Text(
        title!,
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text("RM" + amount.toStringAsFixed(2)),
      ),
    );
  }

  Widget loanPeriod(
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              border: title == selected
                  ? Border.all(color: Colors.green, width: 2)
                  : null,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(9)),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }

  Widget inputForm(
      {String? title, TextEditingController? controller, String? hintText}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title!,
      ),
      const SizedBox(height: 5),
      Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hintText),
          )),
      const SizedBox(
        height: 10,
      )
    ]);
  }
}
