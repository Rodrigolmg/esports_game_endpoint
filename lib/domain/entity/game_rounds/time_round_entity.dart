part of entity;

@HiveType(typeId: 6)
class TimeRoundEntity extends HiveObject {

  final int? homeTeamSide;
  final int? outcome;
  final int? winnerCode;

  TimeRoundEntity({
    this.homeTeamSide,
    this.outcome,
    this.winnerCode,
  });
}