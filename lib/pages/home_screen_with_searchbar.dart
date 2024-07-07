import 'package:flutter/material.dart';
import 'package:weather_app/services/network.dart';
import 'package:weather_app/pages/weather_details_screen.dart';
import '../models/autocomplete_prediction_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Prediction> predictionList = [];
  TextEditingController searchController = TextEditingController();
  Set<Prediction> pastSearch = {};

  void placeAutoComplete(String query) async {
    String? response = await getAutoCompleteData(query: query);
    if (response != null) {
      AutocompletePrediction autocompletePrediction =
      autocompletePredictionFromJson(response);
      if (autocompletePrediction.predictions != null) {
        setState(() {
          predictionList = autocompletePrediction.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              buildSearchBar(),
              Expanded(child: buildPredictionList())
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 1,
      leading: const Icon(Icons.menu),
      title: const Text("Weather App"),
      actions: const [
        Icon(Icons.info_outline),
        SizedBox(width: 10)
      ],
    );
  }

  Widget buildSearchBar() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: searchController,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black),
          ),
          hintText: "Search for a location",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchController.text.isEmpty
              ? null
              : IconButton(
            icon: const Icon(Icons.cancel_sharp),
            onPressed: () {
              setState(() {
                searchController.clear();
                predictionList.clear();
              });
            },
          ),
        ),
        onChanged: (query) {
          placeAutoComplete(query);
        },
      ),
    );
  }

  Widget buildPredictionList() {
    return ListView.builder(
      itemCount: searchController.text.isEmpty ? pastSearch.length : predictionList.length,
      itemBuilder: (context, index) {
        var prediction = searchController.text.isEmpty
            ? pastSearch.elementAt(index)
            : predictionList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WeatherDetailScreen(prediction: prediction),
              ),
            );
            setState(() {
              pastSearch.add(prediction);
            });
          },
          child: ListTile(
            leading: Icon(searchController.text.isEmpty
                ? Icons.access_time_outlined
                : Icons.location_pin),
            title: Text(prediction.structuredFormatting.mainText),
            subtitle: prediction.structuredFormatting.secondaryText != null
                ? Text(prediction.structuredFormatting.secondaryText!)
                : null,
            trailing: const Icon(Icons.call_made_outlined),
          ),
        );
      },
    );
  }
}
