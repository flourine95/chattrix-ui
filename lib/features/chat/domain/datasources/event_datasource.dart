import 'package:chattrix_ui/features/chat/data/models/event_model.dart';

abstract class EventDatasource {
  Future<EventModel> createEvent({required int conversationId, required CreateEventRequest request});

  Future<EventModel> updateEvent({
    required int conversationId,
    required int eventId,
    required UpdateEventRequest request,
  });

  Future<String> deleteEvent({required int conversationId, required int eventId});

  Future<EventModel> rsvpEvent({required int conversationId, required int eventId, required RsvpEventRequest request});

  Future<EventModel> getEventDetails({required int conversationId, required int eventId});

  Future<List<EventModel>> getAllEvents({required int conversationId});
}
