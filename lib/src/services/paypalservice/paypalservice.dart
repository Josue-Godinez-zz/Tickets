import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
// import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId =
      'ASxy9rbe6k5cnNCJXQ1LYIq-U4lb1TP79KsxAu8r07vb6g__hEFzdYbQXrYeQ79qFo9KcPknDHydSqbT';
  String secret =
      'EAup_0GYOzv6LbGrjqiGSWuzppuX6BdWYyMMT_eiRCF4neqJ0sebB9oGewj4sDlbjRz-inAcIGgYXfgE';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var bytes = utf8.encode("$clientId:$secret");
      var credentials = base64.encode(bytes);
      Map body = {'grant_type': 'client_credentials'};
      var headers = {
        "Accept": "application/json",
        'Accept-Language': 'en_US',
        "Authorization": "Basic $credentials"
      };
      http.Response response = await http.post(
          Uri.https(domain, 'v1/oauth2/token'),
          body: body,
          headers: headers);
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return '';
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.https(domain, 'v1/payments/payment'),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return {};
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return '';
    } catch (e) {
      rethrow;
    }
  }
}
