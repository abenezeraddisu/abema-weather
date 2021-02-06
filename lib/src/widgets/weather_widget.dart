import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/forecast_horizontal_widget.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:flutter_weather/src/widgets/weather_swipe_pager.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_weather/src/utils/city_names.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({this.weather}) : assert(weather != null);
  final bool animated = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: weather.cityName.toString().toLowerCase() != 'addis ababa'
              ? RotateAnimatedTextKit(
                  repeatForever: true,
                  text: [
                    amharicCityNameProvider(
                        weather.cityName.toString().toLowerCase())
                  ],
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 5,
                      color: AppStateContainer.of(context).theme.accentColor,
                      fontSize: 25),
                  textAlign: TextAlign.start)
              : Center(
                  child: Text(
                    "አዲስ አበባ",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 5,
                        color: AppStateContainer.of(context).theme.accentColor,
                        fontSize: 25),
                  ),
                ), //for some weird reason 'addis ababa' fails the null!= text assertion so i hardcoded it to check for addis ababa
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          amharicWeatherConditionProvider(this.weather.description), //==
          //'OVERCAST CLOUDS'
          //? 'ከመጠን በላይ ደመናዎች'
          //: amharicWeatherConditionProvider(this.weather.description),
          style: TextStyle(
              fontWeight: FontWeight.w100,
              letterSpacing: 5,
              fontSize: 15,
              color: AppStateContainer.of(context).theme.accentColor),
        ),
        WeatherSwipePager(weather: weather),
        Padding(
          child: Divider(
            color:
                AppStateContainer.of(context).theme.accentColor.withAlpha(50),
          ),
          padding: EdgeInsets.all(10),
        ),
        ForecastHorizontal(weathers: weather.forecast),
        Padding(
          child: Divider(
            color:
                AppStateContainer.of(context).theme.accentColor.withAlpha(50),
          ),
          padding: EdgeInsets.all(10),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueTile("የንፋስ ፍጥነት", '${this.weather.windSpeed} ሜ/ሰከንድ'),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    width: 1,
                    height: 30,
                    color: AppStateContainer.of(context)
                        .theme
                        .accentColor
                        .withAlpha(50),
                  )),
                ),
                ValueTile(
                    "ፀሐይ መውጫ",
                    DateFormat('h:m a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            this.weather.sunrise * 1000))),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    width: 1,
                    height: 30,
                    color: AppStateContainer.of(context)
                        .theme
                        .accentColor
                        .withAlpha(50),
                  )),
                ),
                ValueTile(
                    "ፀሐይ መግቢያ",
                    DateFormat('h:m a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            this.weather.sunset * 1000))),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    width: 1,
                    height: 30,
                    color: AppStateContainer.of(context)
                        .theme
                        .accentColor
                        .withAlpha(50),
                  )),
                ),
                ValueTile("እርጥበት", '${this.weather.humidity}%'),
              ]),
        ),
      ],
    );
  }
}
