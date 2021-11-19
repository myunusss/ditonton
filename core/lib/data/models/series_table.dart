import 'package:equatable/equatable.dart';

class SeriesTableCore extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  SeriesTableCore({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
