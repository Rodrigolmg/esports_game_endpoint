part of entity;

@HiveType(typeId: 2)
class PlayerEntity extends HiveObject {

  final int id;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? shortName;
  final String? slug;
  final int? userCount;

  PlayerEntity({
    required this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.shortName,
    this.slug,
    this.userCount,
  });
}