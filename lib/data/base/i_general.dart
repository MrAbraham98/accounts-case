import 'package:accounts/data/model/accounts_model.dart';

abstract interface class IGeneral {
  Future<List<Account>> getAccounts({required int page});
  Future<Account> updateAccount({required String id,required Account account});
  Future<Account> deleteAccount({required String id});
  Future<Account> createAccount({required Account account});
}
