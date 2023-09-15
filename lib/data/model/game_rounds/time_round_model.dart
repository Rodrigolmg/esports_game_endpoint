part of model;

class TimeRoundModel extends TimeRoundEntity {

  TimeRoundModel({
    int? homeTeamSide,
    int? outcome,
    int? winnerCode,
  });

  factory TimeRoundModel.fromJson(Map<String, dynamic> json) {
    TimeRoundModel timeRoundModel = TimeRoundModel(
      homeTeamSide: json['homeTeamSide'],
      outcome: json['outcome'],
      winnerCode: json['winnerCode'],
    );
    return timeRoundModel;
  }
}