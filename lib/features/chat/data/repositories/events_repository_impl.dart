import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/events_repository.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/mappers/event_mapper.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/core/domain/enums/profile_visibility.dart';

class EventsRepositoryImpl extends BaseRepository implements EventsRepository {
  final ChatRemoteDatasource _remoteDatasource;

  EventsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents({required int conversationId}) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.getEvents(conversationId: conversationId);

      final events = response.map((json) => EventDto.fromJson(json as Map<String, dynamic>).toEntity()).toList();

      return events;
    });
  }

  @override
  Future<Either<Failure, EventEntity>> createEvent({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.createEvent(
        conversationId: conversationId,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );

      // Response is a simplified event structure, convert to entity
      return _parseSimpleEventResponse(response as Map<String, dynamic>);
    });
  }

  @override
  Future<Either<Failure, EventEntity>> updateEvent({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.updateEvent(
        conversationId: conversationId,
        eventId: eventId,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );

      return _parseSimpleEventResponse(response as Map<String, dynamic>);
    });
  }

  @override
  Future<Either<Failure, EventEntity>> rsvpEvent({
    required int conversationId,
    required int eventId,
    required String status,
  }) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.rsvpEvent(
        conversationId: conversationId,
        eventId: eventId,
        status: status,
      );

      return _parseSimpleEventResponse(response as Map<String, dynamic>);
    });
  }

  /// Parse simplified event response from datasource to EventEntity
  EventEntity _parseSimpleEventResponse(Map<String, dynamic> json) {
    final going = (json['going'] as List?)?.cast<int>() ?? [];
    final maybe = (json['maybe'] as List?)?.cast<int>() ?? [];
    final notGoing = (json['notGoing'] as List?)?.cast<int>() ?? [];
    
    // Create minimal User for creator
    final creatorId = json['createdBy'] as int? ?? 0;
    final creator = User(
      id: creatorId,
      username: 'user$creatorId',
      email: '',
      emailVerified: false,
      fullName: 'User $creatorId',
      avatarUrl: null,
      bio: null,
      gender: null,
      dateOfBirth: null,
      location: null,
      profileVisibility: ProfileVisibility.public,
      lastSeen: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    return EventEntity(
      id: json['id'] as int,
      conversationId: json['conversationId'] as int,
      creator: creator,
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['createdAt'] as String),
      goingCount: going.length,
      maybeCount: maybe.length,
      notGoingCount: notGoing.length,
      currentUserRsvpStatus: null,
      rsvps: [],
    );
  }

  @override
  Future<Either<Failure, void>> deleteEvent({required int conversationId, required int eventId}) async {
    return executeApiCall(() async {
      await _remoteDatasource.deleteEvent(conversationId: conversationId, eventId: eventId);
    });
  }
}
