import 'package:mobile/data/model/daily_balance_dto.dart';

class Mapper {
  static DailyBalanceDto toDto(Map<String, dynamic> doc) {
    return DailyBalanceDto(
      date: doc['date'] ,
      cash: doc['cash'],
      pix: doc['pix'],
      credit: doc['credit'],
      debit: doc['debit'],
      opening: doc['opening'],
      closure: doc['closure'],
      expenses: doc['expenses']
    );
  }
}