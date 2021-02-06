# abema-weather 
The lib file (only) could be found here. There are some drawbacks:
* not supprting Amharic text input yet (Google's translation API wasn't of any use it repeatedly mistranslated and sometimes outright didnt recognize name of places in Amharic. Since the weather API needed flawless to get weather data, Google's API turned out to be a liability :( and it was difficult to implement manually.   ) 
* working on letting users submit their own openweather API keys instead of depending on readily given one (which drastically restricts usage). 
* Amharic names with space like ደብረ ማርቆስ needed careful translation since the API coudln not recognize them if written with a space (which is how virtually all amharic speaker spell them). This was overcome by using some expensive string manipulation. 
* inspired by https://github.com/Rajchowdhury420/Flutter-Weather/blob/master/lib/main.dart, though reimplemented and revamped wholly. 


![what the app looks like](https://github.com/abenezeraddisu/abema-weather/blob/main/video-1612614992.gif)
