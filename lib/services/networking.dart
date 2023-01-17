// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import "package:http/http.dart" as http ;

const Map<String, String> _headers = {
  'X-RapidAPI-Key': '4a21909023mshdde8260e14d7c85p13bd1ejsna6e18650afdb',
  'X-RapidAPI-Host': 'tasty.p.rapidapi.com',

};
class NetworkHelper{
  NetworkHelper(this.url);
  final String url;

  Future getData() async{
    http.Response response = await http.get(Uri.parse(url), headers: _headers);
    if(response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }else{
      return response.statusCode;
    }
  }
}