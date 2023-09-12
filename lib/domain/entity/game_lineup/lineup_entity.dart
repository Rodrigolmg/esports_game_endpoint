part of entity;

@HiveType(typeId: 1)
class LineUpEntity extends HiveObject {

  @HiveField(0)
  final double? adr;

  @HiveField(1)
  final int? assists;

  @HiveField(2)
  final int? deaths;

  @HiveField(3)
  final int? firstKillsDiff;

  @HiveField(4)
  final int? flashAssists;

  @HiveField(5)
  final int? headshots;

  @HiveField(6)
  final int? kast;

  @HiveField(7)
  final int? kdDiff;

  @HiveField(8)
  final int? kills;

  @HiveField(9)
  final PlayerEntity? player;

  LineUpEntity({
    this.adr,
    this.assists,
    this.deaths,
    this.firstKillsDiff,
    this.flashAssists,
    this.headshots,
    this.kast,
    this.kdDiff,
    this.kills,
    this.player,
  });
}