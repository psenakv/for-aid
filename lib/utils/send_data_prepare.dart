/*

Send it like

{
  "id": 1,
  "timestamp": 1563640432,
  "first_name": "John",
  "last_name": "Doe",
  "location": {
    "latitude": 40.446878992182626,
    "longitude": -3.6945078746128055
  }
}

*/
import 'dart:convert';

import 'package:http/http.dart' as http;

class AddScan {
  int id;
  String first_name;
  String last_name;

  double longitude;
  double latitude;

  Map<String, double> location;

  AddScan({
      this.id,
      this.first_name,
      this.last_name,
      this.longitude,
      this.latitude,
  }) : this.location = {"longitude" : longitude, "latitude" : latitude};

  sendRequest() async {
    String targetUrl = "192.168.1.138:8000"; //TODO add url
    String json;

    if(this.id == null) {
      throw new Exception("Chybí ID");
    }
    if(this.longitude == null || this.latitude == null) {
      throw new Exception("Chybí poloha");
    }



    Map prepareJson;

    prepareJson = {
      'id' : this.id,
      'first_name' : this.first_name,
      'last_name' : this.last_name,
      'location' : this.location,
    };


    json = jsonEncode(prepareJson);
    print(json);

    http.post(targetUrl,
        headers: {"Content-Type": "application/json"},
        body: json
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response);
      print(response.headers);
      print(response.request);

    });




  }
  
  Future<List<AddScan>> getPeople() async {
    List people = [];
    //TODO get list of people from external source
    people.add(new AddScan(id: 1, first_name: "John", last_name: "Doe", latitude: 40.446882, longitude: -3.694507));
    people.add(new AddScan(id: 2, first_name: "Jack", last_name: "Black", latitude: 40.452575, longitude: -3.694890));
    return people;
  }

  
}