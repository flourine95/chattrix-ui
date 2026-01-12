import 'package:chattrix_ui/features/chat/data/models/birthday_model.dart';
import 'package:chattrix_ui/features/chat/data/models/mutual_group_model.dart';
import 'package:chattrix_ui/features/chat/data/models/announcement_model.dart';
import 'package:chattrix_ui/features/chat/data/models/announcement_request.dart';

abstract class SocialDatasource {
  Future<List<BirthdayModel>> getBirthdaysToday();

  Future<SendBirthdayWishesResponse> sendBirthdayWishes({required SendBirthdayWishesRequest request});

  Future<AnnouncementModel> createAnnouncement({
    required int conversationId,
    required CreateAnnouncementRequest request,
  });

  Future<List<MutualGroupModel>> getMutualGroups({required int userId});
}
