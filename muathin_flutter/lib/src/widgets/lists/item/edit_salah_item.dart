import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/misc/button.dart';
import 'package:muathin/src/widgets/misc/text_view.dart';

class EditSalahItem extends StatefulWidget {
  final int index;

  EditSalahItem({this.index});

  @override
  _EditSalahItemState createState() => _EditSalahItemState();
}

class _EditSalahItemState extends State<EditSalahItem> {
  TextEditingController _textEditingController = new TextEditingController();
  TextEditingController _dateTextEditingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  FocusNode _dateFocusNode = new FocusNode();
  TimeOfDay _time;
  DateTime _date = DateTime.now();
  DateFormat _dateFormatter = new DateFormat('MMMM d, yyyy');

  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);

    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 85.0,
              margin: EdgeInsets.only(left: 25.0, top: 5.0),
              child: Text(
                userInheritance.mosque.salahs[widget.index].name,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: TextView(
                margin: EdgeInsets.only(top: 5.0, right: 25.0),
                padding: EdgeInsets.only(left: 25.0),
                controller: this._textEditingController,
                focusNode: this._focusNode,
                label: userInheritance.mosque.salahs[widget.index].time.format(context),
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onTap: () async {
                  TimeOfDay t =
                      await showTimePicker(context: context, initialTime: userInheritance.mosque.salahs[widget.index].time);
                  if (t != null) {
                    setState(() {
                      this._time = t;
                      this._textEditingController.text = this._time.format(context);
                    });
                  }
                },
              ),
            ),
            userInheritance.mosque.salahs[widget.index].name == 'Eid Al-Fitr' || userInheritance.mosque.salahs[widget.index].name == 'Eid Al-Adha'
                ? this._textEditingController.text.length != 0
                    ? this._dateTextEditingController.text.length != 0
                        ? Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Button(
                              outline: false,
                              text: 'Update',
                              color: Config.sColor,
                              height: 50.0,
                              onTap: () {
                                Services().crud.updateArray(
                                    ref: APIs().mosques.mosquesCollection.document(userInheritance.mosque.mosqueID),
                                    key: 'prayerTimes',
                                    value: {
                                      'hour': userInheritance.mosque.salahs[widget.index].time.hour,
                                      'minute': userInheritance.mosque.salahs[widget.index].time.minute,
                                      'name': userInheritance.mosque.salahs[widget.index].name
                                    },
                                    m: {
                                      'hour': this._time.hour,
                                      'minute': this._time.minute,
                                      'name': userInheritance.mosque.salahs[widget.index].name
                                    },
                                    onSuccess: () async {
                                      setState(() {
                                        this._textEditingController.clear();
                                      });
                                      userInheritance.setMosque(
                                          await APIs().mosques.mosque(mosqueID: userInheritance.mosque.mosqueID));
                                    },
                                    onFailure: (e) {
                                      print(e);
                                    });
                              },
                            ),
                          )
                        : Container()
                    : Container()
                : this._textEditingController.text.length == 0
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Button(
                          outline: false,
                          text: 'Update',
                          color: Config.sColor,
                          height: 50.0,
                          onTap: () {
                            Services().crud.updateArray(
                                ref: APIs().mosques.mosquesCollection.document(userInheritance.mosque.mosqueID),
                                key: 'prayerTimes',
                                value: {
                                  'hour': userInheritance.mosque.salahs[widget.index].time.hour,
                                  'minute': userInheritance.mosque.salahs[widget.index].time.minute,
                                  'name': userInheritance.mosque.salahs[widget.index].name
                                },
                                m: {
                                  'hour': this._time.hour,
                                  'minute': this._time.minute,
                                  'name': userInheritance.mosque.salahs[widget.index].name
                                },
                                onSuccess: () async {
                                  setState(() {
                                    this._textEditingController.clear();
                                  });
                                  userInheritance
                                      .setMosque(await APIs().mosques.mosque(mosqueID: userInheritance.mosque.mosqueID));
                                },
                                onFailure: (e) {
                                  print(e);
                                });
                          },
                        ),
                      )
          ],
        ),
        userInheritance.mosque.salahs[widget.index].name == 'Eid Al-Fitr' || userInheritance.mosque.salahs[widget.index].name == 'Eid Al-Adha'
            ? TextView(
                margin: EdgeInsets.only(left: 110, top: 0.0, right: 25.0),
                padding: EdgeInsets.only(left: 25.0),
                controller: this._dateTextEditingController,
                focusNode: this._dateFocusNode,
                label: this._dateFormatter.format(this._date),
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onTap: () async {
                  DateTime d = await showDatePicker(
                      context: context, initialDate: DateTime.now(), firstDate: DateTime(2015), lastDate: DateTime(2030));
                  if (d != null) {
                    setState(() {
                      this._date = d;
                      this._dateTextEditingController.text = this._dateFormatter.format(this._date);
                    });
                  }
                },
              )
            : Container(),
      ],
    );
  }
}
