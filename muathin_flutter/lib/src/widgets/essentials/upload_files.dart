import 'dart:io';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';

class UploadFiles extends StatefulWidget {
  final List<File> images;
  final Function(File) onAdd;

  UploadFiles({this.images, this.onAdd});

  @override
  _UploadFilesState createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Container(
      height: 200.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.images.length < 1 ? widget.images.length + 1 : widget.images.length,
          itemBuilder: (context, index) {
            if (widget.images.length == index) {
              return GestureDetector(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    width: deviceSize.width - 50,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: Config.sColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        image: DecorationImage(
                          image: AssetImage(Config.pathUploadPhoto),
                          fit: BoxFit.scaleDown,
                        ))),
                onTap: () {
                  Functions.addPhoto(
                      context: context,
                      onSuccess: (file) {
                        setState(() {
                          widget.images.add(file);
                        });
                      });
                },
              );
            } else {
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 25.0),
                  width: deviceSize.width - 50,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(image: FileImage(widget.images[index]), fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  setState(() {
                    widget.images.removeAt(index);
                  });
                },
              );
            }
          }),
    );
  }
}
