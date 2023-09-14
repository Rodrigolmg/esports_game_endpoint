part of entity;

@HiveType(typeId: 3)
class GameStatisticsEntity extends HiveObject {

  @HiveField(0)
  final List<dynamic>? bans;

  @HiveField(1)
  final int? barrackDestroyed;

  @HiveField(2)
  final int? barrackRemaining;

  @HiveField(3)
  final int? faction;

  @HiveField(4)
  final bool? firstBlood;

  @HiveField(5)
  final int? kills;

  @HiveField(6)
  final int? towersDestroyed;

  @HiveField(7)
  final int? towersRemaining;

  GameStatisticsEntity({
    this.bans,
    this.barrackDestroyed,
    this.barrackRemaining,
    this.faction,
    this.firstBlood,
    this.kills,
    this.towersDestroyed,
    this.towersRemaining,
  });
}