import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_final_v2/model/medicine.dart';
import 'package:provider/provider.dart';

import 'package:project_final_v2/global_bloc.dart';

class MedicineDetails extends StatelessWidget {
  final Medicine medicine;

  MedicineDetails(this.medicine);

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
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainSection(medicine: medicine),
              SizedBox(
                height: 15,
              ),
              ExtendedSection(medicine: medicine),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.06,
                  right: MediaQuery.of(context).size.height * 0.06,
                  top: 10,
                ),
                child: Container(
                  width: 280,
                  height: 70,
                  child: FlatButton(
                    color: Color(0xFF3EB16F),
                    shape: StadiumBorder(),
                    onPressed: () {
                      openAlertBox(context, _globalBloc);
                    },
                    child: Center(
                      child: Text(
                        "Delete Mediminder",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          color: Color(0xFF3EB16F),
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
      child: Row(
        children: <Widget>[
          makeIcon(175),
          SizedBox(
            width: 15,
          ),
          Column(
            children: <Widget>[
              Hero(
                tag: medicine.medicineName,
                child: Material(
                  color: Colors.transparent,
                  child: MainInfoTab(
                    fieldTitle: "Medicine Name",
                    fieldInfo: medicine.medicineName,
                  ),
                ),
              ),
              MainInfoTab(
                fieldTitle: "Dosage",
                fieldInfo: medicine.dosage == 0
                    ? "Not Specified"
                    : medicine.dosage.toString() + " mg",
              )
            ],
          )
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
          // SizedBox(
          //   height: 100,
          //   child: Expanded(
          //     child: ListView.builder(
          //       itemCount: medicine.interval,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (BuildContext ctxt, int interval) {
          //         return new ExtendedInfoTab(
          //             fieldTitle: "",
          //             fieldInfo: medicine.timeSelectHours[interval] +
          //                 ":" +
          //                 medicine.timeSelectMinute[interval] +
          //                 'นาฬิกา');
          //       },
          //     ),
          //   ),
          // ),
          // ExtendedInfoTab(
          //     fieldTitle: "At Time",
          //     fieldInfo: medicine.timeSelect[0] +
          //         medicine.timeSelect[0] +
          //         ":" +
          //         medicine.timeSelect[1] +
          //         medicine.timeSelect[1]),
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
