part of model;

class GameStatisticsModel extends GameStatisticsEntity {

  GameStatisticsModel({
    List<dynamic>? bans,
    int? barrackDestroyed,
    int? barrackRemaining,
    int? faction,
    bool? firstBlood,
    int? kills,
    int? towersDestroyed,
    int? towersRemaining,
  }) : super(
    bans: bans,
    barrackDestroyed: barrackDestroyed,
    barrackRemaining: barrackRemaining,
    faction: faction,
    firstBlood: firstBlood,
    kills: kills,
    towersDestroyed: towersDestroyed,
    towersRemaining: towersRemaining
  );

  factory GameStatisticsModel.fromJson(Map<String, dynamic> json) {

    GameStatisticsModel gameStatisticsModel = GameStatisticsModel(
      bans: json['bans'],
      barrackDestroyed: json['barrackDestroyed'],
      barrackRemaining: json['barrackRemaining'],
      faction: json['faction'],
      firstBlood: json['firstBlood'],
      kills: json['kills'],
      towersDestroyed: json['towersDestroyed'],
      towersRemaining: json['towersRemaining'],
    );

    return gameStatisticsModel;
  }
}