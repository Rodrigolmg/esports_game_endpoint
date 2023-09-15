part of model;

class GameRoundModel extends GameRoundEntity {

  GameRoundModel({
    List<TimeRoundModel>? normalTimeRounds,
    dynamic overtimeChunkSize,
    dynamic overtimeRounds,
    int? roundsInAHalf
  }) : super (
    normalTimeRounds: normalTimeRounds,
    overtimeChunkSize: overtimeChunkSize,
    overtimeRounds: overtimeRounds,
    roundsInAHalf: roundsInAHalf
  );

  factory GameRoundModel.fromJson(Map<String, dynamic> json) {
    List<TimeRoundModel> normalTimeRounds = [];

    for (var timeRound in json['normaltimeRounds']) {
      normalTimeRounds.add(TimeRoundModel.fromJson(timeRound));
    }

    GameRoundModel gameRoundModel = GameRoundModel(
      normalTimeRounds: normalTimeRounds,
      overtimeChunkSize: json['overtimeChunkSize'],
      overtimeRounds: json['overtimeRounds'],
      roundsInAHalf: json['roundsInAHalf'],
    );

    return gameRoundModel;
  }
}