import 'package:mobile/data/model/daily_balance_dto.dart';
import 'package:mobile/data/model/resource_dto.dart';

class DataMapper {
  static DailyBalanceDto toDailyBalanceDto(Map<String, dynamic> map) {
    return DailyBalanceDto(
      date: map['date'] ,
      cash: map['cash'],
      pix: map['pix'],
      credit: map['credit'],
      debit: map['debit'],
      opening: map['opening'],
      closure: map['closure'],
      expenses: map['expenses']
    );
  }

  static ResourceDto toResourceDto(Map<String, dynamic> map) {
    return ResourceDto(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isEmployee: map['isEmployee'] == 1,
      salary: map['salary']
    );
  }
}