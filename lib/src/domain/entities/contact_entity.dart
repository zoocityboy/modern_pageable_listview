// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

class ContactEntity with EquatableMixin {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  ContactEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
  factory ContactEntity.fake() {
    final faker = Faker();
    return ContactEntity(
      id: faker.guid.guid(),
      name: faker.person.name(),
      email: faker.internet.email(),
      avatarUrl: faker.image.image(
        height: 120,
        keywords: [
          'people',
          'avatar',
        ],
        random: true,
      ),
    );
  }

  @override
  List<Object> get props => [id, name, email, avatarUrl];
}
