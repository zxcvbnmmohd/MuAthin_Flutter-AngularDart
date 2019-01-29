import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/widgets/lists/list/mosques_list.dart';
import 'package:muathin/src/widgets/misc/text_view.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Mosques extends StatefulWidget {
  @override
  _MosquesState createState() => _MosquesState();
}

class _MosquesState extends State<Mosques> {
  TextEditingController _addressTEC = new TextEditingController();
  FocusNode _addressFN = new FocusNode();
  AddressModel _address;
  List<MosqueModel> _mosques = [];
  bool _didFindMosques = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> w = [
      TextView(
        margin: EdgeInsets.only(top: 25.0),
        padding: EdgeInsets.only(left: 25.0),
        controller: this._addressTEC,
        focusNode: this._addressFN,
        label: 'Address',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onChanged: (s) {},
        onSubmitted: (s) {},
        keyboardAppearance: Brightness.light,
        onTap: () {
          Functions.showAutoComplete(onSuccess: (p) {
            if (!mounted) return;
            setState(() {
              this._address = new AddressModel(
                  type: 'Mosque',
                  short: p.name,
                  long: p.address,
                  geopoint: AddressModel().toGeoPoint(p.latitude, p.longitude));
              this._addressTEC.text = this._address.short;
            });

            APIs().mosques.observeGeoMosques(lat: p.latitude, lon: p.longitude, radius: 10, limitTo: 10).listen(
              (mosques) {
                if (mosques.isNotEmpty) {
                  if (!mounted) return;
                  setState(() {
                    this._mosques = mosques;
                    this._didFindMosques = true;
                  });
                } else {
                  if (!mounted) return;
                  setState(() {
                    this._didFindMosques = false;
                  });
                  print('none');
                  print(mosques);
                }
              },
            );
          });
        },
      ),
      this._didFindMosques
          ? MosquesList(mosques: this._mosques)
          : Container(
              child: Center(
                child: Text(
                  !this._didFindMosques && this._addressTEC.text.length != 0 ? 'No Mosques Near you' : '',
                  style: TextStyle(color: Config.sColor, fontSize: 30.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Where are you located?',
      leading: IconButton(
        icon: Icon(Icons.close),
        color: Config.sColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Address',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }

  // MARK - Functions

  initMosques() {}
}
