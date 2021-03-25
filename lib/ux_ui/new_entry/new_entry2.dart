import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:medicine_reminder/src/common/convert_time.dart';
import 'package:project_final_v2/global_bloc.dart';
import 'package:project_final_v2/model/errors.dart';
import 'package:project_final_v2/model/medicine.dart';
import 'package:project_final_v2/model/medicine_type.dart';
import 'package:project_final_v2/transform_svg/trans_svg.dart';
import 'package:project_final_v2/ux_ui/homepage.dart';
import 'package:project_final_v2/ux_ui/new_entry/new_entry_bloc.dart';
import 'package:project_final_v2/ux_ui/notification_click.dart';
import 'package:project_final_v2/ux_ui/success_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_final_v2/time_countdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../med_detail.dart';
import 'package:project_final_v2/main.dart';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';
const String dateKey = 'date';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

List gobalselectimeHour = new List(12);
List gobalselectimeMinite = new List(12);
List<DateTime> selectedMultiDay;
List<dynamic> selectedWeeklyList = new List(7);

class NewEntry2 extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

String convertTime(String minutes) {
  if (minutes.length == 1) {
    return "0" + minutes;
  } else {
    return minutes;
  }
}

void getListDate(DateTime list) {
  List getListDateTime = [];
  getListDateTime.add(list);
  print(getListDateTime);
}

class _NewEntryState extends State<NewEntry2> {
  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBloc _newEntryBloc;

  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    AndroidAlarmManager.initialize();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    final databaseReference = FirebaseDatabase.instance.reference();
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF3EB16F),
        ),
        centerTitle: true,
        title: Text(
          "Add New medicine ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              // PanelTitle(
              //   title: "Medicine Name",
              //   isRequired: true,
              // ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Medicine Name",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                maxLength: 12,
                controller: nameController,
                validator: (val) {
                  if (val.length == 0) {
                    return "Medicine cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                // maxLength: 12,
                // style: TextStyle(
                //   fontSize: 16,
                // ),
                // controller: nameController,
                // textCapitalization: TextCapitalization.words,
                // decoration: InputDecoration(
                //   border: UnderlineInputBorder(),
                // ),
              ),
              // PanelTitle(
              //   title: "Dosage in mg",
              //   isRequired: false,
              // ),
              // TextFormField(
              //   controller: dosageController,
              //   keyboardType: TextInputType.number,
              //   style: TextStyle(
              //     fontSize: 16,
              //   ),
              //   textCapitalization: TextCapitalization.words,
              //   decoration: InputDecoration(
              //     border: UnderlineInputBorder(),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Dosage in mg",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                controller: dosageController,
                validator: (val) {
                  if (val.length == 0) {
                    return "Dosage in mg cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 15,
              ),

              PanelTitle(
                title: "Medicine Type",
                isRequired: false,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MedicineTypeColumn(
                            type: MedicineType.Bottle,
                            name: "Bottle",
                            iconValue: 0xe900,
                            isSelected: snapshot.data == MedicineType.Bottle
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Pill,
                            name: "Pill",
                            iconValue: 0xe901,
                            isSelected: snapshot.data == MedicineType.Pill
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Syringe,
                            name: "Syringe",
                            iconValue: 0xe902,
                            isSelected: snapshot.data == MedicineType.Syringe
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Tablet,
                            name: "Tablet",
                            iconValue: 0xe903,
                            isSelected: snapshot.data == MedicineType.Tablet
                                ? true
                                : false),
                      ],
                    );
                  },
                ),
              ),
              PanelTitle(
                title: "Date Selection",
                isRequired: true, //true
              ),
              SizedBox(
                height: 10,
              ),
              DatSelection(),
              SizedBox(
                height: 10,
              ),
              PanelTitle(
                title: "Interval Selection",
                isRequired: true, //true
              ),
              //ScheduleCheckBoxes(),
              IntervalSelection(),

              PanelTitle(
                title: "Starting Time",
                isRequired: true,
              ),
              // SizedBox(
              //   height: 300,
              //   width: 100,
              //   child: AnimatedList(
              //     // Give the Animated list the global key
              //     key: _listKey2,
              //     initialItemCount: 3, //interval
              //     // Similar to ListView itemBuilder, but AnimatedList has
              //     // an additional animation parameter.
              //     itemBuilder: (context, index, animation) {
              //       print("index :$index");
              //       // Breaking the row widget out as a method so that we can
              //       // share it with the _removeSingleItem() method.
              //       return SelectTime(index);
              //     },
              //   ),
              // ),
              // SelectTime(1), SelectTime(2),
              SizedBox(
                height: 35,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Container(
                  width: 220,
                  height: 70,
                  child: FlatButton(
                    color: Color(0xFF3EB16F),
                    shape: StadiumBorder(),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      String medicineName;
                      int dosage;
                      //--------------------Error Checking------------------------
                      //Had to do error checking in UI
                      //Due to unoptimized BLoC value-grabbing architecture
                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.NameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        medicineName = nameController.text;
                      }
                      if (dosageController.text == "") {
                        dosage = 0;
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }
                      for (var medicine in _globalBloc.medicineList$.value) {
                        if (medicineName == medicine.medicineName) {
                          _newEntryBloc.submitError(EntryError.NameDuplicate);
                          return;
                        }
                      }
                      if (_newEntryBloc.selectedInterval$.value == 0) {
                        //error ใส่ interval 0
                        _newEntryBloc.submitError(EntryError.Interval);
                        return;
                      }
                      // if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
                      //   _newEntryBloc.submitError(EntryError.StartTime);
                      //   return;
                      // }
                      //---------------------------------------------------------
                      String medicineType = _newEntryBloc
                          .selectedMedicineType.value
                          .toString()
                          .substring(13);
                      int interval = _newEntryBloc.selectedInterval$.value;

                      int minterval = _newEntryBloc.selectedInterval$.value;

                      String startTime = _newEntryBloc.selectedTimeOfDay$.value;

                      List<int> intIDs = makeIDs(24 /
                          _newEntryBloc.selectedInterval$
                              .value); //fix id interval ถ้าไม่มี interval จะไม่มี id

                      List<String> notificationIDs = intIDs
                          .map((i) => i.toString())
                          .toList(); //for Shared preference

                      List<String> hoursSelect = makeSelectimeHours(
                          _newEntryBloc.selectedInterval$.value);

                      List<String> timeSelectHours = //get hours
                          hoursSelect.map((i) => i.toString()).toList();

                      List<String> minuteSelect = makeSelectimeMinute(
                          _newEntryBloc.selectedInterval$.value);

                      List<String> timeSelectMinute = //get Minut
                          minuteSelect.map((i) => i.toString()).toList();

                      List<dynamic> selectMutiDay = makeSelectDay();

                      List<dynamic> selectDay =
                          selectMutiDay.map((i) => i.toString()).toList();

                      List<dynamic> selectMutiWeekly = makeSelectWeekly();

                      List<dynamic> selectWeekly =
                          selectMutiWeekly.map((i) => i.toString()).toList();

                      Medicine newEntryMedicine = Medicine(
                        notificationIDs: notificationIDs,
                        medicineName: medicineName,
                        dosage: dosage,
                        medicineType: medicineType,
                        interval: interval,
                        minterval: minterval,
                        startTime: startTime,
                        timeSelectHours: timeSelectHours,
                        timeSelectMinute: timeSelectMinute,
                        selectDay: selectDay,
                        selectWeekly: selectWeekly,
                      );
                      _globalBloc.updateMedicineList(newEntryMedicine);
                      scheduleNotification(newEntryMedicine);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SuccessScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.NameNull:
            displayError("Please enter the medicine's name");
            break;
          case EntryError.NameDuplicate:
            displayError("Medicine name already exists");
            break;
          case EntryError.Dosage:
            displayError("Please enter the dosage required");
            break;
          case EntryError.Interval:
            displayError("Please select the reminder's interval ");
            break;
          case EntryError.StartTime:
            displayError("Please select the reminder's starting time");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  List<String> makeSelectimeMinute(int n) {
    // make id from interval fix here
    List<String> minute = [];
    for (int i = 0; i < n; i++) {
      minute.add(gobalselectimeMinite[i]);
    }
    return minute;
  }

  List<String> makeSelectimeHours(int n) {
    // make id from interval fix here
    List<String> hours = [];
    for (int i = 0; i < n; i++) {
      hours.add(gobalselectimeHour[i]);
    }
    return hours;
  }

  List<dynamic> makeSelectDay() {
    List<dynamic> day = [];
    if (selectedMultiDay == null) {
      day.add("null");
    } else {
      for (int i = 0; i < selectedMultiDay.length; i++) {
        day.add(selectedMultiDay[i].toString().substring(8, 11));
      }
    }
    print("Day in new entry : $day");
    return day;
  }

  List<dynamic> makeSelectWeekly() {
    List<String> weekly = [];
    for (int i = 0; i < selectedWeeklyList.length; i++) {
      if (selectedWeeklyList[i] != null) {
        weekly.add(selectedWeeklyList[i]);
      }
    }
    print("weekly : $weekly");
    return weekly;
  }

  List<int> makeIDs(double n) {
    // make id from interval fix here
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static SendPort uiSendPort;
  upDate(int i) {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('').update({
      'Day': i,
    }).then((value) => print("success"));
    return "day + $i";
  }

  int minuteval;
  static Future<void> callback2(int date) async {
    // var day = date.toString().substring();
    final databaseReference = FirebaseDatabase.instance.reference();

    var sDay;
    switch (date.toString().substring(0, 1)) {
      case '1':
        sDay = 'Monday';
        break;
      case '2':
        sDay = 'Tuesday';
        break;
      case '3':
        sDay = 'Wednesday';
        break;
      case '4':
        sDay = 'Thursday';
        break;
      case '5':
        sDay = 'Friday';
        break;
      case '6':
        sDay = 'Saturday';
        break;
      case '7':
        sDay = 'Sunday';
        break;
      default:
    }
    databaseReference.child('').update({
      'Day': sDay,
      'Time':
          date.toString().substring(1, 3) + ":" + date.toString().substring(3),
    });
    print('Alarm fired!' +
        '$date' +
        "day" +
        '${date.toString().substring(0, 1)}');
    // Get the previous cached count and increment it.

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotificationClick();
    }));
  }

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> scheduleNotification(Medicine medicine) async {
    int x;
    var hour;
    var minute;
    // var hour = int.parse(medicine.startTime[0] + medicine.startTime[1]);
    var ogValue = hour;
    // var minute = int.parse(medicine.startTime[2] + medicine.startTime[3]);
    var ogmValue = minute;
    int code_day;
    var setdate;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.max,
      //sound: 'sound',
      ledColor: Color(0xFF3EB16F),
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    if (hour == 0) {
      print(null);
    }
    for (int i = 0; i < selectedMultiDay.length; i++) {
      var day = DateFormat('E').format(selectedMultiDay[i]);
      setdate = DateFormat('yyyy-MM-dd').format(selectedMultiDay[i]);
      switch (day) {
        case "Mon":
          code_day = 1;
          break;
        case "Tue":
          code_day = 2;
          break;
        case "Wed":
          code_day = 3;
          break;
        case "Thu":
          code_day = 4;
          break;
        case "Fri":
          code_day = 5;
          break;
        case "Sat":
          code_day = 6;
          break;
        case "Sun":
          code_day = 7;
          break;
        default:
      }
      print("day : $code_day");
      for (int i = 0; i < medicine.interval.floor(); i++) {
        hour = int.parse(gobalselectimeHour[i]);
        minute = int.parse(gobalselectimeMinite[i]);
        print("gobalselectimeMinite : " + '${gobalselectimeMinite[i]}');
        var h = hour;
        var m = minute;
        String hs = gobalselectimeHour[i];
        String ms = gobalselectimeMinite[i];
        String str1 = "hello";
        String str2 = "world";
        String res = str1 + str2;
        print("The concatenated string : ${res}");
        String dates = code_day.toString() + h.toString() + m.toString();
        int d = int.parse(dates);
        print("The concatenated string : ${d}");
        // var dateint = int.tryParse(date);

        // String h = gobalselectimeHour[i];
        // String m = gobalselectimeMinite[i];

        //print(hour);
        // if ((hour + (medicine.interval * i) > 23)) {
        //   // hour = hour + (medicine.interval * i) - 24; //เกิน 24 ชม

        //   // if (minute + (medicine.minterval * i) > 59) {
        //   //   hour = hour + 1;
        //   //   if (hour > 23) {
        //   //     hour = hour + (medicine.interval * i) - 24;
        //   //   }
        //   //   minute = minute + (medicine.minterval * i) - 60;
        //   // } else {
        //   //   minute = minute + (medicine.minterval * i);
        //   // }
        //   hour = hour;
        //   minute = minute + 1;
        print("notify: $hs : $ms");
        print("notify at : $hour : $minute");
        // } else {
        //   // hour = hour + (medicine.interval * i); // ไม่เกิน 24 ขม
        //   // if (hour > 23) {
        //   //   hour = hour + (medicine.interval * i) - 24;
        //   // }
        //   // if (minute + (medicine.minterval * i) > 59) {
        //   //   hour = hour + 1;
        //   //   minute = minute + (medicine.minterval * i) - 60;
        //   // } else {
        //   //   minute = minute + (medicine.minterval * i);
        //   // }
        //   hour = hour;
        //   minute = minute + 1;
        //   print("loop2 | $hour : $minute");
        // }
        // print("hour : $hour : minute :$minute");
        // print("ogValue = $ogValue");
        // print(medicine.minterval);
        // var m = 17 + i;

        await AndroidAlarmManager.oneShotAt(
          DateTime.parse('$setdate $hour:$minute:00'),
          // Ensure we have a unique alarm ID.
          d,
          callback2,
          exact: true,
          wakeup: true,
        ).then((val) => print('set up:' + val.toString()));
        await flutterLocalNotificationsPlugin.showDailyAtTime(
          int.parse(medicine.notificationIDs[i]),
          'Mediminder: ${medicine.medicineName}',
          medicine.medicineType.toString() != MedicineType.None.toString()
              ? 'It is time to take your ${medicine.medicineType.toLowerCase()}, according to schedule'
              : 'It is time to take your medicine, according to schedule',
          Time(hour, minute, 0),
          platformChannelSpecifics,
          payload: '${int.parse(medicine.notificationIDs[i])} +success',
        );
        // Timer(Duration(minutes: 30), () {
        //   print("Yeah, this line is printed after 60 second");
        //   upDate(minute);
        // });

        print('This line is printed first');
        hour = ogValue;
        minute = ogmValue;
        // print("hour = og : $hour");
      }
    }

    //await flutterLocalNotificationsPlugin.cancelAll();
  }
}

class DatSelection extends StatefulWidget {
  @override
  _DatSelectionState createState() => _DatSelectionState();
}

class _DatSelectionState extends State<DatSelection> {
  var _visibleWeekly = false;
  var _visibleMultiday = false;
  var colorWeekly = false;
  var colorMutiday = false;
  @override
  Widget build(BuildContext context) {
    int l = 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 40,
              child: RaisedButton(
                child: new Text('Mon - Sun'),
                textColor: colorWeekly ? Colors.white : Colors.green,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: colorWeekly ? Colors.green : Colors.green[50],
                onPressed: () {
                  setState(() {
                    if (_visibleWeekly == true) {
                      _visibleWeekly = false;
                      colorWeekly = false;
                      for (int i = 0; i < selectedWeeklyList.length; i++) {
                        selectedWeeklyList[i] = null;
                      }
                      if (selectedMultiDay != null) {
                        selectedMultiDay = null;
                      }
                      monVal = false;
                      tuVal = false;
                      wedVal = false;
                      thurVal = false;
                      friVal = false;
                      satVal = false;
                      sunVal = false;
                    } else {
                      for (int i = 0; i < selectedWeeklyList.length; i++) {
                        selectedWeeklyList[i] = null;
                      }
                      if (selectedMultiDay != null) {
                        selectedMultiDay = null;
                      }
                      colorMutiday = false;
                      colorWeekly = true;
                      _visibleWeekly = true;
                      _visibleMultiday = false;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 120,
              height: 40,
              child: RaisedButton(
                child: new Text('1 - 31'),
                textColor: colorMutiday ? Colors.white : Colors.green,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: colorMutiday ? Colors.green : Colors.green[50],
                onPressed: () {
                  setState(() {
                    if (_visibleMultiday == true) {
                      colorMutiday = false;
                      _visibleMultiday = false;
                      for (int i = 0; i < selectedWeeklyList.length; i++) {
                        selectedWeeklyList[i] = null;
                      }
                    } else {
                      colorMutiday = true;
                      colorWeekly = false;
                      _visibleMultiday = true;
                      _visibleWeekly = false;
                      for (int i = 0; i < selectedWeeklyList.length; i++) {
                        selectedWeeklyList[i] = null;
                      }

                      monVal = false;
                      tuVal = false;
                      wedVal = false;
                      thurVal = false;
                      friVal = false;
                      satVal = false;
                      sunVal = false;
                    }
                  });
                },
              ),
            ),
          ],
        ),
        // RaisedButton(
        //     child: Text('Select the date'),
        //     onPressed: () {
        //       containerForSheet<String>(
        //         context: context,
        //         child: CupertinoActionSheet(
        //             title: const Text('Select the date 😊'),
        //             message: const Text('Your date are '),
        //             actions: <Widget>[
        //               CupertinoActionSheetAction(
        //                 child: const Text('Select Muti Day'),
        //                 onPressed: () {
        //                   Navigator.pop(context, '🙋 Every Day');
        //                   setState(() {
        //                     if (_visibleMultiday == true) {
        //                       _visibleMultiday = false;
        //                     } else {
        //                       _visibleMultiday = true;
        //                       _visibleWeekly = false;
        //                       for (int i = 0;
        //                           i < selectedWeeklyList.length;
        //                           i++) {
        //                         selectedWeeklyList[i] = null;
        //                       }
        //                       monVal = false;
        //                       tuVal = false;
        //                       wedVal = false;
        //                       thurVal = false;
        //                       friVal = false;
        //                       satVal = false;
        //                       sunVal = false;
        //                     }
        //                   });
        //                 },
        //               ),
        //               CupertinoActionSheetAction(
        //                 child: const Text('Specific Days'),
        //                 onPressed: () {
        //                   Navigator.pop(context, '🙋 Specific Days');
        //                   l = l + 1;
        //                   // _insertSingleItemInterval(l);
        //                   checkbox("Mon", monVal);
        //                   setState(() {
        //                     if (_visibleWeekly == true) {
        //                       _visibleWeekly = false;
        //                       for (int i = 0;
        //                           i < selectedWeeklyList.length;
        //                           i++) {
        //                         selectedWeeklyList[i] = null;
        //                       }
        //                       monVal = false;
        //                       tuVal = false;
        //                       wedVal = false;
        //                       thurVal = false;
        //                       friVal = false;
        //                       satVal = false;
        //                       sunVal = false;
        //                     } else {
        //                       _visibleWeekly = true;
        //                       _visibleMultiday = false;
        //                     }
        //                   });
        //                 },
        //               ),
        //             ],
        //             cancelButton: CupertinoActionSheetAction(
        //               child: const Text('Cancel'),
        //               isDefaultAction: true,
        //               onPressed: () {
        //                 Navigator.pop(context, 'Cancel');
        //               },
        //             )),
        //       );
        //     }),
        SizedBox(
          height: 11,
        ),
        Visibility(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    checkbox("Mon", monVal),
                    checkbox("Tue", tuVal),
                    checkbox("Wed", wedVal),
                    checkbox("Thu", thurVal),
                    checkbox("Fri", friVal),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    checkbox("Sat", satVal),
                    checkbox("Sun", sunVal),
                  ],
                ),
              ],
            ),
          ),
          visible: _visibleWeekly,
        ),
        Visibility(
          visible: _visibleMultiday,
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.multiple,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                selectedMultiDay = args.value;
                print("selectday : $selectedMultiDay");
              });
            },
          ),
        )
      ],
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('You clicked $value'),
        duration: Duration(milliseconds: 800),
      ));
    });
  }

  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

  Widget checkbox(String title, bool boolValue) {
    print("weekly :$selectedWeeklyList");
    print("selectday : $selectedMultiDay");
    // print("selectdaylength : ${selectedMultiDay.length}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value

            setState(() {
              switch (title) {
                case "Mon":
                  monVal = value;
                  if (monVal == true) {
                    selectedWeeklyList[1] = title;
                  } else {
                    selectedWeeklyList[1] = null;
                  }
                  break;
                case "Tue":
                  tuVal = value;
                  if (tuVal == true) {
                    selectedWeeklyList[2] = title;
                  } else {
                    selectedWeeklyList[2] = null;
                  }
                  break;
                case "Wed":
                  wedVal = value;
                  if (wedVal == true) {
                    selectedWeeklyList[3] = title;
                  } else {
                    selectedWeeklyList[3] = null;
                  }
                  break;
                case "Thu":
                  thurVal = value;
                  if (thurVal == true) {
                    selectedWeeklyList[4] = title;
                  } else {
                    selectedWeeklyList[4] = null;
                  }
                  break;
                case "Fri":
                  friVal = value;
                  if (friVal == true) {
                    selectedWeeklyList[5] = title;
                  } else {
                    selectedWeeklyList[5] = null;
                  }
                  break;
                case "Sat":
                  satVal = value;
                  if (satVal == true) {
                    selectedWeeklyList[6] = title;
                  } else {
                    selectedWeeklyList[6] = null;
                  }
                  break;
                case "Sun":
                  sunVal = value;
                  if (sunVal == true) {
                    selectedWeeklyList[0] = title;
                  } else {
                    selectedWeeklyList[0] = null;
                  }
                  break;
              }
            });
          },
        )
      ],
    );
  }
}

class IntervalSelection extends StatefulWidget {
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final GlobalKey<AnimatedListState> _listKey2 = GlobalKey();
  DateTime _timeselected;
  Future onTimeChanged(DateTime newTime) async {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);

    setState(() {
      //ตั้งเวลา

      // _newEntryBloc.updateTime("${convertTime(newTime.hour.toString())}" +
      //     "${convertTime(newTime.minute.toString())}");
    });
  }

  // var _intervals = [
  //   0,
  //   5,
  //   6,
  //   8,
  //   12,
  // ];
  // var _mintervals = [
  //   0,
  // ];
  var _selected = 0;
  var _mselected = 0;
  NumberPicker integerNumberPickerHour;
  NumberPicker integerNumberPickerMinute;
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;
  List numListTimeSc = [];
  int countSelect = 0;
  int _changedNumber = 0, _selectedNumber = 0;
  int widgetlong = 10;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CupertinoButton(
                  child: Text(
                    "Select Number :",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200.0,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CupertinoButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Expanded(
                                  child: CupertinoPicker(
                                      scrollController:
                                          new FixedExtentScrollController(
                                        initialItem: _selected,
                                      ),
                                      itemExtent: 32.0,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (int index) {
                                        _changedNumber = index;
                                      },
                                      children: new List<Widget>.generate(10,
                                          (int index) {
                                        return new Center(
                                          child: new Text('${index}'),
                                        );
                                      })),
                                ),
                                CupertinoButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    setState(() {
                                      print(
                                          "item : $_timeselected  ||| List : $gobalselectimeHour : $gobalselectimeMinite");
                                      _selected = _changedNumber;
                                      _newEntryBloc
                                          .updateInterval(_changedNumber);
                                      int interval = 0;
                                      print("_selectedNumber :$_selected");
                                      if (numListTimeSc.length != 0) {
                                        for (int i = numListTimeSc.length;
                                            i > 0;
                                            i--) {
                                          _removeSingleItemInterval();
                                          _selected = _changedNumber;
                                        }
                                        for (int i = _selected; i > 0; i--) {
                                          interval++;
                                          _insertSingleItemInterval(interval);
                                        }
                                      } else {
                                        for (int i = _selected; i > 0; i--) {
                                          interval++;
                                          _insertSingleItemInterval(interval);
                                        }
                                      }
                                      widgetlong = 10;
                                      widgetlong = widgetlong +
                                          numListTimeSc.length * 53;
                                    });

                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  }),
              Text(
                '${_selected}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
          SizedBox(
            height: widgetlong.toDouble(),
            width: 300,
            child: AnimatedList(
              // Give the Animated list the global key
              key: _listKey2,
              initialItemCount: numListTimeSc.length,
              // Similar to ListView itemBuilder, but AnimatedList has
              // an additional animation parameter.
              itemBuilder: (context, index, animation) {
                // Breaking the row widget out as a method so that we can
                // share it with the _removeSingleItem() method.
                return _buildItem3(numListTimeSc[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Duration initialtimer = new Duration();
  bool click = false;

  Widget _buildItem3(String item, Animation animation) {
    print("item builditem3 :$item");
    return Padding(
        padding: EdgeInsets.all(3.0),
        child: FloatingActionButton.extended(
          heroTag: item,
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.green)),

          icon: const Icon(
            Icons.timer,
            color: Colors.green,
          ),
          label: Text(
            click == false || gobalselectimeHour[int.parse('$item') - 1] == null
                ? " เลือกเวลา $item"
                : " ${gobalselectimeHour[int.parse('$item') - 1]} : " +
                    " ${gobalselectimeMinite[int.parse('$item') - 1]}",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            click = true;
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200.0,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CupertinoButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            minuteInterval: 1,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newdate) {
                              setState(() {
                                _timeselected = newdate;
                                print("${_timeselected.hour}");
                                print("${_timeselected.minute}");
                              });
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: Text("Ok"),
                          onPressed: () {
                            setState(() {
                              int i = int.parse('$item');
                              gobalselectimeHour[i - 1] =
                                  " ${convertTime(_timeselected.hour.toString())} ";

                              gobalselectimeMinite[i - 1] =
                                  "${convertTime(_timeselected.minute.toString())}  ";
                              print(
                                  "item : $item  ||| List : $gobalselectimeHour : $gobalselectimeMinite");
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                });
            // Navigator.of(context).push(
            //   showPicker(
            //     context: context,
            //     value: _time,
            //     onChange: onTimeChanged,
            //     minuteInterval: MinuteInterval.ONE,
            //     disableHour: false,
            //     disableMinute: false,
            //     minMinute: 0,
            //     maxMinute: 59,
            //     // Optional onChange to receive value as DateTime
            //     onChangeDateTime: (DateTime dateTime) {
            //       int i = int.parse('$item');
            //       gobalselectimeHour[i - 1] =
            //           " ${convertTime(_time.hour.toString())} ";

            //       gobalselectimeMinite[i - 1] =
            //           "${convertTime(_time.minute.toString())}  ";
            //       print(
            //           "item : $item  ||| List : $gobalselectimeHour : $gobalselectimeMinite");
            //     },
            //   ),
            // );
          },
          // child: Text(
          //   click == false
          //       ? " เลือกเวลา"
          //       : " ${convertTime(_time.hour.toString())}  : " +
          //           "${convertTime(_time.minute.toString())}  ",
          //   style: TextStyle(color: Colors.white),
          // ),
        ));
  }

  void _removeSingleItemInterval() {
    int removeIndex = 0;

    // Remove item from data list but keep copy to give to the animation.
    String removedItem = numListTimeSc.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem3(removedItem, animation);
    };
    // Remove the item visually from the AnimatedList.
    _listKey2.currentState.removeItem(removeIndex, builder);
    print("deledtinter : $numListTimeSc");
  }

  void _insertSingleItemInterval(interval) {
    String newItem = "$interval";

    // Arbitrary location for demonstration purposes
    int insertIndex = 0;
    // Add the item to the data list.
    // _interval.insert(insertIndex, newItem);
    numListTimeSc.add(newItem);
    // Add the item visually to the AnimatedList.
    _listKey2.currentState.insertItem(insertIndex);
    print("add : $numListTimeSc");
  }
}

class SelectTime extends StatefulWidget {
  // Medicine medicine;
  int intervals;
  SelectTime(this.intervals);
  @override
  _SelectTimeState createState() => _SelectTimeState(intervals);
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool _clicked = false;
  // Medicine medicine;
  int intervals;

  _SelectTimeState(this.intervals);

  Future onTimeChanged(TimeOfDay newTime) async {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);

    setState(() {
      _time = newTime;
      _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
          "${convertTime(_time.minute.toString())}");
    });
  }

  bool click = false;

  @override
  Widget build(BuildContext context) {
    var time = widget.intervals;
    return FloatingActionButton.extended(
      heroTag: "$time",
      elevation: 4.0,
      icon: const Icon(Icons.timer),
      label: Text(
        click == false
            ? " เลือกเวลา"
            : " ${convertTime(_time.hour.toString())}  : " +
                "${convertTime(_time.minute.toString())}  ",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        click = true;
        Navigator.of(context).push(
          showPicker(
            context: context,
            value: _time,
            onChange: onTimeChanged,
            minuteInterval: MinuteInterval.ONE,
            disableHour: false,
            disableMinute: false,
            minMinute: 0,
            maxMinute: 59,
            // Optional onChange to receive value as DateTime
            onChangeDateTime: (DateTime dateTime) {
              print(dateTime);
            },
          ),
        );
      },
      // child: Text(
      //   click == false
      //       ? " เลือกเวลา"
      //       : " ${convertTime(_time.hour.toString())}  : " +
      //           "${convertTime(_time.minute.toString())}  ",
      //   style: TextStyle(color: Colors.white),
      // ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  MedicineTypeColumn(
      {Key key,
      @required this.type,
      @required this.name,
      @required this.iconValue,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedMedicine(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Color(0xFF3EB16F) : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 75,
                  color: isSelected ? Colors.white : Color(0xFF3EB16F),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF3EB16F) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Color(0xFF3EB16F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
          ),
        ]),
      ),
    );
  }
}
