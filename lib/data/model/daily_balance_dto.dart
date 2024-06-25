import 'package:mobile/domain/closure.dart';
import 'package:mobile/domain/daily_balance.dart';

class DailyBalanceDto {
  int date;
  int cash;
  int pix;
  int card;
  int change;
  int outcomes;
  int total;

  DailyBalanceDto({
    required this.date,
    required this.cash,
    required this.pix,
    required this.card,
    required this.change,
    required this.outcomes,
    required this.total
  });

  Map<String, Object?> toMap() {
    return {
      'date': date,
      'cash': cash,
      'pix': pix,
      'card': card,
      'change': change,
      'outcomes': outcomes,
      'total': total
    };
  }
}

class Mapper {
  static Map<String, Object?> toDto(Closure model) {
    var dto = DailyBalanceDto(
      date: model.datePosition.millisecondsSinceEpoch,
      cash: (model.cashBalance * 10).toInt(),
      pix: (model.pixBalance * 10).toInt(),
      card: (model.cardBalance * 10).toInt(),
      change: (model.change * 10).toInt(),
      outcomes: (model.outcomes * 10).toInt(),
      total: (model.netBalance * 10).toInt(),
    );

    return dto.toMap();
  }

  static DailyBalance toModel(DailyBalanceDto dto) {
    return DailyBalance(
      date: DateTime.fromMillisecondsSinceEpoch(dto.date),
      cash: (dto.cash / 10).toDouble(),
      pix: (dto.pix / 10).toDouble(),
      card: (dto.card / 10).toDouble(),
      change: (dto.change / 10).toDouble(),
      outcomes: (dto.outcomes / 10).toDouble(),
      total: (dto.total / 10).toDouble(),
    );
  }
}