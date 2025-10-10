class Setting {
  final bool isDarkMode;
  final bool isNotification;

  Setting({required this.isDarkMode, required this.isNotification});

  Map<String, dynamic> toJson() {
    return {'isDarkMode': isDarkMode, 'isNotification': isNotification};
  }

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      isDarkMode: json['isDarkMode'] ?? false,
      isNotification: json['isNotification'] ?? false,
    );
  }
}
