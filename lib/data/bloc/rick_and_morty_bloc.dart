import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty_app/data/models/locations.dart';
import 'package:meta/meta.dart';

import '../models/character.dart';
import '../models/episode.dart';
import '../repository.dart';

part 'rick_and_morty_event.dart';

part 'rick_and_morty_state.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  final Repository repository;

  RickAndMortyBloc({required this.repository}) : super(CharactersInitial());

  int pageCharactersCounter = 1;
  int pageEpisodesCounter = 1;
  int pageLocationsCounter = 1;

  @override
  Stream<RickAndMortyState> mapEventToState(
    RickAndMortyEvent event,
  ) async* {
    if (event is CharactersFetchFirstPage) {
      yield* _mapCharactersFetchFirstPage();
    } else if (event is CharactersFetchNewPage) {
      yield* _mapCharactersFetchNewPage();
    } else if (event is PersonageFetch) {
      yield* _mapPersonageFetch(event);
    } else if (event is EpisodesFetchFirstPage) {
      yield* _mapEpisodeFetchFirstPage();
    } else if (event is EpisodesFetchNewPage) {
      yield* _mapEpisodesFetchNewPage();
    } else if (event is LocationsFetchFirstPage) {
      yield* _mapLocationFetchFirstPage();
    } else if (event is LocationsFetchNewPage) {
      yield* _mapLocationsFetchNewPage();
    }
  }

  Stream<RickAndMortyState> _mapCharactersFetchFirstPage() async* {
    yield CharactersIsLoading();
    try {
      final characters =
          await repository.fetchCharacters(pageCharactersCounter);
      yield CharactersFetched(list: characters);
    } on Exception catch (e) {
      yield CharactersError();
    }
  }

  Stream<RickAndMortyState> _mapCharactersFetchNewPage() async* {
    pageCharactersCounter += 1;
    try {
      final characters =
          await repository.fetchCharacters(pageCharactersCounter);
      yield CharactersFetched(list: characters);
    } on Exception catch (e) {
      yield CharactersNewPageError();
    }
  }

  Stream<RickAndMortyState> _mapPersonageFetch(PersonageFetch event) async* {
    yield PersonageIsLoading();
    try {
      final personage = await repository.fetchPersonage(event.id);
      yield PersonageFetched(personage: personage);
    } on Exception catch (e) {
      yield PersonageError();
    }
  }

  Stream<RickAndMortyState> _mapEpisodeFetchFirstPage() async* {
    yield EpisodesIsLoading();
    try {
      final episodes = await repository.fetchEpisodesPage(pageEpisodesCounter);
      yield EpisodesFetched(list: episodes);
    } on Exception catch (e) {
      yield EpisodesError();
    }
  }

  Stream<RickAndMortyState> _mapEpisodesFetchNewPage() async* {
    pageEpisodesCounter += 1;
    try {
      final episodes = await repository.fetchEpisodesPage(pageEpisodesCounter);
      yield EpisodesFetched(list: episodes);
    } on Exception catch (e) {
      yield EpisodesNewPageError();
    }
  }

  Stream<RickAndMortyState> _mapLocationFetchFirstPage() async* {
    yield LocationsIsLoading();
    try {
      final locations =
          await repository.fetchLocationsPage(pageLocationsCounter);
      yield LocationsFetched(list: locations);
    } on Exception catch (e) {
      yield LocationsError();
    }
  }

  Stream<RickAndMortyState> _mapLocationsFetchNewPage() async* {
    pageLocationsCounter += 1;
    try {
      final locations =
          await repository.fetchLocationsPage(pageLocationsCounter);
      yield LocationsFetched(list: locations);
    } on Exception catch (e) {
      yield LocationsNewPageError();
    }
  }
}
