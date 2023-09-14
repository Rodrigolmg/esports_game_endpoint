part of entity;

@HiveType(typeId: 4)
class GameBanEntity extends HiveObject {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? slug;

  GameBanEntity({
    required this.id,
    this.name,
    this.slug,
  });
}