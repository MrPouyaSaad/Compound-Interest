// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/adapters.dart';
//part 'person.g.dart';

@HiveType(typeId: 0)
class Histyory extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String amount;
  @HiveField(2)
  String interest;
  @HiveField(3)
  int period;
  @HiveField(4)
  bool isTimeCal;
  @HiveField(5)
  String netProfit;
  @HiveField(6)
  String ci;
  Histyory({
    required this.title,
    required this.amount,
    required this.interest,
    required this.period,
    required this.isTimeCal,
    required this.netProfit,
    required this.ci,
  });
}
