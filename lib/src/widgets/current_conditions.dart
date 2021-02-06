import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;

  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: AppStateContainer.of(context).theme.accentColor,
          size: 70,
        ),
        SizedBox(
          height: 100,
          child: ScaleAnimatedTextKit(
            stopPauseOnTap: true,
            repeatForever: true,
            text: [
              '${this.weather.temperature.as(AppStateContainer.of(context).temperatureUnit).round()}°',
            ],
            textStyle: TextStyle(
                color: Colors.lightBlue,
                fontSize: 80.0,
                fontFamily: "Canterbury"),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("ዛሬ ከፍተኛ",
              '${this.weather.maxTemperature.as(AppStateContainer.of(context).temperatureUnit).round()}°'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color:
                  AppStateContainer.of(context).theme.accentColor.withAlpha(50),
            )),
          ),
          ValueTile("ዛሬ ዝቅተኛ",
              '${this.weather.minTemperature.as(AppStateContainer.of(context).temperatureUnit).round()}°'),
        ]),
      ],
    );
  }
}
