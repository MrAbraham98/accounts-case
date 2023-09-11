import 'package:accounts/data/base/i_general.dart';
import 'package:accounts/data/base/i_general_service.dart';
import 'package:accounts/data/model/accounts_model.dart';

final class GeneralRepository implements IGeneral {
  GeneralRepository({
    required IGeneralService generalService,
  }) : _service = generalService;

  final IGeneralService _service;

  @override
  Future<List<Account>> getAccounts({required int page}) async {
    final result = await _service.getAccounts(
      page: page,
    );
    return result;
  }

  @override
  Future<Account> updateAccount({required String id,required Account account}) async {
    final result =await _service.updateAccount(
      id: id,
      account:account
    );
    return result;
  }

  @override
  Future<Account> deleteAccount({required String id}) async{
    final result =await _service.deleteAccount(
        id: id,
    );
    return result;
  }

  @override
  Future<Account> createAccount({required Account account})async {
    final result =await _service.createAccount(
      account: account
    );
    return result;
  }
}
