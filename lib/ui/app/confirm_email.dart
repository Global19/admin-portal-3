import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/confirm_email_vm.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ConfirmEmailVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = viewModel.state;

    return Material(
      color: Theme.of(context).cardColor,
      child: state.isLoading || state.isSaving
          ? LoadingIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon.png',
                  height: 80,
                ),
                SizedBox(height: 60),
                Text(
                  localization.confirmYourEmailAddress,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 80),
                  child: HelpText(state.user.email),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: viewModel.onResendPressed,
                      child: Text(localization.resendEmail.toUpperCase()),
                    ),
                    SizedBox(
                      width: kTableColumnGap,
                    ),
                    TextButton(
                      onPressed: () {
                        passwordCallback(
                          context: context,
                          callback: (password, idToken) {
                            fieldCallback(
                              callback: (value) {
                                viewModel.onChangeEmail(
                                    context, value, password, idToken);
                              },
                              field: localization.email,
                              context: context,
                              title: localization.changeEmail,
                            );
                          },
                        );
                      },
                      child: Text(localization.changeEmail.toUpperCase()),
                    ),
                    SizedBox(
                      width: kTableColumnGap,
                    ),
                    /*
                    if (state.user.lastEmailAddress.isNotEmpty) ...[
                      TextButton(
                        onPressed: () => viewModel.onUseLastPressed(context),
                        child: Text(localization.useLastEmail.toUpperCase()),
                      ),
                      SizedBox(
                        width: kTableColumnGap,
                      ),
                    ],
                    */
                    TextButton(
                      onPressed: viewModel.onRefreshPressed,
                      child: Text(localization.refreshData.toUpperCase()),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
