import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/lists/item/current_salah_item.dart';
import 'package:muathin/src/widgets/lists/item/salah_item.dart';

class SalahsList extends StatefulWidget {

  _SalahsListState createState() => _SalahsListState();
}

class _SalahsListState extends State<SalahsList> {

  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);

    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0.0, bottom: 15.0),
      itemBuilder: (context, index) {
        if (this._nextSalah(s:userInheritance.mosque.todaySalahs).name == userInheritance.mosque.todaySalahs[index].name) {
          return CurrentSalahItem(
            salah: userInheritance.mosque.todaySalahs[index],
            iqaama: 15,
          );
        } else {
          return SalahItem(
            salah: userInheritance.mosque.todaySalahs[index],
            iqaama: 15,
          );
        }
      },
      itemCount: userInheritance.mosque.todaySalahs.length,
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

}
