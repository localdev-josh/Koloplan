class AppUpdateConfig {
  final int androidVersion;
  final int iOSVersion;
  final String androidLink;
  final String iOSLink;
  final bool forceUpdate;

  AppUpdateConfig(
      {this.androidVersion,
      this.iOSVersion,
      this.androidLink,
      this.iOSLink,
      this.forceUpdate});

  factory AppUpdateConfig.fromJson(Map<String, dynamic> json) =>
      AppUpdateConfig(
          androidVersion: json['androidVersion'],
          iOSVersion: json['iosVersion'],
          androidLink: json['androidLink'],
          iOSLink: json['iosLink'],
          forceUpdate: json['forceUpdate'] ?? false);
}

class AppUpdateCheck {
  final bool forceUpdate;
  final bool iosUpdate;
  final bool androidUpdate;

  AppUpdateCheck(
      {this.androidUpdate,
        this.iosUpdate,
        this.forceUpdate});
}
