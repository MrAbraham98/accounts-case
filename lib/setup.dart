import 'package:accounts/app.dart';
import 'package:accounts/blocs/accounts_bloc/accounts_bloc.dart';
import 'package:accounts/blocs/app_cubit/app_cubit.dart';
import 'package:accounts/data/base/i_general.dart';
import 'package:accounts/data/repositories/general_repository.dart';
import 'package:accounts/data/services/general_service.dart';
import 'package:accounts/utils/client/cookie_client.dart';
import 'package:accounts/utils/constants/api_constants.dart';
import 'package:accounts/utils/enum/flavor.dart';
import 'package:accounts/utils/flavor/flavor_config.dart';
import 'package:accounts/utils/logger/app_logger.dart';
import 'package:accounts/utils/observer/bloc_observer.dart';
import 'package:accounts/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setup(Flavor flavor) async {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  final getIt = GetIt.instance;
  getIt
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<CookieClient>(
      CookieClient(
        baseUrl: ApiConstants.baseUrl,
        sendTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(minutes: 1),
      ),
    );

  final directory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: directory,
  );

  AppLogger.getInstance();
  Bloc.observer = AppBlocObserver();
  runApp(
    FlavorConfig(
      flavor: flavor, //flavor,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IGeneral>(
            create: (context) => GeneralRepository(
              generalService: GeneralService(client: getIt<CookieClient>()),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(
              create: (context) => AppCubit(),
            ),
            BlocProvider<AccountsBloc>(
              create: (context) =>
                  AccountsBloc(generalRepository: context.read<IGeneral>())
                    ..add(const AccountsFetched(1)),
            ),
          ],
          child: const App(),
        ),
      ),
    ),
  );
}
