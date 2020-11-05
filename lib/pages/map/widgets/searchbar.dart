import 'package:flutter/material.dart';
import 'package:maps_app/models/search_result.dart';
import 'package:maps_app/pages/map/widgets/widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: 10,
      child: SafeArea(
        child: Container(
          width: screenSize.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () async {
              final SearchResult resultado = await showSearch(
                  context: context, delegate: SearchDestination());
              this.returnSeacher(resultado);
              print(resultado);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              width: double.infinity,
              child: Text(
                "¿Dónde quieres ir?",
                style: TextStyle(color: Colors.black87),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void returnSeacher(SearchResult result) {
    print(result.cancel);
    print(result.manual);
    if (result.cancel) return;
  }
}
