import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class CurrentSalahItem extends StatelessWidget {
  final SalahModel salah;
  final int iqaama;

  CurrentSalahItem({this.salah, this.iqaama});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Comming Up',
                  style: TextStyle(
                    color: Config.bgColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Text(
                this._timeTillNextSalah(s: this.salah),
                style: TextStyle(
                  color: Config.bgColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              this.salah.icon,
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  this.salah.name,
                  style: TextStyle(
                    color: Config.bgColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              SizedBox(width: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    this.salah.time.format(context),
                    style: TextStyle(
                      color: Config.bgColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(this._iqaama(athan: this.salah.time, iqaama: this.iqaama).format(context),
                      style: TextStyle(
                        color: Config.bgColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // MARK - Functions

  TimeOfDay _iqaama({TimeOfDay athan, int iqaama}) {
    DateTime now = new DateTime.now();
    DateTime a = new DateTime(now.year, now.month, now.day, athan.hour, athan.minute);
    DateTime diff = a.add(Duration(minutes: iqaama));
    return TimeOfDay.fromDateTime(diff);
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
