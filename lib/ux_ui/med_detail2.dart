import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_final_v2/model/medicine.dart';
import 'package:provider/provider.dart';

import 'package:project_final_v2/global_bloc.dart';

class MedicineDetails2 extends StatelessWidget {
  final Medicine medicine;

  MedicineDetails2(this.medicine);
  Widget setupAlertDialoadContainer() {
    return Container(
      height: 30 +
          (medicine.interval.toDouble() + medicine.interval.toDouble()) *
              25, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: medicine.interval,
        itemBuilder: (BuildContext context, int interval) {
          return ListTile(
            title: FloatingActionButton.extended(
              onPressed: null,
              heroTag: interval,
              backgroundColor: Colors.white,
              icon: const Icon(
                Icons.timer,
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              label: Text(
                "${medicine.timeSelectHours[interval]}" +
                    ":" +
                    "${medicine.getTimeSelectMinute[interval]}",
                style: TextStyle(color: Colors.green),
              ),
            ),
            // title: Text(
            //   "${medicine.timeSelectHours[interval]}" +
            //       ":" +
            //       "${medicine.getTimeSelectMinute[interval]}",
            //   style: TextStyle(color: Colors.green),
            // ),
          );
        },
      ),
    );
  }

  List<String> makeSelectimeFiveWeekly() {
    // make id from interval fix here
    List<String> day = [];
    for (int i = 0; i < 5; i++) {
      day.add(medicine.selectWeekly[i]);
    }
    return day;
  }

  List<String> makeSelectimeLastTwoWeekly() {
    // make id from interval fix here
    List<String> day = [];
    for (int i = 5; i < 7; i++) {
      day.add(medicine.selectWeekly[i]);
    }
    return day;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF3EB16F),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.green,
              ),
              onPressed: () {
                openAlertBox(context, _globalBloc);
                // do something
              },
            )
          ],
          centerTitle: true,
          title: Text(
            "Mediminder Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Positioned(
              height: MediaQuery.of(context).size.height / 1.6,
              width: MediaQuery.of(context).size.width - 20,
              left: 10.0,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                color: Colors.tealAccent[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Medicine Type",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(":",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text("${medicine.medicineType}",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Dosage",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(":",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text("${medicine.dosage}" + " mg",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Dose Interval",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(":",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text("${medicine.interval}" + " times a days ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Time",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(":",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 7,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: medicine.timeSelectHours.length >
                                            3
                                        ? <Widget>[
                                            FilterChip(
                                                backgroundColor:
                                                    Colors.green[900],
                                                label: Text(
                                                  medicine.timeSelectHours[0] +
                                                      ":" +
                                                      medicine
                                                          .timeSelectMinute[0],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onSelected: (b) {}),
                                            FilterChip(
                                                backgroundColor:
                                                    Colors.green[900],
                                                label: Text(
                                                  medicine.timeSelectHours[1] +
                                                      ":" +
                                                      medicine
                                                          .timeSelectMinute[1],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onSelected: (b) {}),
                                            FilterChip(
                                                backgroundColor:
                                                    Colors.green[900],
                                                label: Text(
                                                  medicine.timeSelectHours[2] +
                                                      ":" +
                                                      medicine
                                                          .timeSelectMinute[2],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onSelected: (b) {}),
                                            FilterChip(
                                                backgroundColor:
                                                    Colors.green[900],
                                                label: Text(
                                                  "...",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onSelected: (b) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("OK"),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                          title: Text(
                                                              'All time select'),
                                                          content:
                                                              setupAlertDialoadContainer(),
                                                        );
                                                      });
                                                })
                                          ]
                                        : medicine.timeSelectHours.length > 2
                                            ? <Widget>[
                                                FilterChip(
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    label: Text(
                                                      medicine.timeSelectHours[
                                                              0] +
                                                          ":" +
                                                          medicine
                                                              .timeSelectMinute[0],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onSelected: (b) {}),
                                                FilterChip(
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    label: Text(
                                                      medicine.timeSelectHours[
                                                              1] +
                                                          ":" +
                                                          medicine
                                                              .timeSelectMinute[1],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onSelected: (b) {}),
                                                FilterChip(
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    label: Text(
                                                      medicine.timeSelectHours[
                                                              2] +
                                                          ":" +
                                                          medicine
                                                              .timeSelectMinute[2],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onSelected: (b) {})
                                              ]
                                            : medicine.timeSelectHours.length >
                                                    1
                                                ? <Widget>[
                                                    FilterChip(
                                                        backgroundColor:
                                                            Colors.green[900],
                                                        label: Text(
                                                          medicine.timeSelectHours[
                                                                  0] +
                                                              ":" +
                                                              medicine
                                                                  .timeSelectMinute[0],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onSelected: (b) {})
                                                  ]
                                                : <Widget>[
                                                    FilterChip(
                                                        backgroundColor:
                                                            Colors.green[900],
                                                        label: Text(
                                                          medicine.timeSelectHours[
                                                                  0] +
                                                              ":" +
                                                              medicine
                                                                  .timeSelectMinute[0],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onSelected: (b) {})
                                                  ]
                                    // FilterChip(
                                    //     backgroundColor:
                                    //         Colors.pink[900],
                                    //     label: Text(
                                    //       medicine.timeSelectHours[0] +
                                    //           ":" +
                                    //           medicine
                                    //               .timeSelectMinute[0],
                                    //       style: TextStyle(
                                    //           color: Colors
                                    //               .tealAccent[100],
                                    //           fontSize: 20.0,
                                    //           fontWeight:
                                    //               FontWeight.bold),
                                    //     ),
                                    //     onSelected: (b) {})
                                    ),
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: medicine.selectWeekly.length == 0
                              ? MediaQuery.of(context).size.height / 17
                              : medicine.selectWeekly.length > 5
                                  ? MediaQuery.of(context).size.height / 8
                                  : MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: medicine.selectWeekly.length > 5
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("Day",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(":",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 40,
                                            // color: Colors.pink,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: medicine.selectWeekly
                                                          .length ==
                                                      7
                                                  ? makeSelectimeFiveWeekly()
                                                      .map((n) => FilterChip(
                                                            backgroundColor:
                                                                Colors.green,
                                                            label: Text(
                                                              n.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onSelected: (b) {},
                                                          ))
                                                      .toList()
                                                  : makeSelectimeFiveWeekly()
                                                      .map((n) => FilterChip(
                                                            backgroundColor:
                                                                Colors.green,
                                                            label: Text(
                                                              n.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onSelected: (b) {},
                                                          ))
                                                      .toList(),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            // color: Colors.black,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: medicine.interval ==
                                                        null
                                                    ? <Widget>[
                                                        Text(
                                                            "This is the final form")
                                                      ]
                                                    : makeSelectimeLastTwoWeekly()
                                                        .map((n) => FilterChip(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              label: Text(
                                                                n.toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onSelected:
                                                                  (b) {},
                                                            ))
                                                        .toList()),
                                          )
                                        ],
                                      ),
                                    ])
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("Day",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(":",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        // color: Colors.pink,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: medicine
                                                        .selectWeekly.length !=
                                                    0
                                                ? medicine.selectWeekly
                                                    .map((n) => FilterChip(
                                                          backgroundColor:
                                                              Colors.green,
                                                          label: Text(
                                                            n.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onSelected: (b) {},
                                                        ))
                                                    .toList()
                                                : medicine.selectDay
                                                    .map((n) => FilterChip(
                                                          backgroundColor:
                                                              Colors.green,
                                                          label: Text(
                                                            n.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onSelected: (b) {},
                                                        ))
                                                    .toList()),
                                      ),
                                    ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: MainSection(
                medicine: medicine,
              ),
            ),
          ],
        ));
  }

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        "Delete this Mediminder ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _globalBloc.removeMedicine(medicine);
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName('/'),
                          );
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF3EB16F),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0)),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
// _globalBloc.removeMedicine(medicine);
//                       Navigator.of(context).pop()

class MainSection extends StatelessWidget {
  final Medicine medicine;

  MainSection({
    Key key,
    @required this.medicine,
  }) : super(key: key);

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
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.local_hospital,
        color: Color(0xFF3EB16F),
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            child: makeIcon(148),
            radius: 60,
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 7.0),
            child: Text(
              "${medicine.medicineName}",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  MainInfoTab({Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            fieldTitle,
            style: TextStyle(
                fontSize: 17,
                color: Color(0xFFC9C9C9),
                fontWeight: FontWeight.bold),
          ),
          Text(
            fieldInfo,
            style: TextStyle(
                fontSize: 24,
                color: Color(0xFF3EB16F),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  final Medicine medicine;

  ExtendedSection({Key key, @required this.medicine}) : super(key: key);

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 30 +
          medicine.interval.toDouble() * 30, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: medicine.interval,
        itemBuilder: (BuildContext context, int interval) {
          return ListTile(
            title: FloatingActionButton.extended(
              onPressed: null,
              heroTag: interval,
              backgroundColor: Colors.white,
              icon: const Icon(
                Icons.timer,
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              label: Text(
                "${medicine.timeSelectHours[interval]}" +
                    ":" +
                    "${medicine.getTimeSelectMinute[interval]}",
                style: TextStyle(color: Colors.green),
              ),
            ),
            // title: Text(
            //   "${medicine.timeSelectHours[interval]}" +
            //       ":" +
            //       "${medicine.getTimeSelectMinute[interval]}",
            //   style: TextStyle(color: Colors.green),
            // ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ExtendedInfoTab(
            fieldTitle: "Medicine Type",
            fieldInfo: medicine.medicineType == "None"
                ? "Not Specified"
                : medicine.medicineType,
          ),
          ExtendedInfoTab(
            fieldTitle: "Dose Interval",
            fieldInfo: medicine.interval.floor().toString() + " times a days ",
          ),
          SizedBox(
              height: 50,
              width: 50,
              child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int interval) {
                    return FloatingActionButton.extended(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: [
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                                title: Text('All time select'),
                                content: setupAlertDialoadContainer(),
                              );
                            });
                      },
                      heroTag: interval,
                      backgroundColor: Colors.white,
                      icon: const Icon(
                        Icons.timer,
                        color: Colors.green,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.green)),
                      label: Text(
                        "",
                        style: TextStyle(color: Colors.green),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  ExtendedInfoTab(
      {Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                fieldTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFC9C9C9),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
