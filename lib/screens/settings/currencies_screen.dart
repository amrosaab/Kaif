import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/tools/flash.dart';
import '../../generated/l10n.dart';
import '../../models/app_model.dart';
import '../../models/entities/currency.dart';
import '../../services/services.dart';
import '../base_screen.dart';
import '../common/app_bar_mixin.dart';

class CurrenciesScreen extends StatefulWidget {
  @override
  BaseScreen<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends BaseScreen<CurrenciesScreen>
    with AppBarMixin {
  final ValueNotifier<List<Currency>?> _availableCurrenciesNotifier =
      ValueNotifier<List<Currency>?>(null);
  String? currencyDisplay;

  @override
  void afterFirstLayout(BuildContext context) {
    currencyDisplay = Provider.of<AppModel>(context, listen: false).currency;
    getCurrency();
    setState(() {});
  }

  Future<void> getCurrency() async {
    final currencies = await Services().api.getAvailableCurrencies();
    _availableCurrenciesNotifier.value = currencies;
  }

  @override
  void dispose() {
    _availableCurrenciesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return renderScaffold(
      routeName: RouteList.currencies,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: showAppBar(RouteList.currencies) ? EdgeInsets.zero : null,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).currencies,
              style:  TextStyle(color: Colors.white,fontFamily: GoogleFonts.cairo().fontFamily),
            ),
            backgroundColor: Theme.of(context).brightness == Brightness.dark? const Color(0xff282D39):Colors.grey[700],
            leading: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: buildListCurrency(),
        ),
      ),
    );
  }

  Widget buildListCurrency() {
    final currencies = kAdvanceConfig.currencies;
    return ValueListenableBuilder(
      valueListenable: _availableCurrenciesNotifier,
      builder: (_, availableCurrencies, __) {
        if (availableCurrencies == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final supportedCurrencies = availableCurrencies.isEmpty
            ? currencies
            : currencies.where((element) => availableCurrencies
                .any((e) => e.countryCode == element.countryCode));

        // final unsupportedCurrencies = currencies
        //     .where((element) => !supportedCurrencies.contains(element));

        // final allCurrencies = [
        //   ...supportedCurrencies,
        //   ...unsupportedCurrencies
        // ];
        return ListView.separated(
          itemCount: currencies.length,
          separatorBuilder: (_, __) => const Divider(
            color: Colors.black12,
            height: 1.0,
            indent: 75,
          ),
          itemBuilder: (_, index) {
            final currency = currencies[index];
            return buildItem(
              currency,
              isEnable: supportedCurrencies.contains(currency),
            );
          },
        );
      },
    );
  }

  Widget buildItem(Currency currency, {bool isEnable = true}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        enabled: isEnable,
        title: Text('${currency.currencyDisplay} (${currency.symbol})'),
        onTap: () {
          setState(() {
            currencyDisplay = currency.currencyDisplay;
          });

          Provider.of<AppModel>(context, listen: false)
              .changeCurrency(context, currency);

          FlashHelper.message(
            context,
            message: S.of(context).changedCurrencyTo(
                  currency.currencyDisplay,
                ),
          );
          context.navigator.pop();
        },
        trailing: currencyDisplay == currency.currencyDisplay
            ? const Icon(Icons.done)
            : Container(
                width: 20,
              ),
      ),
    );
  }
}
