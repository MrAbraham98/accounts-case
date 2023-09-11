import 'package:accounts/utils/client/cookie_client.dart';
import 'package:accounts/utils/router/app_router.dart';
import 'package:get_it/get_it.dart';
final getIt = GetIt.instance;

void setUp() {
  getIt
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<CookieClient>(
      CookieClient(
        baseUrl: 'https://api.mihsap.innokod.com/api',
        sendTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(minutes: 1),
      ),
    );
}
