class UserModeModel {
  final String userId;
  final String userType; // 'doctor' or 'patient'
  final bool isOnline;
  final DateTime lastSeen;
  final String? currentLocation;
  final Map<String, dynamic>? additionalInfo;

  UserModeModel({
    required this.userId,
    required this.userType,
    required this.isOnline,
    required this.lastSeen,
    this.currentLocation,
    this.additionalInfo,
  });

  factory UserModeModel.fromJson(Map<String, dynamic> json) {
    return UserModeModel(
      userId: json['userId'] ?? '',
      userType: json['userType'] ?? 'patient',
      isOnline: json['isOnline'] ?? false,
      lastSeen: DateTime.parse(json['lastSeen'] ?? DateTime.now().toIso8601String()),
      currentLocation: json['currentLocation'],
      additionalInfo: json['additionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userType': userType,
      'isOnline': isOnline,
      'lastSeen': lastSeen.toIso8601String(),
      'currentLocation': currentLocation,
      'additionalInfo': additionalInfo,
    };
  }

  UserModeModel copyWith({
    String? userId,
    String? userType,
    bool? isOnline,
    DateTime? lastSeen,
    String? currentLocation,
    Map<String, dynamic>? additionalInfo,
  }) {
    return UserModeModel(
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      currentLocation: currentLocation ?? this.currentLocation,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  String toString() {
    return 'UserModeModel(userId: $userId, userType: $userType, isOnline: $isOnline, lastSeen: $lastSeen, currentLocation: $currentLocation)';
  }
}
