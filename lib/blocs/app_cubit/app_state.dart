part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.locale = L10n.en,
  });

  final Locale locale;

  @override
  List<Object?> get props => [locale];

  AppState copyWith({
    Locale? locale,
  }) {
    return AppState(
      locale: locale ?? this.locale,
    );
  }
}
