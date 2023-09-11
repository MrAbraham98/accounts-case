import 'package:accounts/blocs/accounts_bloc/accounts_bloc.dart';
import 'package:accounts/data/failure/failure.dart';
import 'package:accounts/data/model/accounts_model.dart';
import 'package:accounts/presentation/common_widgets/loading/loading_widget.dart';
import 'package:accounts/utils/enum/page_state.dart';
import 'package:accounts/utils/enum/page_type_enum.dart';
import 'package:accounts/utils/extension/context_extension.dart';
import 'package:accounts/utils/extension/failure_type_localization_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key,this.accountId});

  final String? accountId;

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;
    final accountBloc = context.read<AccountsBloc>();

    return BlocConsumer<AccountsBloc, AccountsState>(
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
                      accountBloc.add(PageStateChanged(PageState.idle));
                      context.router.pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        final readOnly = state.pageType == PageType.readOnly;
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(context.l10n.accounts_title),
            actions: [
              Visibility(
                visible: state.pageType != PageType.create,
                child: IconButton(
                  onPressed: () =>
                      accountBloc.add(const PageTypeChanged(PageType.edit)),
                  icon: const Icon(Icons.edit),
                ),
              ),
              Visibility(
                visible: state.pageType != PageType.create,
                child: IconButton(
                  onPressed: () => accountBloc.add(AccountDeleted(accountId!)),
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
          body: LoadingWidget(
            isLoading: state.pageState == PageState.loading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                children: [
                  CustomTextField(
                    readOnly: readOnly,
                    labelText: l10n.name_label,
                    controller: accountBloc.nameController,
                  ),
                  CustomTextField(
                    readOnly: readOnly,
                    labelText: l10n.surname_label,
                    controller: accountBloc.surnameController,
                  ),
                  CustomTextField(
                    readOnly: readOnly,
                    labelText: l10n.birthday_label,
                    controller: accountBloc.birthDateController
                  ),
                  CustomTextField(
                    readOnly: readOnly,
                    labelText: l10n.sallary_label,
                    controller: accountBloc.sallaryController
                  ),
                  CustomTextField(
                    readOnly: readOnly,
                    labelText: l10n.phonenumber_label,
                    controller: accountBloc.phoneController
                  ),
                  CustomTextField(
                    readOnly: readOnly,
                    labelText: l10n.identity_label,
                    controller: accountBloc.identityController
                  ),
                  Visibility(
                    visible: state.pageType == PageType.edit,
                    child: ElevatedButton(
                      onPressed: () {
                        if (accountId != null) {
                          accountBloc.add(AccountUpdated(accountId!));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.update_button,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.pageType == PageType.create,
                    child: ElevatedButton(
                      onPressed: () {
                        accountBloc.add(const AccountCreated());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.create_button,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String labelText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
