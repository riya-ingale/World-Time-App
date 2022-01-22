import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String? time;
  String flag; //url to an asset flag icon
  String? url; // location url for api endpoint
  bool? isDayTime;

  WorldTime({required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
  try {
    //make the request
    var value = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
    Response response = await get(value);
    Map data = jsonDecode(response.body);
    print('DATA - $data');
    //get the properties

    String datetime = data['datetime'];
    String offsetHours = data['utc_offset'].substring(1, 3);
    String offsetMinutes = data['utc_offset'].substring(4, 6);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(
        hours: int.parse(offsetHours),
        minutes: int.parse(offsetMinutes)),
    );
    print("HOUR - ${now.hour}");
    // set the time property
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    print("DAYTIME - $isDayTime");
    time = DateFormat.jm().format(now);
  }
  catch(e){
    time = 'Could not get the time';
  }
  }
}

