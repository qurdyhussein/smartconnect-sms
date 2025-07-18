import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  static Future<bool> initiateAfricasTalkingPayment({
    required String phone,
    required int amount,
  }) async {
    final url = Uri.parse('https://api.sandbox.africastalking.com/mobile/checkout/request');

    final headers = {
      'apiKey': 'atsk_6ccf22b28ae31c2f02047fffb43ed7b5fbf3593232e392bf9bea6a852efdd65e6f8676bd',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    final body = {
      'username': 'sandbox',
      'productName': 'MyProduct',
      'phoneNumber': phone,
      'currencyCode': 'TZS',
      'amount': amount.toString(),
      'metadata[description]': 'Test payment from SmartConnect',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print('✅ Payment initiated: $data');
        return true;
      } else {
        print('❌ Payment failed: ${response.statusCode} → ${response.body}');
        return false;
      }
    } catch (e) {
      print('❌ Exception during payment: $e');
      return false;
    }
  }
}