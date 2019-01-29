import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class Functions {
  static navigateTo({BuildContext context, Widget w, bool fullscreenDialog}) {
    Platform.isIOS
        ? Navigator.push(context, CupertinoPageRoute(builder: (context) => w, fullscreenDialog: fullscreenDialog))
        : Navigator.push(context, MaterialPageRoute(builder: (context) => w, fullscreenDialog: fullscreenDialog));
  }

  static navigateAndReplaceWith({BuildContext context, Widget w}) {
    Navigator.pushReplacement(context, PageTransition(child: w, type: PageTransitionType.fade));
  }

  static popup({BuildContext context, Widget w}) {
    Widget c = Container(
      color: Colors.transparent,
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), child: w),
    );

    Platform.isIOS
        ? showCupertinoDialog(
        context: context,
        builder: (context) {
          return c;
        })
        : showDialog(
        context: context,
        builder: (context) {
          return c;
        });
  }

  static dialog({BuildContext context, String title, List<Widget> actions, List<Widget> options}) {
    Platform.isIOS
        ? showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
                child: Text('Cancel')),
          );
        })
        : showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: Text(title), children: options);
        });
  }

  static bottomSheet({BuildContext context, Widget widget}) {
    Platform.isIOS
        ? showModalBottomSheet(
        context: context,
        builder: (context) {
          return widget;
        })
        : showBottomSheet(
        context: context,
        builder: (context) {
          return widget;
        });
  }

  static String readDateTime({DateTime date}) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  static Future fromCamera({Function onSuccess(File f)}) async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        onSuccess(image);
      }
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  static Future fromGallery({Function onSuccess(File f)}) async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        onSuccess(image);
      }
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  static addPhoto({BuildContext context, Function onSuccess(File file)}) {
    dialog(context: context, title: 'Add Photo', actions: [
      CupertinoActionSheetAction(
        onPressed: () {
          fromCamera(onSuccess: (file) {
            onSuccess(file);
          });
          Navigator.pop(context);
        },
        child: Text('Camera'),
      ),
      CupertinoActionSheetAction(
        onPressed: () {
          fromGallery(onSuccess: (file) {
            onSuccess(file);
          });
          Navigator.pop(context);
        },
        child: Text('Gallery'),
      )
    ], options: [
      SimpleDialogOption(
        onPressed: () {
          fromCamera(onSuccess: (file) {
            onSuccess(file);
          });
          Navigator.pop(context);
        },
        child: Text('Camera'),
      ),
      SimpleDialogOption(
        onPressed: () {
          fromGallery(onSuccess: (file) {
            onSuccess(file);
          });
          Navigator.pop(context);
        },
        child: Text('Gallery'),
      )
    ]);
  }

  static showPlacePicker({Function onSuccess(Place p)}) async {
    try {
      Place place = await PluginGooglePlacePicker.showPlacePicker();
      if (place != null) {
        onSuccess(place);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static showAutoComplete({Function onSuccess(Place p)}) async {
    try {
      Place place = await PluginGooglePlacePicker.showAutocomplete(PlaceAutocompleteMode.MODE_OVERLAY);
      if (place != null) {
        onSuccess(place);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Map<String, dynamic>> deviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    Map<String, dynamic> deviceData;

    if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
      deviceData = {
        'name': info.name,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
        'model': info.model,
        'localizedModel': info.localizedModel,
        'identifierForVendor': info.identifierForVendor,
        'isPhysicalDevice': info.isPhysicalDevice,
        'utsname.sysname:': info.utsname.sysname,
        'utsname.nodename:': info.utsname.nodename,
        'utsname.release:': info.utsname.release,
        'utsname.version:': info.utsname.version,
        'utsname.machine:': info.utsname.machine,
      };
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      deviceData = {
        'version.securityPatch': info.version.securityPatch,
        'version.sdkInt': info.version.sdkInt,
        'version.release': info.version.release,
        'version.previewSdkInt': info.version.previewSdkInt,
        'version.incremental': info.version.incremental,
        'version.codename': info.version.codename,
        'version.baseOS': info.version.baseOS,
        'board': info.board,
        'bootloader': info.bootloader,
        'brand': info.brand,
        'device': info.device,
        'display': info.display,
        'fingerprint': info.fingerprint,
        'hardware': info.hardware,
        'host': info.host,
        'id': info.id,
        'manufacturer': info.manufacturer,
        'model': info.model,
        'product': info.product,
        'supported32BitAbis': info.supported32BitAbis,
        'supported64BitAbis': info.supported64BitAbis,
        'supportedAbis': info.supportedAbis,
        'tags': info.tags,
        'type': info.type,
        'isPhysicalDevice': info.isPhysicalDevice,
        'androidId': info.androidId,
      };
    } else {
      deviceData = {'Error': 'Failed to get plaform type.'};
    }

    return deviceData;
  }
}
