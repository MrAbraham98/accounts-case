import 'package:accounts/blocs/app_cubit/app_cubit.dart';
import 'package:accounts/presentation/common_widgets/error/error_view.dart';
import 'package:accounts/utils/constants/app_constants.dart';
import 'package:accounts/utils/locator/service_locator.dart';
import 'package:accounts/utils/observer/router_observer.dart';
import 'package:accounts/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  AppLifecycleState? state;
  final _appRouter = getIt<AppRouter>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = state;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: AppConstants.name,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: appState.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              routerDelegate: _appRouter.delegate(
                navigatorObservers: () => [
                  AppRouterObserver(),
                ],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              builder: (BuildContext context, Widget? widget) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                  return ErrorPage(errorDetails: errorDetails);
                };
                return widget!;
              },
            );
          },
        );
      },
    );
  }
}
