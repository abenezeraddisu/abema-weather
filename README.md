# abema-weather 
The lib file folder could be found here. There are some drawbacks:
* Not supprting Amharic text input yet (Google's translation API wasn't of any use; it repeatedly mistranslated and sometimes outright didn't recognize names of places in Amharic. Since the weather API needed flawless input to get weather data, Google's API turned out to be a liability :( and it was difficult to implement manually. Moving forward web scraping Ethiopian government websites to get the English spelling Ethiopian cities and places would be the way to go.) 

* Working on letting users submit their own openweather API keys instead of depending on a-readily given one (which drastically restricts usage). This would work by asking users to put the key into a textfield at the first launch of the application.

* Amharic names with space (" ") in between - like ደብረ ማርቆስ - need careful translation since the API could not recognize them if written with a space (which is how virtually all amharic speaker spell them). This was overcome by using some expensive string manipulation operation. A hashmap and list of these special names is provided. 

* for any other places, the app works like any other classic weather app. i.e., the app will check the input text (city name) is in Amharic first, and if it is not, it simply requests weather data. 
* Tigrigna should not be very different to implement. 

* Oromigna, on the other hand is much harder since the spelling is very tricky. Updates for both should be posted by the end of February. 

* inspired by https://github.com/Rajchowdhury420/Flutter-Weather/blob/master/lib/main.dart, though reimplemented and revamped wholly. 

*  the graph is hard to understand, particularily for folks this app is targeted for. Odds are, if a person is using this app to get weather data, they might not be very well versed and/or interested in weather data visualization. Highly considering truncating it. 
* PM and AM are still not in Amharic. They turned out to be quite tricky to translate since the weather API sends them as a "packet" along with the data. It should not  be hard to implement, however.
* Inspired with the work done here, I am making quite a progress on the currency tracker app. Update by the end of feb 2021. 



![what the app looks like](https://github.com/abenezeraddisu/abema-weather/blob/main/video-1612614992.gif)
