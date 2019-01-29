import 'package:flutter/material.dart';
import 'package:muathin_common/src/configs/config.dart';

class SalahModel {
  String name;
  int position;
  TimeOfDay time;
  Image icon;

  SalahModel({this.name, this.position, this.time, this.icon});

  SalahModel transform({Map map}) {
    SalahModel salah = new SalahModel();

    salah.name = map['name'];
    salah.position = map['position'];
    salah.time = TimeOfDay(hour: map['hour'], minute: map['minute']);

    if (salah.name == 'Fajr') {
      salah.position = 1;
      salah.icon = Image.asset(Config.pathFajr, color: Config.bgColor);
    } else if (salah.name == 'Thuhr') {
      salah.position = 2;
      salah.icon = Image.asset(Config.pathThuhr, color: Config.bgColor);
    }else if (salah.name == 'Asr') {
      salah.position = 3;
      salah.icon = Image.asset(Config.pathAsr, color: Config.bgColor);
    } else if (salah.name == 'Maghreb') {
      salah.position = 4;
      salah.icon = Image.asset(Config.pathMaghreb, color: Config.bgColor);
    } else if (salah.name == 'Isha') {
      salah.position = 5;
      salah.icon = Image.asset(Config.pathIsha, color: Config.bgColor);
    } else if (salah.name == 'Jumuah') {
      salah.position = 6;
      salah.icon = Image.asset(Config.pathThuhr, color: Config.bgColor);
    }  else if (salah.name == 'Eid Al-Fitr') {
      salah.position = 7;
      salah.icon = Image.asset(Config.pathEid, color: Config.bgColor);
    } else if ( salah.name == 'Eid Al-Adha') {
      salah.position = 8;
      salah.icon = Image.asset(Config.pathEid, color: Config.bgColor);
    }

    return salah;
  }
}
