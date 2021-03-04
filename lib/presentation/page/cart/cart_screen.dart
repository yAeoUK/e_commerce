import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/cart/Cart.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            //"Your Cart",
            AppLocalizations.of(context).yourCart,
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            '${demoCarts.length} '+AppLocalizations.of(context).items,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
