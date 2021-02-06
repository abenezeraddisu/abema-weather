import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/themes.dart';
import 'package:flutter_weather/src/utils/converters.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStateContainer.of(context).theme.primaryColor,
          title: Text("ማስተካከያዎች"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
          color: AppStateContainer.of(context).theme.primaryColor,
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ቀለም",
                style: TextStyle(
                  color: AppStateContainer.of(context).theme.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "የጨለማ",
                    style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
                  Radio(
                    value: Themes.DARK_THEME_CODE,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value);
                    },
                    activeColor:
                        AppStateContainer.of(context).theme.accentColor,
                  )
                ],
              ),
            ),
            Divider(
              color: AppStateContainer.of(context).theme.primaryColor,
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "የብርሃን",
                    style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
                  Radio(
                    value: Themes.LIGHT_THEME_CODE,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value);
                    },
                    activeColor:
                        AppStateContainer.of(context).theme.accentColor,
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
              child: Text(
                "አምድ",
                style: TextStyle(
                  color: AppStateContainer.of(context).theme.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ሴልሺየስ",
                    style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
                  Radio(
                    value: TemperatureUnit.celsius.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context)
                          .updateTemperatureUnit(TemperatureUnit.values[value]);
                    },
                    activeColor:
                        AppStateContainer.of(context).theme.accentColor,
                  )
                ],
              ),
            ),
            Divider(
              color: AppStateContainer.of(context).theme.primaryColor,
              height: 1,
            ),
            Container(
              color: AppStateContainer.of(context)
                  .theme
                  .accentColor
                  .withOpacity(0.1),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ፋራናይት",
                    style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
                  Radio(
                    value: TemperatureUnit.fahrenheit.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context)
                          .updateTemperatureUnit(TemperatureUnit.values[value]);
                    },
                    activeColor:
                        AppStateContainer.of(context).theme.accentColor,
                  )
                ],
              ),
            ),
            Divider(
              color: AppStateContainer.of(context).theme.primaryColor,
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ኬልቪን",
                    style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
                  Radio(
                    value: TemperatureUnit.kelvin.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context)
                          .updateTemperatureUnit(TemperatureUnit.values[value]);
                    },
                    activeColor:
                        AppStateContainer.of(context).theme.accentColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ያግኙን",
                style: TextStyle(
                  color: AppStateContainer.of(context).theme.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Linkify(
              onOpen: _onOpen,
              text:
                  "የሚከተለውን ማስፈንጠሪያ በመጫን ቴሌግራም ላይ ያግኙን፡ https://t.me/suggestion_box_afrotech",
              style: TextStyle(color: Colors.blue),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 220,
                  ),
                  ColorizeAnimatedTextKit(
                    repeatForever: true,
                    text: ['Abenezer G.'],
                    textStyle: TextStyle(fontSize: 13.0, fontFamily: "Horizon"),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'በድጋሚ ይሞክሩ። $link';
    }
  }
}
