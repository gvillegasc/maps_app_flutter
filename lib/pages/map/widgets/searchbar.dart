import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/search_bloc/search_bloc.dart';
import 'package:maps_app/models/search_result.dart';
import 'package:maps_app/pages/map/widgets/widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) {
          return Container();
        } else {
          return FadeIn(
              duration: Duration(milliseconds: 300),
              child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: 10,
      child: SafeArea(
        child: Container(
          width: screenSize.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () async {
              final SearchResult result = await showSearch(
                  context: context, delegate: SearchDestination());
              this.returnSeacher(context, result);
              print(result);
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

  void returnSeacher(BuildContext context, SearchResult result) {
    if (result.cancel) return;

    if (result.manual) {
      context.read<SearchBloc>().add(OnActiveManualMarker());
      return;
    }
  }
}
