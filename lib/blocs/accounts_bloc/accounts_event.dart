part of 'accounts_bloc.dart';

abstract class AccountsEvent extends Equatable {
  const AccountsEvent();


  @override
  List<Object?> get props => [];
}

class AccountsFetched extends AccountsEvent {
  const AccountsFetched(this.page);

  final int page;
}

class PageTypeChanged extends AccountsEvent {
  const PageTypeChanged(this.pageType);

  final PageType pageType;
}


class AccountUpdated extends AccountsEvent {
  const AccountUpdated(this.id);

  final String id;
}

class AccountDeleted extends AccountsEvent {
  const AccountDeleted(this.id);

  final String id;
}

class AccountCreated extends AccountsEvent {
  const AccountCreated();

}

class PageStateChanged extends AccountsEvent {
  const PageStateChanged(this.pageState);
   final PageState pageState;
}

class AccountDetailDataSet extends AccountsEvent {
  const AccountDetailDataSet(this.account);
  final Account account;
}

