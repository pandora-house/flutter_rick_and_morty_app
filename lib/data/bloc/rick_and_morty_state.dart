part of 'rick_and_morty_bloc.dart';

@immutable
abstract class RickAndMortyState extends Equatable {
  const RickAndMortyState();

  @override
  List<Object?> get props => [];
}

// page characters
class CharactersInitial extends RickAndMortyState {}

class CharactersIsLoading extends RickAndMortyState {}

class CharactersFetched extends RickAndMortyState {
  final List<Character> list;

  const CharactersFetched({required this.list});

  @override
  List<Object?> get props => [list];
}

class CharactersError extends RickAndMortyState {}

class CharactersNewPageError extends RickAndMortyState {}

// page personage
class PersonageIsLoading extends RickAndMortyState {}

class PersonageFetched extends RickAndMortyState {
  final Character personage;

  const PersonageFetched({required this.personage});

  @override
  List<Object?> get props => [personage];
}

class PersonageError extends RickAndMortyState {}

// page episodes
class EpisodesIsLoading extends RickAndMortyState {}

class EpisodesFetched extends RickAndMortyState {
  final List<Episode> list;

  const EpisodesFetched({required this.list});

  @override
  List<Object?> get props => [list];
}

class EpisodesError extends RickAndMortyState {}

class EpisodesNewPageError extends RickAndMortyState {}

// page locations
class LocationsIsLoading extends RickAndMortyState {}

class LocationsFetched extends RickAndMortyState {
  final List<Locations> list;

  const LocationsFetched({required this.list});

  @override
  List<Object?> get props => [list];
}

class LocationsError extends RickAndMortyState {}

class LocationsNewPageError extends RickAndMortyState {}

// page location detail
class LocationIsLoading extends RickAndMortyState {}

class LocationFetched extends RickAndMortyState {
  final Locations item;
  final List<Character> residents;
  const LocationFetched({required this.item, required this.residents});

  @override
  List<Object?> get props => [item, residents];
}

class LocationError extends RickAndMortyState {}
