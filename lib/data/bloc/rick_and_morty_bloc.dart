import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty_app/data/models/episode.dart';
import 'package:meta/meta.dart';

import '../models/character.dart';
import '../repository.dart';

part 'rick_and_morty_event.dart';

part 'rick_and_morty_state.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  final Repository repository;

  RickAndMortyBloc({required this.repository}) : super(CharactersInitial());

  int pageCharactersCounter = 1;
  int pageEpisodesCounter = 1;

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
    } else if (event is EpisodeFetchFirstPage) {
      yield* _mapEpisodeFetchFirstPage();
    }
  }

  Stream<RickAndMortyState> _mapCharactersFetchFirstPage() async* {
    yield CharactersIsLoading();
    try {
      final characters = await repository.fetchCharacters(pageCharactersCounter);
      yield CharactersFetched(list: characters);
    } on Exception catch (e) {
      yield CharactersError();
    }
  }

  Stream<RickAndMortyState> _mapCharactersFetchNewPage() async* {
    pageCharactersCounter += 1;
    try {
      final characters = await repository.fetchCharacters(pageCharactersCounter);
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
}
