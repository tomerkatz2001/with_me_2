import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import 'package:happy_heart/header.dart';

final places1 =
FlutterGooglePlacesSdk('AIzaSyABzVlQNCagC61ZcCeIp5r8TJsqbezOmF8');



class GMapsSearch extends StatefulWidget {
  const GMapsSearch({Key? key, this.text = '', this.onTap}) : super(key: key);

  final String text;
  final void Function(AddressLocation)? onTap;

  @override
  State<GMapsSearch> createState() => _GMapsSearch();
}

class _GMapsSearch extends State<GMapsSearch> {
  TextEditingController searchController = TextEditingController();

  // GeocodingResponse? possibleLocations;
  FindAutocompletePredictionsResponse? possibleLocations;

  @override
  Widget build(BuildContext context) {
    List locs = possibleLocations?.predictions ?? [];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Input(searchController, widget.text, onChanged: (x) async {
          possibleLocations = await places1.findAutocompletePredictions(x);
          setState(() {});
        }),
        ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            shrinkWrap: true,
            itemCount: locs.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(locs[index].fullText),
                onTap: () async {
                  var latLng = (await places1.fetchPlace(locs[index].placeId,
                      fields: [PlaceField.Location]))
                      .place
                      ?.latLng;
                  widget.onTap!(AddressLocation(locs[index].fullText,
                      latLng?.lat ?? 0, latLng?.lng ?? 0));
                  setState(() {
                    searchController.text = locs[index].fullText;
                  });
                },
              );
            }),
      ],
    );
  }
}
