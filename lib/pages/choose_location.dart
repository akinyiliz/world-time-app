import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: "London", flag: "uk.png", endpoint: "Europe/London"),
    WorldTime(
        location: "Athens", flag: "greece.png", endpoint: "Europe/Athens"),
    WorldTime(
        location: "Berlin", flag: "germany.png", endpoint: "Europe/Berlin"),
    WorldTime(location: "Cairo", flag: "egypt.png", endpoint: "Africa/Cairo"),
    WorldTime(
        location: "Nairobi", flag: "kenya.png", endpoint: "Africa/Nairobi"),
    WorldTime(
        location: "Chicago", flag: "usa.png", endpoint: "America/Chicago"),
    WorldTime(
        location: "New York", flag: "usa.png", endpoint: "America/New_York"),
    WorldTime(
        location: "Seoul", flag: "south_korea.png", endpoint: "Asia/Seoul"),
    WorldTime(
        location: "Jakarta", flag: "indonesia.png", endpoint: "Asia/Jakarta"),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];

    await instance.getTime();

    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Choose a Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/${locations[index].flag}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
