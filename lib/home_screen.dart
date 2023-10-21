// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

final value = new NumberFormat("#,##0.00", "en_US");
late double interest;
late int period;
late double amount;
late double finalCapital;
const Color yellow = Color(0xffFFAC41);
late String netProfit;
bool calculateDay = false;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String res = '';
  TextEditingController amountController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController periodOrFinalCapController = TextEditingController();
  //TextEditingController finalCapitalController = TextEditingController();
  bool isCal = false;
  bool amountEmpty = false;
  bool interestEmpty = false;
  bool periodEmpty = false;
  bool finalCapitalEmpty = false;

  void calculateButton() {
    if (amountController.text.isEmpty) {
      amountEmpty = true;
      isCal = false;
      if (interestController.text.isEmpty) {
        interestEmpty = true;
        isCal = false;
      } else {
        interestEmpty = false;
      }

      if (periodOrFinalCapController.text.isEmpty) {
        periodEmpty = true;
        isCal = false;
      }
    } else if (interestController.text.isEmpty) {
      interestEmpty = true;
      isCal = false;
      amountEmpty = false;

      if (periodOrFinalCapController.text.isEmpty) {
        periodEmpty = true;
        isCal = false;
      } else {
        periodEmpty = false;
      }
    } else if (periodOrFinalCapController.text.isEmpty) {
      periodEmpty = true;
      isCal = false;
      interestEmpty = false;
      amountEmpty = false;
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      periodEmpty = false;
      interestEmpty = false;
      amountEmpty = false;
      interest = double.parse(
            interestController.text.replaceAll(',', ''),
          ) /
          100;

      amount = double.parse(amountController.text.replaceAll(',', ''));
      double cal = amount;

      switch (calculateDay) {
        case true:
          period = 0;
          finalCapital =
              double.parse(periodOrFinalCapController.text.replaceAll(',', ''));
          do {
            period++;
            cal += cal * interest;
          } while (cal < finalCapital);
          res = '${value.format(cal)}';
          netProfit = '${value.format(cal - amount)}';
          isCal = true;
          amountController.clear();
          interestController.clear();
          periodOrFinalCapController.clear();

          // calculateDay = false;
          break;
        case false:
          period =
              int.parse(periodOrFinalCapController.text.replaceAll(',', ''));
          for (var i = 0; i < period; i++) {
            cal += cal * interest;
          }
          res = '${value.format(cal)}';
          netProfit = '${value.format(cal - amount)}';
          isCal = true;
          amountController.clear();
          interestController.clear();
          periodOrFinalCapController.clear();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: AppBar(
          title: Text('Compound Interest'),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 92,
                ).marginOnly(bottom: 48),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! amount
                      TextField(
                        inputFormatters: [
                          ThousandsFormatter(allowFraction: true),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          icon: amountEmpty
                              ? Icon(
                                  Icons.error_outlined,
                                  size: 26,
                                  color: themeData.colorScheme.error,
                                )
                              : null,
                          suffixIcon: Icon(
                            CupertinoIcons.money_dollar,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeData.colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: amountEmpty ? 2 : 1,
                              color: amountEmpty
                                  ? themeData.colorScheme.error
                                  : themeData.colorScheme.secondary,
                            ),
                          ),
                          labelText: 'Principal Amount',
                          hintText: '1,500 \$',
                        ),
                        textInputAction: TextInputAction.next,
                        controller: amountController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //! interest
                      TextField(
                        inputFormatters: [
                          ThousandsFormatter(allowFraction: true),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          icon: interestEmpty
                              ? Icon(
                                  Icons.error_outlined,
                                  size: 26,
                                  color: themeData.colorScheme.error,
                                )
                              : null,
                          suffixIcon: Icon(
                            CupertinoIcons.percent,
                            size: 18,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeData.colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: interestEmpty ? 2 : 1,
                              color: interestEmpty
                                  ? themeData.colorScheme.error
                                  : themeData.colorScheme.secondary,
                            ),
                          ),
                          labelText: 'Interest Rate',
                          hintText: '5(%)',
                        ),
                        textInputAction: TextInputAction.next,
                        controller: interestController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ).marginOnly(left: 24, right: 24),

                //! period
                MyCheckBox(
                    onEditingComplete: () {
                      setState(() {
                        calculateButton();
                      });
                    },
                    periodEmpty: periodEmpty,
                    themeData: themeData,
                    periodOrFinalCapController: periodOrFinalCapController),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          calculateButton();
                        },
                      );
                    },
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ).marginOnly(left: 24, right: 24),
                ItemsButton(
                  onTap: () {
                    setState(
                      () {
                        amountController.text = value.format(amount);
                        interestController.text =
                            value.format((interest * 100));
                        if (calculateDay) {
                          periodOrFinalCapController.text =
                              value.format(finalCapital);
                        } else {
                          periodOrFinalCapController.text = period.toString();
                        }
                      },
                    );
                  },
                  isCal: isCal,
                  themeData: themeData,
                  calculateDay: calculateDay,
                  res: res,
                ).marginOnly(top: 64, right: 8, left: 8, bottom: 64),
              ],
            ).marginOnly(top: 48, bottom: 32),
          ),
        ),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({
    Key? key,
    required this.periodEmpty,
    required this.themeData,
    required this.onEditingComplete,
    required this.periodOrFinalCapController,
  }) : super(key: key);

  final bool periodEmpty;
  final ThemeData themeData;
  final Function() onEditingComplete;
  final TextEditingController periodOrFinalCapController;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            inputFormatters: [ThousandsFormatter(allowFraction: true)],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: widget.periodEmpty
                  ? Icon(
                      Icons.error_outlined,
                      size: 26,
                      color: widget.themeData.colorScheme.error,
                    )
                  : null,
              suffixIcon: calculateDay
                  ? Icon(Icons.money_outlined)
                  : Icon(
                      CupertinoIcons.time,
                      size: 22,
                    ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.themeData.colorScheme.primary,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.periodEmpty ? 2 : 1,
                  color: widget.periodEmpty
                      ? widget.themeData.colorScheme.error
                      : widget.themeData.colorScheme.secondary,
                ),
              ),
              labelText: calculateDay ? 'Final Capital' : 'Time Period',
              hintText: calculateDay ? '7,200 \$' : 'Day or Month or Year',
            ),
            textInputAction: TextInputAction.done,
            onEditingComplete: widget.onEditingComplete,
            controller: widget.periodOrFinalCapController,
          ).marginOnly(left: 24, right: 24),
          SizedBox(height: 4),
          InkWell(
            splashColor: widget.themeData.colorScheme.background,
            highlightColor: widget.themeData.colorScheme.background,
            onTap: () {
              setState(() {
                finalCapital = 0;
                period = 0;
                calculateDay = !calculateDay;
              });
            },
            child: Container(
              child: Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity.compact,
                    activeColor: widget.themeData.colorScheme.primary,
                    value: calculateDay,
                    splashRadius: 16,
                    onChanged: (value) {
                      setState(() {
                        finalCapital = 0;
                        period = 0;
                        calculateDay = !calculateDay;
                      });
                    },
                  ),
                  Text('Calculate Time'),
                ],
              ),
            ),
          ).marginOnly(left: 16, bottom: 16),
        ],
      ),
    );
  }
}

class ItemsButton extends StatelessWidget {
  const ItemsButton({
    Key? key,
    required this.isCal,
    required this.themeData,
    required this.calculateDay,
    required this.res,
    required this.onTap,
  }) : super(key: key);

  final bool isCal;
  final ThemeData themeData;
  final bool calculateDay;
  final String res;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isCal
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 16, left: 12, right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: themeData.colorScheme.secondary,
                      ),
                      color: themeData.colorScheme.surface,
                    ),
                    child: Column(
                      children: [
                        ResRow(
                          res: '${value.format(amount)} \$',
                          color: yellow,
                          title: 'Amount :',
                        ),
                        ResRow(
                          res: '${(interest * 100)} %',
                          color: yellow,
                          title: 'Interest Rate :',
                        ),
                        ResRow(
                          res: calculateDay
                              ? '${value.format(finalCapital)} \$'
                              : '${period}',
                          color: yellow,
                          title: calculateDay
                              ? 'Final Capital :'
                              : 'Time Period :',
                        ),
                      ],
                    ),
                  ),
                ).marginAll(12.0),
                calculateDay
                    ? ResRow(
                        res: '$period',
                        color: Colors.greenAccent.shade400,
                        title: 'Time :',
                      ).marginOnly(left: 24, right: 24)
                    : SizedBox(),
                ResRow(
                  res: '$netProfit \$',
                  color: Colors.greenAccent.shade400,
                  title: 'Net Profit :',
                ).marginOnly(left: 24, right: 24),
                ResRow(
                  res: '$res \$',
                  color: Colors.greenAccent.shade400,
                  title: 'C.I :',
                ).marginOnly(left: 24, right: 24),
              ],
            )
          : Text(''),
    );
  }
}

class ResRow extends StatelessWidget {
  final String title;
  final String res;
  final Color color;
  const ResRow({
    Key? key,
    required this.title,
    required this.res,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleText(text: title),
        ResText(
          color: color,
          text: res,
        ),
      ],
    ).marginOnly(bottom: 16);
  }
}

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class ResText extends StatelessWidget {
  final String text;
  final Color color;
  const ResText({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 0.5,
          color: color,
        ),
      ),
    );
  }
}
