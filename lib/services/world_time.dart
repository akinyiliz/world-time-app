import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  // properties
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String endpoint; // location url for api endpoint
  bool isDayTime = true; // true if daytime, false if night time

  // constructor
  WorldTime(
      {required this.location, required this.flag, required this.endpoint});

  Future<void> getTime() async {
    //try catch block for error handling
    try {
      // make a request using world time api
      Uri url = Uri.parse("http://worldtimeapi.org/api/timezone/$endpoint");
      Response res = await get(url);

      // convert to object format
      Map timeData = jsonDecode(res.body);
      // print(timeData);

      // get properties from timeData
      String datetime = timeData['datetime'];
      String offset = timeData['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDayTime = now.hour > 5 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (error) {
      print("Caught error: $error");
      time = 'Could not get time data';
    }
  }
}
