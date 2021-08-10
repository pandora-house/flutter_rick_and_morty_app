part of 'rick_and_morty_bloc.dart';

@immutable
abstract class RickAndMortyEvent extends Equatable {
  const RickAndMortyEvent();

  @override
  List<Object?> get props => [];
}

class CharactersFetchFirstPage extends RickAndMortyEvent {}

class CharactersFetchNewPage extends RickAndMortyEvent {}

class PersonageFetch extends RickAndMortyEvent {
  final int id;

  const PersonageFetch({required this.id});

  @override
  List<Object?> get props => [id];
}

class EpisodesFetchFirstPage extends RickAndMortyEvent {}

class EpisodesFetchNewPage extends RickAndMortyEvent {}

class EpisodeFetchById extends RickAndMortyEvent {
  final int id;

  const EpisodeFetchById({required this.id});

  @override
  List<Object?> get props => [id];
}

class EpisodeFetchByUrl extends RickAndMortyEvent {
  final String url;

  const EpisodeFetchByUrl({required this.url});

  @override
  List<Object?> get props => [url];
}

class LocationsFetchFirstPage extends RickAndMortyEvent {}

class LocationsFetchNewPage extends RickAndMortyEvent {}

class LocationFetchById extends RickAndMortyEvent {
  final int id;

  const LocationFetchById({required this.id});

  @override
  List<Object?> get props => [id];
}

class LocationFetchByUrl extends RickAndMortyEvent {
  final String url;

  const LocationFetchByUrl({required this.url});

  @override
  List<Object?> get props => [url];
}
