/// Represents the app routes and their paths.
enum AppRoutes {
  login(name: 'login', path: '/login'),
  userHome(name: 'userHome', path: '/userHome'),
  userList(name: 'userList', path: '/userList'),
  tab1Home(name: 'tab1Home', path: '/tab1Home'),
  tab1Details(name: 'tab1Details', path: '/tab1Details'),
  tab2Home(name: 'tab2Home', path: '/tab2Home'),
  tab2Details(name: 'tab2Details', path: '/tab2Details'),
  tab3Home(name: 'tab3Home', path: '/tab3Home'),
  tab3Details(name: 'tab3Details', path: '/tab3Details');

  const AppRoutes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  final String name;

  /// Represents the route path
  final String path;

  @override
  String toString() => name;
}
