import 'dart:async';

import 'package:accounts/data/base/i_general.dart';
import 'package:accounts/data/failure/failure.dart';
import 'package:accounts/data/failure/failure_exception_handler.dart';
import 'package:accounts/data/model/accounts_model.dart';
import 'package:accounts/utils/enum/page_state.dart';
import 'package:accounts/utils/enum/page_type_enum.dart';
import 'package:accounts/utils/locator/service_locator.dart';
import 'package:accounts/utils/router/app_router.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'accounts_event.dart';

part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({required IGeneral generalRepository})
      : _generalRepository = generalRepository,
        super(const AccountsState()) {
    on<AccountsFetched>(_accountsFetched);
    on<PageTypeChanged>(_pageTypeChanged);
    on<AccountUpdated>(_accountUpdated);
    on<AccountDeleted>(_accountDeleted);
    on<AccountCreated>(_accountCreated);
    on<PageStateChanged>(_pageStateChanged);
    on<AccountDetailDataSet>(_accountDetailDataSet);
  }

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final birthDateController = TextEditingController();
  final sallaryController = TextEditingController();
  final phoneController = TextEditingController();
  final identityController = TextEditingController();

  final IGeneral _generalRepository;

  FutureOr<void> _accountsFetched(AccountsFetched event,
      Emitter<AccountsState> emit,) async {
    try {
      emit(state.copyWith(pageState: PageState.loading));
      final accountsList =
      await _generalRepository.getAccounts(page: event.page);
      if (state.accounts != null) {
        accountsList.insertAll(0, state.accounts!);
      }
      emit(
        state.copyWith(
          pageState: PageState.loaded,
          accounts: accountsList,
          page: event.page,
        ),
      );
    } on Failure catch (error, stacktrace) {
      emit(state.copyWith(pageState: PageState.error, failure: error));
      addError(error, stacktrace);
    } catch (e) {
      emit(state.copyWith(
          pageState: PageState.error,
          failure: Failure(failureType: FailureType.unknown)));
    }
  }

  FutureOr<void> _pageTypeChanged(PageTypeChanged event,
      Emitter<AccountsState> emit,) {
    emit(state.copyWith(pageType: event.pageType));
  }

  FutureOr<void> _accountUpdated(AccountUpdated event,
      Emitter<AccountsState> emit,) async {
    try {
      emit(state.copyWith(pageState: PageState.loading));
      final account = createAccountModel();
      final result = await _generalRepository.updateAccount(
        id: event.id,
        account: account,
      );
      final index =
      state.accounts!.indexWhere((element) => element.id == result.id);

      final updatedList = List.of(state.accounts!);
      updatedList.replaceRange(index, index + 1, [result]);
      emit(
        state.copyWith(
          pageState: PageState.loaded,
          accounts: updatedList,
        ),
      );
      await getIt<AppRouter>().navigate(const AccountsRoute());
    } on Failure catch (error, stacktrace) {
      emit(state.copyWith(pageState: PageState.error, failure: error));
      addError(error, stacktrace);
    } on FormatException {
      emit(
        state.copyWith(
          pageState: PageState.error,
          failure: Failure(failureType: FailureType.dateFormat),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          pageState: PageState.error,
          failure: Failure(failureType: FailureType.unknown)));
    }
  }

  FutureOr<void> _accountDeleted(AccountDeleted event,
      Emitter<AccountsState> emit,) async {
    try {
      emit(state.copyWith(pageState: PageState.loading));
      final result = await _generalRepository.deleteAccount(id: event.id);

      final updatedList = List.of(state.accounts!);
      updatedList.removeWhere((element) => element.id == result.id);
      emit(
        state.copyWith(
          pageState: PageState.loaded,
          accounts: updatedList,
        ),
      );
      await getIt<AppRouter>().navigate(const AccountsRoute());
    } on Failure catch (error, stacktrace) {
      emit(state.copyWith(pageState: PageState.error, failure: error));
      addError(error, stacktrace);
    } catch (e) {
      emit(state.copyWith(
          pageState: PageState.error,
          failure: Failure(failureType: FailureType.unknown)));
    }
  }

  FutureOr<void> _accountCreated(AccountCreated event,
      Emitter<AccountsState> emit,) async {
    try {
      emit(state.copyWith(pageState: PageState.loading));
      final account = createAccountModel();
      final result = await _generalRepository.createAccount(account: account);
      final updatedList = List.of(state.accounts!);
      updatedList.add(result);
      emit(
        state.copyWith(
          pageState: PageState.loaded,
          accounts: updatedList,
        ),
      );
      await getIt<AppRouter>().navigate(const AccountsRoute());
    } on Failure catch (error, stacktrace) {
      emit(state.copyWith(pageState: PageState.error, failure: error));
      addError(error, stacktrace);
    } on FormatException {
      emit(
        state.copyWith(
          pageState: PageState.error,
          failure: Failure(failureType: FailureType.dateFormat),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          pageState: PageState.error,
          failure: Failure(failureType: FailureType.unknown)));
    }
  }

  Account createAccountModel() {
    if (identityController.value.text.length != 11) {
      throw Failure(failureType: FailureType.identityFormat);
    }
    final account = Account(
      name: nameController.value.text,
      surname: surnameController.value.text,
      birthdate: DateFormat('dd/MM/yyyy')
          .parse('${birthDateController.value.text}')
          .toString(),
      sallary: sallaryController.value.text,
      phoneNumber: phoneController.value.text,
      identity: identityController.value.text,
    );
    return account;
  }

  FutureOr<void> _pageStateChanged(PageStateChanged event,
      Emitter<AccountsState> emit) {
    emit(state.copyWith(pageState: event.pageState));
  }

  FutureOr<void> _accountDetailDataSet(AccountDetailDataSet event,
      Emitter<AccountsState> emit) {
    final birthdate = event.account.birthdate == null
        ? null
        : DateTime.parse(event.account.birthdate ?? '');
    nameController.text = event.account.name ?? '';
    surnameController.text = event.account.surname ?? '';
    birthDateController.text = birthdate == null
        ? ''
        : DateFormat('dd/MM/yyyy').format(birthdate);
    sallaryController.text = event.account.sallary ?? '';
    phoneController.text = event.account.phoneNumber ?? '';
    identityController.text = event.account.identity ?? '';
  }
}
