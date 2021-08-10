import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'data/bloc/rick_and_morty_bloc.dart';
import 'data/repository.dart';
import 'pages/episode_detail.dart';
import 'pages/home.dart';
import 'pages/location_detail.dart';
import 'pages/personage_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RickAndMortyBloc(repository: Repository()),
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: appTheme,
        onGenerateRoute: (settings) {
          if (settings.name == PersonageDetail.routeName) {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) {
                return PersonageDetail(
                  id: args['id'],
                  name: args['name'],
                );
              },
            );
          } else if (settings.name == LocationDetailPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return LocationDetailPage(
                  name: args,
                );
              },
            );
          } else if (settings.name == EpisodeDetailPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return EpisodeDetailPage(
                  name: args,
                );
              },
            );
          }
          return MaterialPageRoute(builder: (context) => HomePage());
        },
      ),
    );
  }
}
