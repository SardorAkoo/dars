import 'package:dars/utils/app.dart';
import 'package:dars/views/background_image.dart';
import 'package:dars/views/backround.dart';
import 'package:dars/views/world.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPreferences;
  bool isNight = false;
  TextEditingController wordsSize = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: AppConstants.themeMode,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppConstants.backgroundColor,
          title: Text(
            'Sozlamalar',
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
                    image: NetworkImage('${AppConstants.backgroundImg}')),
          ),
          child: Column(
            children: [
              SwitchListTile(
                  title: Text(
                    "Tungi holat",
                    style: TextStyle(
                        fontSize: AppConstants.wordSize.toDouble(),
                        color: AppConstants.wordsColor),
                  ),
                  value: isNight,
                  onChanged: (value) async {
                    if (value) {
                      isNight = true;
                      AppConstants.themeMode = ThemeMode.dark;
                      await sharedPreferences.setString('theme', 'dark');
                    } else {
                      isNight = false;
                      AppConstants.themeMode = ThemeMode.light;
                      await sharedPreferences.setString('theme', 'light');
                    }
                    setState(() {});
                  }),
              SizedBox(
                height: 50,
              ),
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () async {
                      bool data = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BackgroundColorPicker()));
                      if (data) {
                        sharedPreferences.setString('backgroundColor',
                            AppConstants.backgroundColor.toString());
                        setState(() {});
                      }
                    },
                    icon: Text(
                      'Backgorun found color',
                      style: TextStyle(
                          fontSize: AppConstants.wordSize.toDouble(),
                          color: AppConstants.wordsColor),
                    ));
              }),
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () async {
                      bool data = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => WordsColorPicker()));
                      if (data) {
                        sharedPreferences.setString(
                            'wordsColor', AppConstants.wordsColor.toString());
                        setState(() {});
                      }
                    },
                    icon: Text(
                      'Sozlar uchun rang tanlash',
                      style: TextStyle(
                          fontSize: AppConstants.wordSize.toDouble(),
                          color: AppConstants.wordsColor),
                    ));
              }),
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () async {
                      bool data = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BackgroundImgPicker()));
                      if (data) {
                        sharedPreferences.setString('backgroundImg',
                            AppConstants.backgroundImg.toString());
                        setState(() {});
                      }
                    },
                    icon: Text(
                      "Background uchun surat tanlash",
                      style: TextStyle(
                          fontSize: AppConstants.wordSize.toDouble(),
                          color: AppConstants.wordsColor),
                    ));
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: wordsSize,
                    validator: (value) {
                      if (value == null) {
                        return 'Ilitmos qiymatni togri kiriting';
                      }
                      try {
                        double size = double.parse(value);
                      } catch (e) {
                        return 'Iltimos sozlarnin kattaligini sonlar bilan kiritng';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Sozlar uchun kattalik tanlash',
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppConstants.wordSize =
                                  double.parse(wordsSize.text);
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.save),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
