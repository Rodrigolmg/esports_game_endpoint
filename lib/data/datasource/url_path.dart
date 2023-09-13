part of datasource;

class UrlPath {
  // Path with params
  static String lineUpsPath(int? gameId) => 'game/$gameId/lineups';
}