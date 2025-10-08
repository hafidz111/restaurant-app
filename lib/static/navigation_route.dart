enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  settingRoute("/setting"),
  favoriteRoute("/favorite");

  const NavigationRoute(this.name);
  final String name;
}
