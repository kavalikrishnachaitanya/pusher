import 'package:flutter/material.dart';
import 'package:notification/pusher_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Demo';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PusherService pusherService = PusherService();
  @override
  void initState() {
    pusherService = PusherService();
    pusherService.firePusher('public', 'create');
    super.initState();
  }

  @override
  void dispose() {
    pusherService.unbindEvent('create');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:Text("notofications"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: pusherService.eventStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Container(
              child: Text(snapshot.data),
            );
          },
        ),
      ),
    );
  }
}
