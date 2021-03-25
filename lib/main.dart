import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_final_v2/ux_ui/homepage.dart';
import 'package:project_final_v2/ux_ui/new_entry/new_entry2.dart';
import 'package:provider/provider.dart';
import 'global_bloc.dart';
import 'time_countdown.dart';

void main() async {
  final timerService = TimerService();
  WidgetsFlutterBinding.ensureInitialized();
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );

  runApp(TimerServiceProvider(
    service: timerService,
    child: MedicineReminder(),
  ));
}

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.light,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
