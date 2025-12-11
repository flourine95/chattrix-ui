import 'package:freezed_annotation/freezed_annotation.dart';

enum ProfileVisibility {
  @JsonValue('PUBLIC')
  public,
  @JsonValue('FRIENDS_ONLY')
  friendsOnly,
  @JsonValue('PRIVATE')
  private;

  String get label {
    switch (this) {
      case ProfileVisibility.public:
        return 'Public';
      case ProfileVisibility.friendsOnly:
        return 'Friends Only';
      case ProfileVisibility.private:
        return 'Private';
    }
  }
}
