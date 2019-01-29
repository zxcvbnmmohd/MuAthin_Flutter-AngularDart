import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:muathin_common/src/configs/api_keys.dart';
import 'package:muathin_common/src/models/mosque_model.dart';

class Algolia {
  final Client _client = new Client();
  final String _algoliaWriteURL = '.algolia.net';
  final String _algoliaReadURL = '-dsn.algolia.net';

  Client get client => _client;
  String get algoliaWriteURL => _algoliaWriteURL;
  String get algoliaReadURL => _algoliaReadURL;

  static Map<String, String> headers = {
    'X-Algolia-API-Key': APIKeys.algoliaSearchAPIKey,
    'X-Algolia-Application-Id': APIKeys.algoliaAppID,
    'Content-Type': 'application/json; charset=UTF-8',
  };

//  var data = jsonEncode({
//    'query': your_query,
//  });
//
//  var request = await HttpRequest.request(
//  uri.toString(),
//  requestHeaders: headers,
//  method: 'POST',
//  sendData: data,
//  );
//
//  var json = request.responseText;
//  var hits = jsonDecode(json)['hits'] as List;

  Future<List<MosqueModel>> read(String index) async {
    List<MosqueModel> mosques = [];
    String queryURL = 'https://${APIKeys.algoliaAppID}${this.algoliaReadURL}/1/indexes/$index/query';

    await this.client
        .get(Uri.parse(queryURL))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json['mosque'])
        .then((list) => list.forEach((m) => mosques.add(MosqueModel().transform(key: '', map: m))));

    return mosques;
  }
}
