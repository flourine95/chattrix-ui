import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

class GetContactsUseCase {
  final ContactRepository repository;

  GetContactsUseCase(this.repository);

  Future<Either<Failure, List<Contact>>> call() {
    return repository.getContacts();
  }
}
