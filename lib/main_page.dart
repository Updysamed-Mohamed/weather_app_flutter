import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class weather extends StatefulWidget {
  const weather({super.key});

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  Weather? weather;
  final openWeather = WeatherFactory('48d5372409241ae80acfbb50db0775d8');
  String cityname = '';

  getWea() async {
    try {
      weather = await openWeather.currentWeatherByCityName(cityname);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'This is Not A City Name',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color.fromARGB(255, 241, 8, 8), fontSize: 20),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text('Search By City Name .'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            child: TextField(
              style: TextStyle(
                  fontSize: 20.0, color: Color.fromARGB(255, 0, 0, 0)),
              onChanged: (value) {
                setState(() {
                  cityname = value;
                });
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => getWea(),
                      icon: Icon(Icons.search_outlined)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)),
                  hintText: 'Mogadisho',
                  hintStyle: TextStyle(
                      fontSize: 20.0, color: Color.fromARGB(255, 43, 43, 43)),
                  labelText: 'Enter Your City '),
            ),
          ),
        ),
        Expanded(
            child: weather != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather!.temperature!.celsius!.round()} °C',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        '${weather!.weatherDescription}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                : SizedBox())
      ]),
    );
  }
}
