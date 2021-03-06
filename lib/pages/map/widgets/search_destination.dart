import 'package:flutter/material.dart';
import 'package:maps_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  SearchDestination() : this.searchFieldLabel = "Buscar...";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, SearchResult(cancel: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Build Result");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(children: [
      ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Colocar ubicación manuelamente"),
          onTap: () {
            print("Colocar ubicación manuelamente");
            this.close(context, SearchResult(cancel: false, manual: true));
          })
    ]);
  }
}
