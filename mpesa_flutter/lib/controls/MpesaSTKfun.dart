import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

Future<void> startCheckout({
  required String userPhone,
  required double amount,
  // required String tillNumber
}) async {
  //Preferably expect 'dynamic', response type varies a lot!
  dynamic transactionInitialisation;
  //Better wrap in a try-catch for lots of reasons.
  try {
    //Run it
    transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        // using this as a sunbox
        businessShortCode: "174379",
        // businessShortCode: tillNumber,
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: userPhone,
        partyB: "174379",
        // uncomment this section if you want to parse in your own till number to the function
        // partyB: tillNumber,
        callBackURL:
            Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: "Nyayo Kitchen",
        phoneNumber: '254$userPhone',
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

    print("TRANSACTION RESULT: $transactionInitialisation");

    //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

    /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
    return transactionInitialisation;
  } catch (e) {
    //For now, console might be useful
    print("CAUGHT EXCEPTION: $e");

    /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
  }
}
