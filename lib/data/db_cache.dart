class DBCache {
  static Map<String, int> resourceIds = {};

  static void setResourceIds(Map<String, int> ids) {
    resourceIds = ids;
  }
}