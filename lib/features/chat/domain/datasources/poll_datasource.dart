import 'package:chattrix_ui/features/chat/data/models/poll_model.dart';

abstract class PollDatasource {
  Future<PollModel> createPoll({required int conversationId, required CreatePollRequest request});

  Future<PollModel> votePoll({required int conversationId, required int pollId, required VotePollRequest request});

  Future<PollModel> removeVote({required int conversationId, required int pollId, required RemoveVoteRequest request});

  Future<PollModel> closePoll({required int conversationId, required int pollId});

  Future<String> deletePoll({required int conversationId, required int pollId});

  Future<PollModel> getPollDetails({required int conversationId, required int pollId});

  Future<List<PollModel>> getAllPolls({required int conversationId});
}
