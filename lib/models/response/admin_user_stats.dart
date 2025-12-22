class AdminUserStats {
  final int totalUsers;
  final int newUsersThisMonth;
  final double freePercent;
  final double vipPercent;

  AdminUserStats({
    required this.totalUsers,
    required this.newUsersThisMonth,
    required this.freePercent,
    required this.vipPercent,
  });

  factory AdminUserStats.fromJson(Map<String, dynamic> json) {
    return AdminUserStats(
      totalUsers: json['totalUsers'] as int,
      newUsersThisMonth: json['newUsersThisMonth'] as int,
      freePercent: (json['freePercent'] as num).toDouble(),
      vipPercent: (json['vipPercent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalUsers': totalUsers,
      'newUsersThisMonth': newUsersThisMonth,
      'freePercent': freePercent,
      'vipPercent': vipPercent,
    };
  }
}
