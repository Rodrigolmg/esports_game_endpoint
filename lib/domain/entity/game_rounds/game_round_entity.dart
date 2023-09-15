part of entity;

@HiveType(typeId: 5)
class GameRoundEntity extends HiveObject{

  @HiveField(0)
  final List<TimeRoundEntity>? normalTimeRounds;

  @HiveField(1)
  final dynamic overtimeChunkSize;

  @HiveField(2)
  final dynamic overtimeRounds;

  @HiveField(3)
  final int? roundsInAHalf;

  GameRoundEntity({
    this.normalTimeRounds,
    this.overtimeChunkSize,
    this.overtimeRounds,
    this.roundsInAHalf,
  });
}