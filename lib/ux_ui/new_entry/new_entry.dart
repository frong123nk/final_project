// import 'dart:math';
// import 'package:flutter/material.dart';
// //import 'package:medicine_reminder/src/common/convert_time.dart';
// import 'package:project_final_v2/global_bloc.dart';
// import 'package:project_final_v2/model/errors.dart';
// import 'package:project_final_v2/model/medicine.dart';
// import 'package:project_final_v2/model/medicine_type.dart';
// import 'package:project_final_v2/ux_ui/homepage.dart';
// import 'package:project_final_v2/ux_ui/new_entry/new_entry_bloc.dart';
// import 'package:project_final_v2/ux_ui/success_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:day_night_time_picker/day_night_time_picker.dart';
// import 'package:day_night_time_picker/lib/constants.dart';

// import '../notification_click.dart';

// class NewEntry extends StatefulWidget {
//   @override
//   _NewEntryState createState() => _NewEntryState();
// }

// String convertTime(String minutes) {
//   if (minutes.length == 1) {
//     return "0" + minutes;
//   } else {
//     return minutes;
//   }
// }

// class _NewEntryState extends State<NewEntry> {
//   TextEditingController nameController;
//   TextEditingController dosageController;
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   NewEntryBloc _newEntryBloc;

//   GlobalKey<ScaffoldState> _scaffoldKey;

//   void dispose() {
//     super.dispose();
//     nameController.dispose();
//     dosageController.dispose();
//     _newEntryBloc.dispose();
//   }

//   void initState() {
//     super.initState();
//     _newEntryBloc = NewEntryBloc();
//     nameController = TextEditingController();
//     dosageController = TextEditingController();
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _scaffoldKey = GlobalKey<ScaffoldState>();
//     initializeNotifications();
//     initializeErrorListen();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

//     return Scaffold(
//       key: _scaffoldKey,
//       resizeToAvoidBottomPadding: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(
//           color: Color(0xFF3EB16F),
//         ),
//         centerTitle: true,
//         title: Text(
//           "Add New medicine",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//           ),
//         ),
//         elevation: 0.0,
//       ),
//       body: Container(
//         child: Provider<NewEntryBloc>.value(
//           value: _newEntryBloc,
//           child: ListView(
//             padding: EdgeInsets.symmetric(
//               horizontal: 25,
//             ),
//             children: <Widget>[
//               // PanelTitle(
//               //   title: "Medicine Name",
//               //   isRequired: true,
//               // ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 decoration: new InputDecoration(
//                   labelText: "Medicine Name",
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(25.0),
//                     borderSide: new BorderSide(),
//                   ),
//                   //fillColor: Colors.green
//                 ),
//                 maxLength: 12,
//                 controller: nameController,
//                 validator: (val) {
//                   if (val.length == 0) {
//                     return "Medicine cannot be empty";
//                   } else {
//                     return null;
//                   }
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 style: new TextStyle(
//                   fontFamily: "Poppins",
//                 ),
//                 // maxLength: 12,
//                 // style: TextStyle(
//                 //   fontSize: 16,
//                 // ),
//                 // controller: nameController,
//                 // textCapitalization: TextCapitalization.words,
//                 // decoration: InputDecoration(
//                 //   border: UnderlineInputBorder(),
//                 // ),
//               ),
//               // PanelTitle(
//               //   title: "Dosage in mg",
//               //   isRequired: false,
//               // ),
//               // TextFormField(
//               //   controller: dosageController,
//               //   keyboardType: TextInputType.number,
//               //   style: TextStyle(
//               //     fontSize: 16,
//               //   ),
//               //   textCapitalization: TextCapitalization.words,
//               //   decoration: InputDecoration(
//               //     border: UnderlineInputBorder(),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 decoration: new InputDecoration(
//                   labelText: "Dosage in mg",
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(25.0),
//                     borderSide: new BorderSide(),
//                   ),
//                   //fillColor: Colors.green
//                 ),
//                 controller: dosageController,
//                 validator: (val) {
//                   if (val.length == 0) {
//                     return "Dosage in mg cannot be empty";
//                   } else {
//                     return null;
//                   }
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 style: new TextStyle(
//                   fontFamily: "Poppins",
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),

//               PanelTitle(
//                 title: "Medicine Type",
//                 isRequired: false,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.0),
//                 child: StreamBuilder<MedicineType>(
//                   stream: _newEntryBloc.selectedMedicineType,
//                   builder: (context, snapshot) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         MedicineTypeColumn(
//                             type: MedicineType.Bottle,
//                             name: "Bottle",
//                             iconValue: 0xe900,
//                             isSelected: snapshot.data == MedicineType.Bottle
//                                 ? true
//                                 : false),
//                         MedicineTypeColumn(
//                             type: MedicineType.Pill,
//                             name: "Pill",
//                             iconValue: 0xe901,
//                             isSelected: snapshot.data == MedicineType.Pill
//                                 ? true
//                                 : false),
//                         MedicineTypeColumn(
//                             type: MedicineType.Syringe,
//                             name: "Syringe",
//                             iconValue: 0xe902,
//                             isSelected: snapshot.data == MedicineType.Syringe
//                                 ? true
//                                 : false),
//                         MedicineTypeColumn(
//                             type: MedicineType.Tablet,
//                             name: "Tablet",
//                             iconValue: 0xe903,
//                             isSelected: snapshot.data == MedicineType.Tablet
//                                 ? true
//                                 : false),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               PanelTitle(
//                 title: "Interval Selection",
//                 isRequired: true, //true
//               ),
//               //ScheduleCheckBoxes(),
//               IntervalSelection(),
//               PanelTitle(
//                 title: "Starting Time",
//                 isRequired: true,
//               ),
//               SelectTime(),
//               SizedBox(
//                 height: 35,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: MediaQuery.of(context).size.height * 0.08,
//                   right: MediaQuery.of(context).size.height * 0.08,
//                 ),
//                 child: Container(
//                   width: 220,
//                   height: 70,
//                   child: FlatButton(
//                     color: Color(0xFF3EB16F),
//                     shape: StadiumBorder(),
//                     child: Center(
//                       child: Text(
//                         "Confirm",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     onPressed: () {
//                       String medicineName;
//                       int dosage;
//                       //--------------------Error Checking------------------------
//                       //Had to do error checking in UI
//                       //Due to unoptimized BLoC value-grabbing architecture
//                       if (nameController.text == "") {
//                         _newEntryBloc.submitError(EntryError.NameNull);
//                         return;
//                       }
//                       if (nameController.text != "") {
//                         medicineName = nameController.text;
//                       }
//                       if (dosageController.text == "") {
//                         dosage = 0;
//                       }
//                       if (dosageController.text != "") {
//                         dosage = int.parse(dosageController.text);
//                       }
//                       for (var medicine in _globalBloc.medicineList$.value) {
//                         if (medicineName == medicine.medicineName) {
//                           _newEntryBloc.submitError(EntryError.NameDuplicate);
//                           return;
//                         }
//                       }
//                       if (_newEntryBloc.selectedInterval$.value == 0) {
//                         //error ใส่ interval 0
//                         _newEntryBloc.submitError(EntryError.Interval);
//                         return;
//                       }
//                       if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
//                         _newEntryBloc.submitError(EntryError.StartTime);
//                         return;
//                       }
//                       //---------------------------------------------------------
//                       String medicineType = _newEntryBloc
//                           .selectedMedicineType.value
//                           .toString()
//                           .substring(13);
//                       int interval = _newEntryBloc.selectedInterval$.value;

//                       int minterval = _newEntryBloc.selectedInterval$.value;

//                       String startTime = _newEntryBloc.selectedTimeOfDay$.value;

//                       List<int> intIDs = makeIDs(24 /
//                           _newEntryBloc.selectedInterval$
//                               .value); //fix id interval ถ้าไม่มี interval จะไม่มี id
//                       List<String> notificationIDs = intIDs
//                           .map((i) => i.toString())
//                           .toList(); //for Shared preference

//                       Medicine newEntryMedicine = Medicine(
//                         notificationIDs: notificationIDs,
//                         medicineName: medicineName,
//                         dosage: dosage,
//                         medicineType: medicineType,
//                         interval: interval,
//                         minterval: minterval,
//                         startTime: startTime,
//                       );

//                       _globalBloc.updateMedicineList(newEntryMedicine);
//                       scheduleNotification(newEntryMedicine);

//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (BuildContext context) {
//                             return SuccessScreen();
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void initializeErrorListen() {
//     _newEntryBloc.errorState$.listen(
//       (EntryError error) {
//         switch (error) {
//           case EntryError.NameNull:
//             displayError("Please enter the medicine's name");
//             break;
//           case EntryError.NameDuplicate:
//             displayError("Medicine name already exists");
//             break;
//           case EntryError.Dosage:
//             displayError("Please enter the dosage required");
//             break;
//           case EntryError.Interval:
//             displayError("Please select the reminder's interval ");
//             break;
//           case EntryError.StartTime:
//             displayError("Please select the reminder's starting time");
//             break;
//           default:
//         }
//       },
//     );
//   }

//   void displayError(String error) {
//     _scaffoldKey.currentState.showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         content: Text(error),
//         duration: Duration(milliseconds: 2000),
//       ),
//     );
//   }

//   List<int> makeIDs(double n) {
//     // make id from interval fix here
//     var rng = Random();
//     List<int> ids = [];
//     for (int i = 0; i < n; i++) {
//       ids.add(rng.nextInt(1000000000));
//     }
//     return ids;
//   }

//   initializeNotifications() async {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }
//     await await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NotificationClick(), //เปลี่ยนตรงนี้
//       ),
//     );
//   }

//   Future<void> scheduleNotification(Medicine medicine) async {
//     var hour = int.parse(medicine.startTime[0] + medicine.startTime[1]);
//     var ogValue = hour;
//     var minute = int.parse(medicine.startTime[2] + medicine.startTime[3]);
//     var ogmValue = minute;

//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'repeatDailyAtTime channel id',
//       'repeatDailyAtTime channel name',
//       'repeatDailyAtTime description',
//       importance: Importance.max,
//       //sound: 'sound',
//       ledColor: Color(0xFF3EB16F),
//       ledOffMs: 1000,
//       ledOnMs: 1000,
//       enableLights: true,
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);

//     if (hour == 0) {
//       print(null);
//     }

//     for (int i = 0; i <= (24 / medicine.interval).floor(); i++) {
//       //print(hour);
//       if ((hour + (medicine.interval * i) > 23)) {
//         hour = hour + (medicine.interval * i) - 24; //เกิน 24 ชม

//         if (minute + (medicine.minterval * i) > 59) {
//           hour = hour + 1;
//           if (hour > 23) {
//             hour = hour + (medicine.interval * i) - 24;
//           }
//           minute = minute + (medicine.minterval * i) - 60;
//         } else {
//           minute = minute + (medicine.minterval * i);
//         }
//         // hour = hour;
//         // minute = minute + 1;
//         print("loop1 | $hour : $minute");
//       } else {
//         hour = hour + (medicine.interval * i); // ไม่เกิน 24 ขม
//         if (hour > 23) {
//           hour = hour + (medicine.interval * i) - 24;
//         }
//         if (minute + (medicine.minterval * i) > 59) {
//           hour = hour + 1;
//           minute = minute + (medicine.minterval * i) - 60;
//         } else {
//           minute = minute + (medicine.minterval * i);
//         }
//         // hour = hour;
//         // minute = minute + 1;
//         print("loop2 | $hour : $minute");
//       }
//       // print("hour : $hour : minute :$minute");
//       // print("ogValue = $ogValue");
//       // print(medicine.minterval);

//       var showDailyAtTime = flutterLocalNotificationsPlugin.showDailyAtTime(
//           int.parse(medicine.notificationIDs[i]),
//           'Mediminder: ${medicine.medicineName}',
//           medicine.medicineType.toString() != MedicineType.None.toString()
//               ? 'It is time to take your ${medicine.medicineType.toLowerCase()}, according to schedule'
//               : 'It is time to take your medicine, according to schedule',
//           Time(hour, minute, 0),
//           platformChannelSpecifics);
//       await showDailyAtTime;
//       hour = ogValue;
//       minute = ogmValue;
//       // print("hour = og : $hour");
//     }
//     //await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

// class IntervalSelection extends StatefulWidget {
//   @override
//   _IntervalSelectionState createState() => _IntervalSelectionState();
// }

// class _IntervalSelectionState extends State<IntervalSelection> {
//   // var _intervals = [
//   //   0,
//   //   5,
//   //   6,
//   //   8,
//   //   12,
//   // ];
//   // var _mintervals = [
//   //   0,
//   // ];
//   var _selected = 0;
//   var _mselected = 0;
//   NumberPicker integerNumberPickerHour;
//   NumberPicker integerNumberPickerMinute;
//   TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
//   bool iosStyle = true;

//   void _initializeNumberPickersHour() {
//     final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
//     integerNumberPickerHour = new NumberPicker.integer(
//       itemExtent: 25,
//       initialValue: _selected,
//       minValue: 0,
//       maxValue: 24,
//       step: 1,
//       onChanged: (newVal) {
//         setState(() {
//           _selected = newVal;
//           _newEntryBloc.updateInterval(newVal);
//         });
//       },
//     );
//   }

//   void _initializeNumberPickersMinite() {
//     final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
//     integerNumberPickerMinute = new NumberPicker.integer(
//       itemExtent: 25,
//       initialValue: _mselected,
//       minValue: 0,
//       maxValue: 24,
//       step: 1,
//       onChanged: (newVal) {
//         setState(() {
//           _mselected = newVal;
//           _newEntryBloc.updatemInterval(newVal);
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     _initializeNumberPickersHour();
//     _initializeNumberPickersMinite();
//     final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
//     return Padding(
//       padding: EdgeInsets.only(top: 8.0),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             integerNumberPickerHour, Text("hours"), integerNumberPickerMinute,
//             Text("minutes"),
//             // // Text(
//             // //   "Remind me every  ",
//             // //   style: TextStyle(
//             // //     color: Colors.black,
//             // //     fontSize: 18,
//             // //     fontWeight: FontWeight.w500,
//             // //   ),
//             // // ),
//             // DropdownButton<int>(
//             //   iconEnabledColor: Color(0xFF3EB16F),
//             //   hint: _selected == 0
//             //       ? Text(
//             //           "0",
//             //           style: TextStyle(
//             //               fontSize: 20,
//             //               color: Colors.black,
//             //               fontWeight: FontWeight.w400),
//             //         )
//             //       : null,
//             //   elevation: 4,
//             //   value: _selected == 0 ? null : _selected,
//             //   items: _intervals.map((int value) {
//             //     return DropdownMenuItem<int>(
//             //       value: value,
//             //       child: Text(
//             //         value.toString(),
//             //         style: TextStyle(
//             //           color: Colors.black,
//             //           fontSize: 18,
//             //           fontWeight: FontWeight.w500,
//             //         ),
//             //       ),
//             //     );
//             //   }).toList(),
//             //   onChanged: (newVal) {
//             //     setState(() {
//             //       _selected = newVal;
//             //       _newEntryBloc.updateInterval(newVal);
//             //     });
//             //   },
//             // ),
//             // Text(
//             //   _selected == 1 ? " hours  " : " hours  ",
//             //   style: TextStyle(
//             //     color: Colors.black,
//             //     fontSize: 18,
//             //     fontWeight: FontWeight.w500,
//             //   ),
//             // ),
//             // DropdownButton<int>(
//             //   // minite
//             //   iconEnabledColor: Color(0xFF3EB16F),
//             //   hint: _mselected == 0
//             //       ? Text(
//             //           "0",
//             //           style: TextStyle(
//             //               fontSize: 20,
//             //               color: Colors.black,
//             //               fontWeight: FontWeight.w400),
//             //         )
//             //       : null,
//             //   elevation: 20,
//             //   value: _mselected == 0 ? null : _mselected,
//             //   items: _mintervals.map((int value) {
//             //     return DropdownMenuItem<int>(
//             //       value: value,
//             //       child: Text(
//             //         value.toString(),
//             //         style: TextStyle(
//             //           color: Colors.black,
//             //           fontSize: 18,
//             //           fontWeight: FontWeight.w500,
//             //         ),
//             //       ),
//             //     );
//             //   }).toList(),
//             //   onChanged: (mnewVal) {
//             //     setState(() {
//             //       _mselected = mnewVal;
//             //       _newEntryBloc.updatemInterval(mnewVal);
//             //     });
//             //   },
//             // ),
//             // Text(
//             //   _selected == 1 ? " minutes  " : " minutes  ",
//             //   style: TextStyle(
//             //     color: Colors.black,
//             //     fontSize: 18,
//             //     fontWeight: FontWeight.w500,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SelectTime extends StatefulWidget {
//   @override
//   _SelectTimeState createState() => _SelectTimeState();
// }

// class _SelectTimeState extends State<SelectTime> {
//   TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
//   bool _clicked = false;

//   // Future<TimeOfDay> _selectTime(BuildContext context) async {
//   //   final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
//   //   final TimeOfDay picked = await showTimePicker(
//   //     context: context,
//   //     initialTime: _time,
//   //   );
//   //   if (picked != null && picked != _time) {
//   //     setState(() {
//   //       _time = picked;
//   //       // _clicked = true;
//   //       _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
//   //           "${convertTime(_time.minute.toString())}");
//   //     });
//   //   }
//   //   return picked;
//   // }

//   Future onTimeChanged(TimeOfDay newTime) async {
//     final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);

//     setState(() {
//       _time = newTime;
//       _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
//           "${convertTime(_time.minute.toString())}");
//     });
//   }

//   bool click = false;
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton.extended(
//       elevation: 4.0,
//       icon: const Icon(Icons.timer),
//       label: Text(
//         click == false
//             ? " เลือกเวลา"
//             : " ${convertTime(_time.hour.toString())}  : " +
//                 "${convertTime(_time.minute.toString())}  ",
//         style: TextStyle(color: Colors.white),
//       ),
//       onPressed: () {
//         click = true;
//         Navigator.of(context).push(
//           showPicker(
//             context: context,
//             value: _time,
//             onChange: onTimeChanged,
//             minuteInterval: MinuteInterval.ONE,
//             disableHour: false,
//             disableMinute: false,
//             minMinute: 0,
//             maxMinute: 59,
//             // Optional onChange to receive value as DateTime
//             onChangeDateTime: (DateTime dateTime) {
//               print(dateTime);
//             },
//           ),
//         );
//       },
//       // child: Text(
//       //   click == false
//       //       ? " เลือกเวลา"
//       //       : " ${convertTime(_time.hour.toString())}  : " +
//       //           "${convertTime(_time.minute.toString())}  ",
//       //   style: TextStyle(color: Colors.white),
//       // ),
//     );
//   }
// }

// class MedicineTypeColumn extends StatelessWidget {
//   final MedicineType type;
//   final String name;
//   final int iconValue;
//   final bool isSelected;

//   MedicineTypeColumn(
//       {Key key,
//       @required this.type,
//       @required this.name,
//       @required this.iconValue,
//       @required this.isSelected})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
//     return GestureDetector(
//       onTap: () {
//         _newEntryBloc.updateSelectedMedicine(type);
//       },
//       child: Column(
//         children: <Widget>[
//           Container(
//             width: 85,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: isSelected ? Color(0xFF3EB16F) : Colors.white,
//             ),
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 14.0),
//                 child: Icon(
//                   IconData(iconValue, fontFamily: "Ic"),
//                   size: 75,
//                   color: isSelected ? Colors.white : Color(0xFF3EB16F),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 8.0),
//             child: Container(
//               width: 80,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: isSelected ? Color(0xFF3EB16F) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   name,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isSelected ? Colors.white : Color(0xFF3EB16F),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class PanelTitle extends StatelessWidget {
//   final String title;
//   final bool isRequired;
//   PanelTitle({
//     Key key,
//     @required this.title,
//     @required this.isRequired,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 12, bottom: 4),
//       child: Text.rich(
//         TextSpan(children: <TextSpan>[
//           TextSpan(
//             text: title,
//             style: TextStyle(
//                 fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
//           ),
//           TextSpan(
//             text: isRequired ? " *" : "",
//             style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
//           ),
//         ]),
//       ),
//     );
//   }
// }
