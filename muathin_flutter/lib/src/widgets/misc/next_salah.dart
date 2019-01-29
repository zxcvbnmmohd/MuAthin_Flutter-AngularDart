import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';

class NextSalah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(left: 25.0, top: 10.0, right: 25.0, bottom: 15.0),
      height: 150.0,
      decoration: BoxDecoration(
        color: Config.sColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Next Prayer',
                style: TextStyle(
                  color: Config.bgColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Text(
                this._timeTillNextSalah(s: this._nextSalah(s: userInheritance.mosque.todaySalahs)),
                style: TextStyle(
                  color: Config.bgColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            this._nextSalah(s: userInheritance.mosque.todaySalahs).time.format(context),
            style: TextStyle(
              color: Config.bgColor,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                this._nextSalah(s: userInheritance.mosque.todaySalahs).name,
                style: TextStyle(
                  color: Config.bgColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 25.0,
                child: Center(
                  child: this._nextSalah(s: userInheritance.mosque.todaySalahs).icon,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // MARK - Functions

  SalahModel _nextSalah({List<SalahModel> s}) {
    DateTime now = DateTime.now();
    List<DateTime> times = [];
    int currentSalah;

    s.forEach(
        (s) => times.add(DateTime(now.year, now.month, now.day, s.time.hour, s.time.minute, now.second, now.millisecond)));
    times.add(now);
    times.sort((a, b) => a.compareTo(b));
    currentSalah = times.indexWhere((d) => d == now);

    if (currentSalah == s.length) {
      return SalahModel(name: s[0].name, time: TimeOfDay(hour: s[0].time.hour, minute: s[0].time.minute), icon: s[0].icon);
    } else {
      return SalahModel(
          name: s[currentSalah].name,
          time: TimeOfDay(hour: s[currentSalah].time.hour, minute: s[currentSalah].time.minute),
          icon: s[currentSalah].icon);
    }
  }

  String _timeTillNextSalah({SalahModel s}) {
    DateTime now = DateTime.now();
    DateTime nextSalah = DateTime(now.year, now.month, now.day + 1, s.time.hour, s.time.minute);

    List<int> cTime = [0, 0, 0, 0];
    int diff = nextSalah.difference(now).inSeconds;
    cTime[0] = diff ~/ (24 * 60 * 60); // days
    diff -= cTime[0] * 24 * 60 * 60;

    cTime[1] = diff ~/ (60 * 60); // hours
    diff -= cTime[1] * 60 * 60;

    cTime[2] = diff ~/ 60; // minutes
    cTime[3] = diff - cTime[2] * 60; // seconds

    return '-' +
        '' +
        cTime[1].toString().padLeft(2, '0') +
        ':' +
        cTime[2].toString().padLeft(2, '0') +
        ':' +
        cTime[3].toString().padLeft(2, '0');
  }
}
