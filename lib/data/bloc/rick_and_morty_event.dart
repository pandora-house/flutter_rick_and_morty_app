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

class LocationsFetchFirstPage extends RickAndMortyEvent {}

class LocationsFetchNewPage extends RickAndMortyEvent {}
