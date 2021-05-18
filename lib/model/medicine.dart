class Medicine {
  final int id;
  final List<dynamic> notificationIDs;
  final String medicineName;
  final int dosage;
  final String medicineType;
  final int interval;
  final int minterval;
  final String startTime;
  final List<dynamic> timeSelectHours;
  final List<dynamic> timeSelectMinute;
  final List<dynamic> selectDay;
  final List<dynamic> selectWeekly;

  Medicine(
      {this.id,
      this.notificationIDs,
      this.medicineName,
      this.dosage,
      this.medicineType,
      this.startTime,
      this.interval,
      this.minterval,
      this.timeSelectHours,
      this.timeSelectMinute,
      this.selectDay,
      this.selectWeekly});

  int get getDosage => dosage;
  String get getType => medicineType;
  int get getInterval => interval;
  int get getmInterval => minterval;
  int get getId => id;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;
  List<dynamic> get getTimeSelectHouse => timeSelectHours;
  List<dynamic> get getTimeSelectMinute => timeSelectMinute;
  List<dynamic> get getSelectDay => selectDay;
  List<dynamic> get getSelectWeekly => selectWeekly;

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "ids": this.notificationIDs,
      "name": this.medicineName,
      "dosage": this.dosage,
      "type": this.medicineType,
      "interval": this.interval,
      "minterval": this.minterval,
      "start": this.startTime,
      "timeselecthours": this.timeSelectHours,
      "timeselectminute": this.timeSelectMinute,
      "selectday": this.selectDay,
      "selectweekly": this.selectWeekly,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      id: parsedJson['id'],
      notificationIDs: parsedJson['ids'],
      medicineName: parsedJson['name'],
      dosage: parsedJson['dosage'],
      medicineType: parsedJson['type'],
      interval: parsedJson['interval'],
      minterval: parsedJson['minterval'],
      startTime: parsedJson['start'],
      timeSelectHours: parsedJson['timeselecthours'],
      timeSelectMinute: parsedJson['timeselectminute'],
      selectDay: parsedJson['selectday'],
      selectWeekly: parsedJson['selectweekly'],
    );
  }
}
