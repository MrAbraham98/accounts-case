// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AccountDetailRouteArgs>(
          orElse: () => const AccountDetailRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AccountDetailPage(
          key: args.key,
          accountId: args.accountId,
        ),
      );
    },
    AccountsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountsPage(),
      );
    },
  };
}

/// generated route for
/// [AccountDetailPage]
class AccountDetailRoute extends PageRouteInfo<AccountDetailRouteArgs> {
  AccountDetailRoute({
    Key? key,
    String? accountId,
    List<PageRouteInfo>? children,
  }) : super(
          AccountDetailRoute.name,
          args: AccountDetailRouteArgs(
            key: key,
            accountId: accountId,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountDetailRoute';

  static const PageInfo<AccountDetailRouteArgs> page =
      PageInfo<AccountDetailRouteArgs>(name);
}

class AccountDetailRouteArgs {
  const AccountDetailRouteArgs({
    this.key,
    this.accountId,
  });

  final Key? key;

  final String? accountId;

  @override
  String toString() {
    return 'AccountDetailRouteArgs{key: $key, accountId: $accountId}';
  }
}

/// generated route for
/// [AccountsPage]
class AccountsRoute extends PageRouteInfo<void> {
  const AccountsRoute({List<PageRouteInfo>? children})
      : super(
          AccountsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
