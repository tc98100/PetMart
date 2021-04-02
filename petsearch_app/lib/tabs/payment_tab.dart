import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/tabs/home_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

import '../theme.dart';
import '../utils.dart';

class PaymentForm extends StatefulWidget {
  final Product product;

  const PaymentForm(this.product);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final GlobalKey formKey = GlobalKey<FormState>();

  //todo paymnents
  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-Zpfua2_rcYish8744_mxiQ');
    InAppPayments.startCardEntryFlow(
        onCardEntryCancel: _onCardEntryCancel,
        onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
        collectPostalCode: false);

    //set popup theme to ios
    var themeConfiguationBuilder = IOSThemeBuilder();
    themeConfiguationBuilder.saveButtonTitle = 'Pay';
    themeConfiguationBuilder.errorColor = RGBAColorBuilder()
      ..r = 255
      ..g = 0
      ..b = 0;
    themeConfiguationBuilder.tintColor = RGBAColorBuilder()
      ..r = 255
      ..g = 82
      ..b = 82;
    themeConfiguationBuilder.keyboardAppearance = KeyboardAppearance.dark;
    themeConfiguationBuilder.messageColor = RGBAColorBuilder()
      ..r = 114
      ..g = 114
      ..b = 114;
    themeConfiguationBuilder.textColor = RGBAColorBuilder()
      ..r = 18
      ..g = 18
      ..b = 18;

    await InAppPayments.setIOSCardEntryTheme(themeConfiguationBuilder.build());
  }

  void _onCardEntryCancel() {
    // Cancel
  }

  void _onCardNonceRequestSuccess(CardDetails result) {
    // Use this nonce from your backend to pay via Square API
    print(result.nonce);
    try {
      // take payment with the card nonce details
      // you can take a charge
      // await chargeCard(result);

      // payment finished successfully
      // you must call this method to close card entry
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
    } on Exception catch (ex) {
      // payment failed to complete due to error
      // notify card entry to show processing error
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  void _onCardEntryComplete() {
    // show success message like receipt and clear the shopping cart, etc
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => PaymentConfirmation()));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: appTheme.scaffoldBackgroundColor,
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: appTheme.primaryColor,
          ),
          backgroundColor: appTheme.scaffoldBackgroundColor,
          middle: Text("Checkout", style: gradientText(20)),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(widget.product.fbsPath),
                        ),
                        Text(
                          widget.product.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.money_dollar,
                              color: appTheme2.accentColor,
                              size: 20,
                            ),
                            Text('${widget.product.price.toStringAsFixed(2)}'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey[600]),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: title(15),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item price'),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.money_dollar,
                              color: appTheme2.accentColor,
                              size: 20,
                            ),
                            Text('${widget.product.price.toStringAsFixed(2)}'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping price'),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.money_dollar,
                              color: appTheme2.accentColor,
                              size: 20,
                            ),
                            Text('${0.00.toStringAsFixed(2)}'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total cost'),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.money_dollar,
                              color: appTheme2.accentColor,
                              size: 20,
                            ),
                            Text(
                              '${widget.product.price.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey[600]),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Shipping address',
                          style: title(15),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Enter address'),
                            Icon(
                              CupertinoIcons.chevron_forward,
                              color: appTheme2.accentColor,
                            ),
                          ]),
                    ),
                    SizedBox(height: 25),
                    Divider(color: Colors.grey[600]),
                    SizedBox(height: 10),
                    CustomButton(
                        onPressed: () {
                          _initSquarePayment();
//                          Navigator.of(context).push(CupertinoPageRoute(
//                              builder: (context) => PaymentConfirmation()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
//                            SizedBox(
//                                width: 100,
//                                child:
//                                Image.network(
//                                    'https://images.squarespace-cdn.com/content/v1/56180042e4b09f2fdf36021d/1485365050319-S6ARLQ9XF6DS8HL6YIYN/ke17ZwdGBToddI8pDm48kPlxFfObHupcGpxKsWsJh1RZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZamWLI2zvYWH8K3-s_4yszcp2ryTI0HqTOaaUohrI8PIgz526D_ZbtJElJG6_mKInzVvOcEHY4xdphXhqtHw4vs/PayPal.png')),
//                            SizedBox(width: 10),
                            Text(
                              'Secure Checkout',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(FontAwesomeIcons.lock,
                                color: Colors.white, size: 15)
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class PaymentConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank you for your purchase!',
                style: gradientText(20),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(builder: (context) => HomeTab()));
                  },
                  child: Text(
                    'Keep browsing',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
