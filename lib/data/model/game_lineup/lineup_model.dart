part of model;

class LineupModel extends LineUpEntity {

  LineupModel({
    double? adr,
    int? assists,
    int? deaths,
    int? firstKillsDiff,
    int? flashAssists,
    int? headshots,
    int? kast,
    int? kdDiff,
    int? kills,
    PlayerEntity? player,
  }) : super(
    adr: adr,
    assists: assists,
    deaths: deaths,
    firstKillsDiff: firstKillsDiff,
    flashAssists: flashAssists,
    headshots: headshots,
    kast: kast,
    kdDiff: kdDiff,
    kills: kills,
    player: player
  );

  factory LineupModel.fromJson(Map<String, dynamic> json) {
    LineupModel lineupModel = LineupModel(
      adr: json['adr'],
      assists: json['assists'],
      deaths: json['deaths'],
      firstKillsDiff: json['firstKillsDiff'],
      flashAssists: json['flashAssists'],
      headshots: json['headshots'],
      kast: json['kast'],
      kdDiff: json['kdDiff'],
      kills: json['kills'],
      player: PlayerModel.fromJson(json['player']),
    );

    return lineupModel;
  }
}