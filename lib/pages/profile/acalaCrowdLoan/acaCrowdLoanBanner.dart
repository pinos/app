import 'package:app/common/consts.dart';
import 'package:app/pages/profile/acalaCrowdLoan/acaCrowdLoanPage.dart';
import 'package:app/pages/profile/crowdLoan/crowdLoanPage.dart';
import 'package:app/service/index.dart';
import 'package:app/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polkawallet_sdk/utils/i18n.dart';

class ACACrowdLoanBanner extends StatelessWidget {
  ACACrowdLoanBanner(this.service, this.switchNetwork);
  final AppService service;
  final Future<void> Function(String) switchNetwork;

  Future<void> _goToCrowdLoan(BuildContext context) async {
    if (service.plugin.basic.name != relay_chain_name_dot) {
      final dic = I18n.of(context).getDic(i18n_full_dic_app, 'public');
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('${dic['auction.switch']} $relay_chain_name_dot ...'),
            content: Container(height: 64, child: CupertinoActivityIndicator()),
          );
        },
      );
      await switchNetwork(relay_chain_name_dot);
      Navigator.of(context).pop();
    }

    Navigator.of(context).pushNamed(CrowdLoanPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          child: Container(
            child: Image.asset('assets/images/public/banner_aca_plo.png'),
          ),
          onTap: () => _goToCrowdLoan(context),
        ),
      ],
    );
  }
}
