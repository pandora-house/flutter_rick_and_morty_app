import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/character.dart';
import '../models/episode.dart';
import '../models/locations.dart';
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
    } else if (event is EpisodeFetchByUrl) {
      yield* _mapEpisodeFetchByUrl(event);
    } else if (event is EpisodeFetchById) {
      yield* _mapEpisodeFetchById(event);
    } else if (event is LocationFetchByUrl) {
      yield* _mapLocationFetchByUrl(event);
    } else if (event is LocationFetchById) {
      yield* _mapLocationFetchById(event);
    }
  }

  Stream<RickAndMortyState> _mapCharactersFetchFirstPage() async* {
    yield CharactersIsLoading();
    try {
      final characters = await repository.fetchCharacters(1);
      yield CharactersFetched(list: characters);
    } on Exception catch (_) {
      yield CharactersError();
    }
  }

  Stream<RickAndMortyState> _mapCharactersFetchNewPage() async* {
    pageCharactersCounter += 1;
    try {
      final characters =
          await repository.fetchCharacters(pageCharactersCounter);
      yield CharactersFetched(list: characters);
    } on Exception catch (_) {
      pageCharactersCounter = 1;
      yield CharactersNewPageError();
    }
  }

  Stream<RickAndMortyState> _mapPersonageFetch(PersonageFetch event) async* {
    yield PersonageIsLoading();
    try {
      final personage = await repository.fetchPersonageById(event.id);
      yield PersonageFetched(personage: personage);
    } on Exception catch (_) {
      yield PersonageError();
    }
  }

  Stream<RickAndMortyState> _mapEpisodeFetchFirstPage() async* {
    yield EpisodesIsLoading();
    try {
      final episodes = await repository.fetchEpisodesPage(1);
      yield EpisodesFetched(list: episodes);
    } on Exception catch (_) {
      yield EpisodesError();
    }
  }

  Stream<RickAndMortyState> _mapEpisodesFetchNewPage() async* {
    pageEpisodesCounter += 1;
    try {
      final episodes = await repository.fetchEpisodesPage(pageEpisodesCounter);
      yield EpisodesFetched(list: episodes);
    } on Exception catch (_) {
      pageEpisodesCounter = 1;
      yield EpisodesNewPageError();
    }
  }

  Stream<RickAndMortyState> _mapLocationFetchFirstPage() async* {
    yield LocationsIsLoading();
    try {
      final locations = await repository.fetchLocationsPage(1);
      yield LocationsFetched(list: locations);
    } on Exception catch (_) {
      yield LocationsError();
    }
  }

  Stream<RickAndMortyState> _mapLocationsFetchNewPage() async* {
    pageLocationsCounter += 1;
    try {
      final locations =
          await repository.fetchLocationsPage(pageLocationsCounter);
      yield LocationsFetched(list: locations);
    } on Exception catch (_) {
      pageLocationsCounter = 1;
      yield LocationsNewPageError();
    }
  }

  Stream<RickAndMortyState> _mapEpisodeFetchById(
      EpisodeFetchById event) async* {
    yield EpisodeIsLoading();
    try {
      final episode = await repository.fetchEpisodeById(event.id);
      final characters = await _getCharacters(episode, repository);

      yield EpisodeFetched(item: episode, characters: characters);
    } on Exception catch (_) {
      yield EpisodeError();
    }
  }

  Stream<RickAndMortyState> _mapEpisodeFetchByUrl(
      EpisodeFetchByUrl event) async* {
    yield EpisodeIsLoading();
    try {
      final episode = await repository.fetchEpisodeByUrl(event.url);
      final characters = await _getCharacters(episode, repository);

      yield EpisodeFetched(item: episode, characters: characters);
    } on Exception catch (_) {
      yield EpisodeError();
    }
  }

  Stream<RickAndMortyState> _mapLocationFetchById(
      LocationFetchById event) async* {
    yield LocationIsLoading();
    try {
      final location = await repository.fetchLocationById(event.id);
      final residents = await _getResidents(location, repository);

      yield LocationFetched(item: location, residents: residents);
    } on Exception catch (_) {
      yield LocationError();
    }
  }

  Stream<RickAndMortyState> _mapLocationFetchByUrl(
      LocationFetchByUrl event) async* {
    yield LocationIsLoading();
    try {
      final location = await repository.fetchLocationByUrl(event.url);
      final residents = await _getResidents(location, repository);

      yield LocationFetched(item: location, residents: residents);
    } on Exception catch (_) {
      yield LocationError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

Future<List<Character>> _getResidents(
    Locations location, Repository repository) async {
  return await Future.wait([
    for (var url in location.residents!) repository.fetchPersonageByUrl(url)
  ]);
}

Future<List<Character>> _getCharacters(
    Episode episode, Repository repository) async {
  return await Future.wait([
    for (var url in episode.characters!) repository.fetchPersonageByUrl(url)
  ]);
}
