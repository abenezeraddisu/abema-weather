import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/api/weather_api_client.dart';
import 'package:flutter_weather/src/bloc/weather_bloc.dart';
import 'package:flutter_weather/src/bloc/weather_event.dart';
import 'package:flutter_weather/src/bloc/weather_state.dart';
import 'package:flutter_weather/src/repository/weather_repository.dart';
import 'package:flutter_weather/src/api/api_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/src/widgets/weather_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

enum OptionsMenu { changeCity, settings }

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  String _cityName = 'ደብረ ማርቆስ';
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;
  bool isSeen = false;

  @override
  void initState() {
    super.initState();
    weatherBlocCaller();
  }

  void weatherBlocCaller() {
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStateContainer.of(context).theme.primaryColor,
        elevation: 10,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              DateFormat.jm()
                  .format(DateTime.now().subtract(new Duration(hours: 0))),
              style: TextStyle(
                  color: AppStateContainer.of(context)
                      .theme
                      .accentColor
                      .withAlpha(80),
                  fontSize: 14),
            ),
            RotateAnimatedTextKit(
                repeatForever: true,
                text: ['አብማ', "የአየር ፀባይ ", "መመልከቻ"],
                textStyle: TextStyle(fontSize: 12.0, fontFamily: "Horizon"),
                textAlign: TextAlign.start),
          ],
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: [
                  const Color(0xffee0000),
                  const Color(0xffeeee00)
                ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: PopupMenuButton<OptionsMenu>(
                color: Colors.lightBlueAccent,
                child: Icon(
                  Icons.more_vert,
                  color: AppStateContainer.of(context).theme.accentColor,
                ),
                onSelected: this._onOptionMenuItemSelected,
                itemBuilder: (context) => <PopupMenuEntry<OptionsMenu>>[
                      PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.changeCity,
                        child: Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(
                                "ሌላ ቦታ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.settings,
                        child: Row(
                          children: [
                            Icon(Icons.settings),
                            Text(
                              "ማስተካከያዎች",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ]),
          )
        ],
      ),
      backgroundColor: AppStateContainer.of(context).theme.primaryColor,
      body: SingleChildScrollView(
        child: Material(
          child: Container(
            // constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                color: AppStateContainer.of(context).theme.primaryColor),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: BlocBuilder(
                  bloc: _weatherBloc,
                  // ignore: missing_return
                  builder: (_, WeatherState weatherState) {
                    if (weatherState is WeatherLoaded) {
                      this._cityName = weatherState.weather.cityName;
                      print(weatherState.weather.cityName);
                      _fadeController.reset();
                      _fadeController.forward();
                      return WeatherWidget(
                        weather: weatherState.weather,
                      );
                    } else if (weatherState is WeatherError ||
                        weatherState is WeatherEmpty) {
                      String errorText =
                          'ይቅርታ! የአየር ፀባዩን ማወቅ አልቻልንም፤ እባክዎ ደግመው ይሞክሩ።';
                      if (weatherState is WeatherError) {
                        if (weatherState.errorCode == 404) {
                          errorText =
                              'ይቅርታ! እባክዎ የ$_cityName አየር ፀባይ ለማወቅ በድጋሚ ይሞክሩ።';
                        }
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Text(
                            errorText,
                            style: TextStyle(
                                color: AppStateContainer.of(context)
                                    .theme
                                    .accentColor),
                          ),
                          FlatButton(
                            child: Text(
                              "በድጋሚ ይሞክሩ።",
                              style: TextStyle(
                                  color: AppStateContainer.of(context)
                                      .theme
                                      .accentColor),
                            ),
                            onPressed: _fetchWeatherWithCity,
                          )
                        ],
                      );
                    } else if (weatherState is WeatherLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor:
                              AppStateContainer.of(context).theme.primaryColor,
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('ሌላ ቦታ ፈልግ', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'ፈልግ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onPressed: () {
                  _fetchWeatherWithCity();
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: TextField(
              autofocus: true,
              onChanged: (text) {
                _cityName = text;
              },
              decoration: InputDecoration(
                  hintText: 'የቦታ ስም በእንግሊዝኛ',
                  hintStyle: TextStyle(color: Colors.black12),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _fetchWeatherWithLocation().catchError((error) {
                        _fetchWeatherWithCity();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.my_location_sharp,
                      color: Colors.deepOrangeAccent,
                      size: 16,
                    ),
                  )),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          );
        });
  }

  _onOptionMenuItemSelected(OptionsMenu item) {
    switch (item) {
      case OptionsMenu.changeCity:
        this._showCityChangeDialog();
        break;
      case OptionsMenu.settings:
        Navigator.of(context).pushNamed("/settings");
        break;
    }
  }

  _fetchWeatherWithCity() {
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }

  _fetchWeatherWithLocation() async {
    var permissionHandler = PermissionHandler();
    var permissionResult = await permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);

    switch (permissionResult[PermissionGroup.locationWhenInUse]) {
      case PermissionStatus.denied:
      case PermissionStatus.unknown:
        print('ያሉበትን ቦታ ማወቅ አልቻልንም። እንድናውቅ ይፍቀዱልን። ');
        _showLocationDeniedDialog(permissionHandler);
        throw Error();
    }

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    _weatherBloc.dispatch(FetchWeather(
        longitude: position.longitude, latitude: position.latitude));
  }

  void _showLocationDeniedDialog(PermissionHandler permissionHandler) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('ያሉበትን ቦታ እንድናውቅ ይፍቀዱልን።',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'ያሉበትን ቦታ ማወቅ አልቻልንም። እንድናውቅ ይፍቀዱልን!',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                onPressed: () {
                  permissionHandler.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
