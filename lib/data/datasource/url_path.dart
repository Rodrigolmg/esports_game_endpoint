part of datasource;

class UrlPath {
  // Path with params
  static String lineUpsPath(int? gameId) => 'game/$gameId/lineups';
  static String gameMapImagePath(int? mapId) => 'map/$mapId/image';
  static String characterImagePath(int? characterId) => 'character/$characterId/image';
}