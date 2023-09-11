import 'package:accounts/blocs/app_cubit/app_cubit.dart';
import 'package:accounts/utils/extension/context_extension.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    return IconButton(
        onPressed: () => BottomPicker(
              items: [
                // ignore: require_trailing_commas
                Text(
                  context.l10n.english,
                  style:textStyle
                ),
                Text(
                  context.l10n.turkish,
                  style: textStyle
                )
              ],
              dismissable: true,
              onSubmit: (index) =>
                  context.read<AppCubit>().changeLocale(index as int),
              title: 'Language',
              titleStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).show(context),
        icon: const Icon(Icons.language));
  }
}
