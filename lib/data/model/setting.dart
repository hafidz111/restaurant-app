class Setting {
  final bool isDarkMode;

  Setting({required this.isDarkMode});

  Map<String, dynamic> toJson() {
    return {'isDarkMode': isDarkMode};
  }

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(isDarkMode: json['isDarkMode'] ?? false);
  }
}
