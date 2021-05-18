import 'package:project_final_v2/model/errors.dart';
import 'package:project_final_v2/model/medicine_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_database/firebase_database.dart';

class NewEntryBloc {
  BehaviorSubject<MedicineType> _selectedMedicineType$;
  BehaviorSubject<MedicineType> get selectedMedicineType =>
      _selectedMedicineType$.stream;

  // BehaviorSubject<List<Day>> _checkedDays$;
  // BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;
  final databaseReference = FirebaseDatabase.instance.reference();
  BehaviorSubject<int> _selectedInterval$;
  BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  BehaviorSubject<int> _selectedid$;
  BehaviorSubject<int> get selectedid$ => _selectedid$;

  BehaviorSubject<int> _selectedmInterval$;
  BehaviorSubject<int> get selectedmInterval$ => _selectedmInterval$;

  BehaviorSubject<String> _selectedTimeOfDay$;
  BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<String> _selectedManyTimeOfDay$;
  BehaviorSubject<String> get selectedManyTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  NewEntryBloc() {
    _selectedMedicineType$ =
        BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _selectedmInterval$ = BehaviorSubject<int>.seeded(0);
    _selectedid$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
    // _selectedManyTimeOfDay$ = BehaviorSubject<dynamic>();
  }

  void dispose() {
    _selectedMedicineType$.close();
    // _checkedDays$.close();
    _selectedTimeOfDay$.close();
    _selectedInterval$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$.add(interval);
  }

  void updateId(int id) {
    _selectedid$.add(id);
  }

  void updatemInterval(int minterval) {
    _selectedmInterval$.add(minterval);
  }

  void updateTime(String time) {
    _selectedTimeOfDay$.add(time);
  }

  // void addtoDays(Day day) {
  //   List<Day> _updatedDayList = _checkedDays$.value;
  //   if (_updatedDayList.contains(day)) {
  //     _updatedDayList.remove(day);
  //   } else {
  //     _updatedDayList.add(day);
  //   }
  //   _checkedDays$.add(_updatedDayList);
  // }

  void updateSelectedMedicine(MedicineType type) {
    MedicineType _tempType = _selectedMedicineType$.value;
    if (type == _tempType) {
      _selectedMedicineType$.add(MedicineType.None);
    } else {
      _selectedMedicineType$.add(type);
    }
  }
}
