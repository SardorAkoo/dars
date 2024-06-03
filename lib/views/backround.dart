import 'package:dars/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class BackgroundColorPicker extends StatefulWidget {
  const BackgroundColorPicker({super.key});

  @override
  State<BackgroundColorPicker> createState() => _BackgroundColorPickerState();
}

class _BackgroundColorPickerState extends State<BackgroundColorPicker> {
  Color oldColor = AppConstants.backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (oldColor == AppConstants.backgroundColor) {
                Navigator.of(context).pop(false);
              } else {
                Navigator.of(context).pop(true);
              }
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: AppConstants.backgroundColor,
        title: Text(
          "Background uchun rang tanlash",
          style: TextStyle(
              fontSize: AppConstants.wordSize.toDouble(),
              color: AppConstants.wordsColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: AppConstants.backgroundImg == null
                ? null
                : DecorationImage(
                    image: NetworkImage("${AppConstants.backgroundImg}"))),
        child: Column(
          children: [
            ColorPicker(
                pickerColor: AppConstants.backgroundColor,
                onColorChanged: (value) {
                  AppConstants.backgroundColor = value;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
