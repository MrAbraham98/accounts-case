
import 'package:accounts/data/model/accounts_model.dart';
import 'package:accounts/presentation/account_detail/view/account_detail_page.dart';
import 'package:accounts/presentation/accounts/view/accounts_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View|Page|Screen|Widget,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: AccountsRoute.page,
      path:'/',
    ),
    AutoRoute(
      page: AccountDetailRoute.page,
      path:'/account-detail',
    ),




  ];
}
