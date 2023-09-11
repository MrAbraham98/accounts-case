import 'package:accounts/blocs/accounts_bloc/accounts_bloc.dart';
import 'package:accounts/data/model/accounts_model.dart';
import 'package:accounts/utils/enum/page_type_enum.dart';
import 'package:accounts/utils/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class AccountListItem extends StatelessWidget {
  const AccountListItem({
    super.key,
    required this.data,
  });

  final Account data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          context.read<AccountsBloc>()
              .add(const PageTypeChanged(PageType.readOnly));
          context.read<AccountsBloc>()
              .add(AccountDetailDataSet(data));
          context.router.navigate(AccountDetailRoute(accountId: data.id));
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.name ?? ''} ${data.surname ?? ''}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data.phoneNumber ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
