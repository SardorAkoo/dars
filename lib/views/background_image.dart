import 'package:dars/utils/app.dart';
import 'package:flutter/material.dart';


class BackgroundImgPicker extends StatefulWidget {
  const BackgroundImgPicker({super.key});

  @override
  State<BackgroundImgPicker> createState() => _BackgroundImgPickerState();
}

class _BackgroundImgPickerState extends State<BackgroundImgPicker> {
  String oldImg = AppConstants.backgroundImg.toString();
  TextEditingController pickerImg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        leading: IconButton(
          onPressed: () {
            if (oldImg == AppConstants.backgroundImg.toString()) {
              Navigator.of(context).pop(false);
            } else {
              Navigator.of(context).pop(true);
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Scaffold uchun surat tanlash",
          style: TextStyle(
              fontSize: AppConstants.wordSize.toDouble(),
              color: AppConstants.wordsColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: AppConstants.backgroundImg == null
                ? null
                : DecorationImage(
                    image: NetworkImage('${AppConstants.backgroundImg}'))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: pickerImg,
                decoration: InputDecoration(
                    hintText: 'Surat linkini shu yerga joylash',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        AppConstants.backgroundImg = pickerImg.text;
                        setState(() {});
                      },
                      icon: Icon(Icons.save),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
