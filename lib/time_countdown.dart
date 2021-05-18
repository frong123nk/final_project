import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'model/medicine.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:project_final_v2/global_bloc.dart';
import 'dart:math' as math;
import 'package:project_final_v2/model/medicine.dart';
import 'dart:async';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// void main() {
//   final timerService = TimerService();
//   runApp(
//     TimerServiceProvider(
//       // provide timer service to all widgets of your app
//       service: timerService,
//       child: MyApp(),
//     ),
//   );
// }
class TimerService extends ChangeNotifier {
  Medicine medicine;
  Stopwatch _watch;
  Timer _timer;

  Duration get currentDuration => _currentDuration;
  double get process => _process;
  Duration _currentDuration = Duration.zero;
  double _process;
  bool get isRunning => _timer != null;

  TimerService() {
    _watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    var i = medicine.interval;
    print("value i $i");
    _currentDuration = _watch.elapsed;

    // notify all listening widgets
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();
    print("notify_staet");
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;
    print("notify_stop");
    notifyListeners();
  }

  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;
    print("notify_reset");
    notifyListeners();
  }

  static TimerService of(BuildContext context) {
    var provider =
        context.dependOnInheritedWidgetOfExactType<TimerServiceProvider>()
            as TimerServiceProvider;
    return provider.service;
  }
}

class TimerServiceProvider extends InheritedWidget {
  const TimerServiceProvider({Key key, this.service, Widget child})
      : super(key: key, child: child);

  final TimerService service;

  @override
  bool updateShouldNotify(TimerServiceProvider old) => service != old.service;
}

class CountdownTime extends StatefulWidget {
  Medicine medicine;
  CountdownTime(this.medicine);
  @override
  _CountdownTime createState() => _CountdownTime(medicine);
}

class _CountdownTime extends State<CountdownTime> {
  Medicine medicine;

  _CountdownTime(this.medicine);
  var interval;
  double start;
  @override
  // void initState() {
  //   Timer timer;
  //   interval = medicine.interval.toDouble();
  //   start = 0;
  //   print(interval);
  //   timer = Timer.periodic(Duration(seconds: 1), (_) {
  //     print('Percent Update');
  //     setState(() {
  //       start += 20;
  //       if (start >= interval * 100) {
  //         initState();
  //         // timer.cancel();
  //         // percent=0;
  //       }
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var time = widget.medicine.interval;
    var timerService = TimerService.of(context);
    return AnimatedBuilder(
      animation: timerService, // listen to ChangeNotifier
      builder: (context, child) {
        // this part is rebuilt whenever notifyListeners() is called
        return Container(
          height: 20,
          child: LiquidLinearProgressIndicator(
            value: 1 / 1000, //start
            valueColor: AlwaysStoppedAnimation(Colors.pink),
            backgroundColor: Colors.white,
            borderColor: Colors.red,
            borderWidth: 5.0,
            borderRadius: 12.0,
            direction: Axis.horizontal,
            center: Text(
              10.toString() + "%",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}

// class CountDownTimer extends StatefulWidget {
//   Medicine medicine;
//   // // CountDownTimer({Key key, this.info_list}) : super(key: key);
//   CountDownTimer(this.medicine);
//   @override
//   _CountDownTimerState createState() => _CountDownTimerState(medicine);
// }

// class _CountDownTimerState extends State<CountDownTimer>
//     with TickerProviderStateMixin {
//   AnimationController controller;

//   Medicine medicine;

//   _CountDownTimerState(this.medicine);
//var time = medicine.interval;
// _CountDownTimerState(this.mideicine);

//var inteval = medicine.interval;

//   String get timerString {
//     Duration duration = controller.duration * controller.value;
//     return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }

//   @override
//   void initState() {
//     super.initState();
//     var time = widget.medicine.interval;
//     var mtime = widget.medicine.minterval;
//     print("time : $time");
//     var now = new DateTime.now();
//     var hnow = now.hour;
//     var mnow = now.minute;
//     var minute = int.parse(medicine.startTime[2] + medicine.startTime[3]);
//     print(minute);
//     var timefinish = minute + mtime;

//     var countdown = timefinish - mnow;
//     print(countdown.abs());
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(minutes: countdown.abs()),
//     )..repeat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);

//     return Scaffold(
//       backgroundColor: Colors.white10,
//       body: AnimatedBuilder(
//           animation: controller,
//           builder: (context, child) {
//             return Stack(
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     color: Colors.amber,
//                     height:
//                         controller.value * MediaQuery.of(context).size.height,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Expanded(
//                         child: Align(
//                           alignment: FractionalOffset.center,
//                           child: AspectRatio(
//                             aspectRatio: 1.0,
//                             child: Stack(
//                               children: <Widget>[
//                                 Positioned.fill(
//                                   child: CustomPaint(
//                                       painter: CustomTimerPainter(
//                                     animation: controller,
//                                     backgroundColor: Colors.white,
//                                     color: themeData.indicatorColor,
//                                   )),
//                                 ),
//                                 Align(
//                                   alignment: FractionalOffset.center,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "Count Down Timer",
//                                         style: TextStyle(
//                                             fontSize: 20.0,
//                                             color: Colors.white),
//                                       ),
//                                       Text(
//                                         timerString,
//                                         style: TextStyle(
//                                             fontSize: 112.0,
//                                             color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       // AnimatedBuilder(
//                       //     animation: controller,
//                       //     builder: (context, child) {
//                       //       return FloatingActionButton.extended(
//                       //           onPressed: () {
//                       //             if (controller.isAnimating)
//                       //               controller.stop();
//                       //             else {
//                       //               controller.reverse(
//                       //                   from: controller.value == 0.0
//                       //                       ? 1.0
//                       //                       : controller.value);
//                       //             }
//                       //           },
//                       //           icon: Icon(controller.isAnimating
//                       //               ? Icons.pause
//                       //               : Icons.play_arrow),
//                       //           label: Text(
//                       //               controller.isAnimating ? "Pause" : "Play"));
//                       //     }),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }

// class CustomTimerPainter extends CustomPainter {
//   CustomTimerPainter({
//     this.animation,
//     this.backgroundColor,
//     this.color,
//   }) : super(repaint: animation);

//   final Animation<double> animation;
//   final Color backgroundColor, color;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = backgroundColor
//       ..strokeWidth = 10.0
//       ..strokeCap = StrokeCap.butt
//       ..style = PaintingStyle.stroke;

//     canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
//     paint.color = color;
//     double progress = (1.0 - animation.value) * 2 * math.pi;
//     canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
//   }

//   @override
//   bool shouldRepaint(CustomTimerPainter old) {
//     return animation.value != old.animation.value ||
//         color != old.color ||
//         backgroundColor != old.backgroundColor;
//   }
// }

// class Time_coundown extends StatelessWidget {
//   @override
//   final Medicine medicine;

//   Time_coundown(this.medicine);

//   Widget build(BuildContext context) {
//     final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
//     var hour = int.parse(medicine.startTime[0] + medicine.startTime[1]);
//     var ogValue = hour;
//     var minute = int.parse(medicine.startTime[2] + medicine.startTime[3]);
//     var ogmValue = minute;

//     var countdown = ogValue + medicine.interval;
//     int endTime = DateTime.now().millisecondsSinceEpoch + (1 * (10 * 60 * 60));
//     print("$hour:$minute");
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           CountdownTimer(
//             endTime: endTime,
//           ),
//           CountdownTimer(
//             endTime: endTime,
//             textStyle: TextStyle(fontSize: 30, color: Colors.pink),
//           ),
//           CountdownTimer(
//             endTime: endTime,
//             widgetBuilder: (_, CurrentRemainingTime time) {
//               return Text(
//                   'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
//             },
//           ),
//           CountdownTimer(
//             endTime: endTime,
//             widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
//               List<Widget> list = [];
//               if (time.days != null) {
//                 list.add(Row(
//                   children: <Widget>[
//                     Icon(Icons.sentiment_dissatisfied),
//                     Text(time.days.toString()),
//                   ],
//                 ));
//               }
//               if (time.hours != null) {
//                 list.add(Row(
//                   children: <Widget>[
//                     Icon(Icons.sentiment_satisfied),
//                     Text(time.hours.toString()),
//                   ],
//                 ));
//               }
//               if (time.min != null) {
//                 list.add(Row(
//                   children: <Widget>[
//                     Icon(Icons.sentiment_very_dissatisfied),
//                     Text(time.min.toString()),
//                   ],
//                 ));
//               }
//               if (time.sec != null) {
//                 list.add(Row(
//                   children: <Widget>[
//                     Icon(Icons.sentiment_very_satisfied),
//                     Text(time.sec.toString()),
//                   ],
//                 ));
//               }

//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: list,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
