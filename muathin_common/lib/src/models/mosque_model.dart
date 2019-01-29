import 'package:muathin_common/src/models/address_model.dart';
import 'package:muathin_common/src/models/salah_model.dart';

class MosqueModel {
  String mosqueID, name, number, url, bio;
  AddressModel address;
  List<SalahModel> salahs = [];
  List<SalahModel> todaySalahs = [];
  List<dynamic> admins;

  MosqueModel transform({String key, Map map}) {
    MosqueModel mosque = new MosqueModel();
    List<dynamic> salahs = map['prayerTimes'];
    List<dynamic> admins = map['admins'];

    mosque.mosqueID = key;
    mosque.address = AddressModel().transform(map: map['address']);
    mosque.admins = admins;
    mosque.bio = map['bio'];
    mosque.name = map['name'];
    mosque.number = map['number'];

    salahs.forEach((s) {
      mosque.salahs.add(SalahModel().transform(map: s));
      mosque.salahs.sort((a, b) => a.position.compareTo(b.position));
    });

    salahs.forEach((s) {
      SalahModel salah = SalahModel().transform(map: s);

      if (salah.name == 'Eid Al-Fitr') {
      } else if (salah.name == 'Eid Al-Adha') {
      } else if (salah.name == 'Jumuah') {
        if (DateTime.now().weekday == 5) {
          mosque.todaySalahs.add(salah);
        }
      } else if (salah.name == 'Thuhr') {
        if (DateTime.now().weekday != 5) {
          mosque.todaySalahs.add(salah);
        }
      } else {
        mosque.todaySalahs.add(salah);
      }

      mosque.todaySalahs.sort((a, b) => a.time.hour.compareTo(b.time.hour));
    });

    mosque.url = map['url'];

    return mosque;
  }
}
