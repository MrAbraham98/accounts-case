part of 'accounts_bloc.dart';

class AccountsState extends Equatable {
  const AccountsState(
      {this.pageState = PageState.idle,
      this.accounts,
      this.page = 1,
      this.pageType = PageType.readOnly,
      this.failure});

  final PageState pageState;
  final List<Account>? accounts;
  final int page;
  final PageType pageType;
  final Failure? failure;

  @override
  List<Object?> get props => [pageState, accounts, page,pageType,failure];

  AccountsState copyWith({
    PageState? pageState,
    List<Account>? accounts,
    int? page,
    PageType? pageType,
    Failure? failure,
  }) {
    return AccountsState(
      pageState: pageState ?? this.pageState,
      accounts: accounts ?? this.accounts,
      page: page ?? this.page,
      pageType: pageType ?? this.pageType,
      failure: failure ?? this.failure,
    );
  }
}
