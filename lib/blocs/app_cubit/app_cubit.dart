import 'package:accounts/utils/localization/l10n/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    final languageCode = json['language_code'] as String?;

    return AppState(
      locale: Locale(languageCode ?? L10n.en.languageCode)
    );
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      'language_code': state.locale.languageCode,
    };
  }

  void changeLocale(int selected) {
    var locale = L10n.en;
    switch(selected){
      case 0:
        locale= L10n.en;
      case 1:
        locale = L10n.tr;

    }

    emit(
      state.copyWith(
        locale: locale,
      ),
    );
  }


}
