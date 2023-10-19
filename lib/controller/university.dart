import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/university.dart';

Future<List<UniversityModel>> getUniversities() async {

  List<UniversityModel> universities = [];

  String apiLink = "universities.hipolabs.com";

  var uri = Uri.http(apiLink, "/search",{'country':'Philippines'});
  final http.Response response =
  await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );


  final data = jsonDecode(response.body);
  final responseCode = response.statusCode;

  if (kDebugMode) {
    print(data);
    print(responseCode );
  }

  if(responseCode==200)
  {
    List list =  data;
    for(int x=0; x < list.length;x++){
      universities.add(
          UniversityModel(
          name: list[x]['name'].toString(),
          province: list[x]['state-province'].toString(),
          domain: list[x]['domains'][0].toString(),)
      );
    }
  }
  else if (responseCode == 400)
  {
    //NOTHING
  }


  return universities;
}