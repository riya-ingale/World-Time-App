import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? time = 'LOADING.....';
  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'berlin.png', url: 'Europe/Berlin');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time':instance.time,
      'flag':instance.flag,
      'isDaytime': instance.isDayTime
    });
    print("IS DAYTIME - ${instance.isDayTime}");
  }


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          )
      )
    );
  }

}
