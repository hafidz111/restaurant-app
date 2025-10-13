import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/data/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/data/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/data/provider/main/app_init_provider.dart';
import 'package:restaurant_app/data/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/data/provider/setting/local_notification_provider.dart';
import 'package:restaurant_app/data/provider/setting/shared_preferences_provider.dart';
import 'package:restaurant_app/data/provider/setting/switch_setting_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';
import 'package:restaurant_app/service/local_notification_service.dart';
import 'package:restaurant_app/service/shared_preferences_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => SharedPreferencesService()),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesService>(),
          ),
        ),
        Provider(
          create: (context) =>
              LocalNotificationService()..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
        ChangeNotifierProxyProvider2<
          SharedPreferencesProvider,
          LocalNotificationProvider,
          SwitchSettingProvider
        >(
          create: (context) => SwitchSettingProvider(
            prefProvider: context.read<SharedPreferencesProvider>(),
            notifProvider: context.read<LocalNotificationProvider>(),
          ),
          update: (context, pref, notif, previous) =>
              previous ??
              SwitchSettingProvider(prefProvider: pref, notifProvider: notif),
        ),
        ChangeNotifierProvider(create: (_) => AppInitProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appInitProvider = context.watch<AppInitProvider>();
    final prefProvider = context.watch<SharedPreferencesProvider>();

    if (!appInitProvider.initialized) {
      final prefProvider = context.read<SharedPreferencesProvider>();
      Future.microtask(() => appInitProvider.initialize(prefProvider));
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    final isDark = prefProvider.setting?.isDarkMode ?? false;

    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
      routes: {
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.settingRoute.name: (context) => const SettingScreen(),
        NavigationRoute.favoriteRoute.name: (context) => const FavoriteScreen(),
      },
    );
  }
}
