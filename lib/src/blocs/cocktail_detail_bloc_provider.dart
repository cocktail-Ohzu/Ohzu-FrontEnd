import 'package:flutter/material.dart';
import 'cocktail_detail_bloc.dart';
export 'cocktail_detail_bloc.dart';

class CocktailDetailBlocProvider extends InheritedWidget {
  final CocktailDetailBloc cocktailDetialBloc;

  CocktailDetailBlocProvider({Key? key, required Widget child})
      : cocktailDetialBloc = CocktailDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CocktailDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            CocktailDetailBlocProvider>() as CocktailDetailBlocProvider)
        .cocktailDetialBloc;
  }
}
