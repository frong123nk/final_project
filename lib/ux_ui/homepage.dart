import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_final_v2/global_bloc.dart';
import 'package:project_final_v2/ux_ui/home.dart';
import 'package:project_final_v2/ux_ui/med_detail2.dart';
import 'package:project_final_v2/ux_ui/new_entry/list_selecttime.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_final_v2/model/medicine.dart';
import 'package:project_final_v2/ux_ui/med_detail.dart';
import 'package:project_final_v2/ux_ui/new_entry/new_entry.dart';
import 'package:project_final_v2/transform_svg/trans_svg.dart';
import 'package:project_final_v2/time_countdown.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'dart:math' as math;
import 'new_entry/new_entry2.dart';
import 'notification_click.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  DateTime _selectedValueText = DateTime.now();
  String screenDayText = "Today";
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[100], //แถบด้านบน
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewEntry2(), //เปลี่ยนตรงนี้
                      ),
                    );
                  })
            ],
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.green[50],
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        width: 60,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.green,
                        selectedTextColor: Colors.white,
                        inactiveDates: [
                          // DateTime.now().add(Duration(days: 3)),
                          // DateTime.now().add(Duration(days: 4)),
                          // DateTime.now().add(Duration(days: 7))
                        ],
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            _selectedValue = date;

                            if (_selectedValueText.day == date.day) {
                              screenDayText = "Today";
                            } else if (_selectedValue.day ==
                                _selectedValueText.day + 1) {
                              screenDayText = "Tomorrow";
                            } else {
                              screenDayText = DateFormat('EEEE').format(date);
                            }
                            print(date.weekday);
                            print(DateFormat('EEEE').format(date));
                          });
                        },
                      ),
                    ),
                    Text(
                      "$screenDayText" +
                          " , " +
                          "${_selectedValue.day.toString()} " +
                          "${DateFormat('MMMM').format(_selectedValue)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Flexible(
                //   flex: 3,
                //   child: TopContainer(), //TopContainer()
                // ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 5,
                  child: Provider<GlobalBloc>.value(
                    child: BottomContainer(_selectedValue), //BottomContainer()
                    value: _globalBloc,
                  ),
                ),
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   elevation: 10,
          //   backgroundColor: HexColor('ffda77'),
          //   child: Icon(
          //     Icons.add,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => NewEntry2(), //เปลี่ยนตรงนี้
          //       ),
          //     );
          //   },
          // ),
        ),
        onWillPop: () async => true);
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[400],
            offset: Offset(0, 3.5),
          )
        ],
        color: Colors.green,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: 35,
            //color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
            ),
            // child: Center(
            //   child: Text(
            //     "Medidcine",
            //     style: TextStyle(
            //       fontFamily: "Nunito",
            //       fontSize: 20,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: SvgPicture.asset(meter, height: 90),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SvgPicture.asset(add, height: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: SvgPicture.asset(vitamin, height: 90),
                )
              ],
            ),
          ),
          Divider(
            color: HexColor('ffda77'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Center(
              child: Text(
                "Medicine",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 30,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 5),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style: TextStyle(
                      fontFamily: "Neu",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  final DateTime day;
  BottomContainer(this.day);
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Medicine>>(
      stream: _globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Color(0xFFF6F8FC),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(300.0),
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: 0.65,
                      heightFactor: 0.83,
                      child: Image.asset("assets/gif/medgifhome.gif"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: ExactAssetImage("assets/gif/medgifhome.gif"))),
                  color: Color(0xFFF6F8FC),
                  child: Center(
                    child: Text(
                      "Monitor your med schedule",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // fontFamily: 'Merriweather',
                          fontSize: 24,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: ButtonTheme(
                      minWidth: 350.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.cyan[900],
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewEntry2(), //เปลี่ยนตรงนี้
                            ),
                          );
                        },
                        child: const Text('Add a med',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.cyan[900])),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          );
        } else {
          List<int> dayList = [];

          int lengthCard = 0;
          for (int i = 0; i < snapshot.data.length; i++) {
            // print("lenght : ${snapshot.data[i].selectDay}")

            for (int x = 0; x < snapshot.data[i].selectDay.length; x++) {
              if (snapshot.data[i].selectDay[x] != "null") {
                print(
                    "getselectday : ${snapshot.data[i].selectDay[x].toString().substring(0)}");
                var testint =
                    int.parse(snapshot.data[i].selectDay[x].toString());
                if (testint == day.day) {
                  //กำหนดให้ วันที่เก็บเท่ากับวันบน tab หน้า homepage
                  dayList.add(i);
                  // } else if (snapshot.data[i].interval == 2 &&
                  //     DateFormat('EEEE').format(day) == "Monday") {
                  //   // fixedLengthList.add(i);
                  //   lengthCard = lengthCard + 1;
                  //   dayList.add(i);
                }
              }
            }
            // print("weekly day : ${DateFormat('EEEE').format(day)}");
            // print("lengthcard : $lengthCard");
            // print("snapshotlang : ${snapshot.data.length}");
            if (snapshot.data[i].selectWeekly == null) {
              dayList.add(i);
              print("nulllllllllllllllllllllllllllllllllllllllllllllllllll");
              print("${snapshot.data[i].selectWeekly}");
              // for (int w = 0; w < snapshot.data[i].selectWeekly.length; w++) {
              //   if (DateFormat('EEEE').format(day).substring(0, 3) ==
              //       snapshot.data[i].selectWeekly[w]) {
              //     dayList.add(i);
              //   }
              //   p0
              //
              //
              //rint("getselectweek : ${snapshot.data[i].selectWeekly[w]}");
              // }
            } else {
              for (int w = 0; w < snapshot.data[i].selectWeekly.length; w++) {
                if (DateFormat('EEEE').format(day).substring(0, 3) ==
                    snapshot.data[i].selectWeekly[w]) {
                  dayList.add(i);
                }
                print("name : ${snapshot.data[i].medicineName}");
                print("set week :${snapshot.data[i].selectWeekly}");
                // print("getselectweek : ${snapshot.data[i].selectWeekly[w]}");
              }
            }
          }
          if (dayList.length == 0) {
            print("DAY LIST NULLLLL");
            return Container(
              color: Color(0xFFF6F8FC),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(300.0),
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        widthFactor: 0.78,
                        heightFactor: 1,
                        child: Image.asset(
                          "assets/gif/nomed.gif",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: ExactAssetImage("assets/gif/medgifhome.gif"))),
                    color: Color(0xFFF6F8FC),
                    child: Center(
                      child: Text(
                        "No meds on this day!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontFamily: 'Merriweather',
                            fontSize: 24,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
            );
          }
          return Container(
            color: Colors.white,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12),
              // gridDelegate:
              //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemCount: dayList.length,
              itemBuilder: (context, index) {
                index = dayList[index];
                return MedicineCard(snapshot.data[index]);

                print("index : $index");
                print('interval : ${snapshot.data[index].interval}');
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  MedicineCard(this.medicine);

  Hero makeIcon(double size) {
    if (medicine.medicineType == "Bottle") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Colors.white,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Colors.white,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Colors.white,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: Colors.white,
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.error,
        color: Colors.white,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicineCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Material(
                color: Colors.black12,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Hero(
              tag: medicine.medicineName,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  medicine.medicineName,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Text(
            medicine.interval == 1
                ? medicine.interval.toString() + " time a days"
                : medicine.interval.toString() + " times a days",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFFC9C9C9),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );

    final timeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      padding: const EdgeInsets.only(left: 40),
      child: Text(
        medicine.getTimeSelectHouse[0] + ':' + medicine.getTimeSelectMinute[0],
        style: TextStyle(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );

    // var timerService = TimerService.of(context);
    return Container(
      height: 150.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: MedicineDetails2(medicine), //medicine in ()
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Column(children: <Widget>[
          Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 100),

                // child: makeIcon(75.0),
              ),
              Container(
                child: medicineCardContent,
                height: 150.0,
                margin: new EdgeInsets.only(left: 46.0),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
              ),
              Container(
                child: timeCardContent,
                height: 60.0,
                margin: new EdgeInsets.only(left: 46.0),
                decoration: BoxDecoration(
                  color: Colors.teal[400], //0xFF4C4A7F/pinkedit
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
              ),
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                    color: Colors.teal[900], shape: BoxShape.circle),
                alignment: FractionalOffset(0.5, 1),
                child: makeIcon(80.0),
                height: 92.0,
                width: 92.0,
              ),
            ],
          ),
          // Container(
          //   child: CountdownTime(medicine), //TopContainer()
          // ),
        ]),
      ),
    );
  }
}
