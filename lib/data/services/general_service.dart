import 'package:accounts/data/base/i_general_service.dart';
import 'package:accounts/data/failure/failure.dart';
import 'package:accounts/data/failure/failure_exception_handler.dart';
import 'package:accounts/data/model/accounts_model.dart';
import 'package:accounts/utils/client/cookie_client.dart';
import 'package:accounts/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';


final class GeneralService implements IGeneralService {
  GeneralService({required CookieClient client}) : _client = client;

  final CookieClient _client;

  @override
  Future<List<Account>> getAccounts({required int page}) async {
    try {
          final response =
              await _client.get<Account, List<Account>>(
            '${ApiConstants.accounts}?page=$page&limit=15',
            responseModel: Account(),
          );
          return response;
        } on DioException catch (dioError) {
          throw FailureExceptionHandler.fromDioError(dioError).error;
        }
  }

  @override
  Future<Account> updateAccount({required String id,required Account account}) async{
    try {
      final response =
          await _client.put<Account, Account>(
        '${ApiConstants.accounts}/$id',
            data: account.toJson(),
            responseModel: Account()
      );
     return response;
    } on DioException catch (dioError) {
      throw FailureExceptionHandler.fromDioError(dioError).error;
    }
  }

  @override
  Future<Account> deleteAccount({required String id}) async{
    try {
      final response =
          await _client.delete<Account, Account>(
          '${ApiConstants.accounts}/$id',
          responseModel: Account()
      );
      return response;
    } on DioException catch (dioError) {
      throw FailureExceptionHandler.fromDioError(dioError).error;
    }
  }

  @override
  Future<Account> createAccount({required Account account}) async{
    try {
      final response =
      await _client.post<Account, Account>(
          ApiConstants.accounts,
          data: account.toJson(),
          responseModel: Account()
      );
      return response;
    } on DioException catch (dioError) {
      throw FailureExceptionHandler.fromDioError(dioError).error;
    }
  }

}
