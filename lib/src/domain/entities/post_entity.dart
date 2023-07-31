import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

/// A class representing a post entity
class PostEntity extends Equatable {
  /// The optional date of the last update of the post

  /// Constructor of the PostEntity class
  const PostEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.updatedAt,
  });

  /// A factory method to create a fake post entity using random data
  factory PostEntity.fake() {
    final f = Faker();
    final createdAt = f.date.dateTimeBetween(
      /// Minimum date (9000 days ago)
      DateTime.now().add(const Duration(days: -9000)),

      /// Maximum date (365 days ago)
      DateTime.now().add(const Duration(days: -365)),
    );
    final updatedAt = f.date.dateTimeBetween(
      createdAt,
      DateTime.now(),
    );

    /// Random update date between createdAt and now
    return PostEntity(
      id: f.guid.guid(),

      /// Random GUID for id
      title: f.lorem.sentence(),

      /// Random lorem sentence for title
      body: f.lorem.sentences(5).join(' '),

      /// Random 5 sentence paragraph for body
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// The id of the post
  final String id;

  /// The title of the post
  final String title;

  /// The body/content of the post
  final String body;

  /// The creation date of the post
  final DateTime createdAt;

  /// Override the "props" getter to define equality for PostEntity objects
  /// This is used by packages like "equatable" for equality checks.
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      body,
      createdAt,
      updatedAt,
    ];
  }
}
