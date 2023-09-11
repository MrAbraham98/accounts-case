import 'package:accounts/blocs/accounts_bloc/accounts_bloc.dart';
import 'package:accounts/data/failure/failure.dart';
import 'package:accounts/data/model/accounts_model.dart';
import 'package:accounts/presentation/accounts/widgets/account_list_item.dart';
import 'package:accounts/presentation/common_widgets/button/language_button.dart';
import 'package:accounts/presentation/common_widgets/loading/loading_widget.dart';
import 'package:accounts/utils/enum/page_state.dart';
import 'package:accounts/utils/enum/page_type_enum.dart';
import 'package:accounts/utils/extension/context_extension.dart';
import 'package:accounts/utils/extension/failure_type_localization_extension.dart';
import 'package:accounts/utils/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
final class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        final currentPage = context.read<AccountsBloc>().state.page;
        context.read<AccountsBloc>().add(
              AccountsFetched(currentPage + 1),
            );
      }
    });

    return BlocListener<AccountsBloc, AccountsState>(
      listenWhen: (previous, current) =>
          context.router.topRoute.name == context.routeData.name,
      listener: (context, state) {
        if (state.pageState == PageState.error) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(context.toLocalize(
                    state.failure?.failureType ?? FailureType.unknown)),
                actions: [
                  TextButton(
                    child: Text(context.l10n.ok),
                    onPressed: () {
                      context.read<AccountsBloc>().add(PageStateChanged(PageState.idle));
                      context.router.pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        ;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.accounts_title),
          actions: [
            const LanguageButton(),
            IconButton(
              onPressed: () {
                context
                    .read<AccountsBloc>()
                    .add(const PageTypeChanged(PageType.create));
                context.read<AccountsBloc>()
                    .add(AccountDetailDataSet(Account()));
                context.router.navigate(AccountDetailRoute());
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            return LoadingWidget(
              isLoading: state.pageState == PageState.loading,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.accounts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return AccountListItem(data: state.accounts![index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
