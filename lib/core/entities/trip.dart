class Trip {
  final String title;
  final String image;
  final DateTime startDate;
  final DateTime endDate;
  final int minCost;
  final int minMembersCount;
  final int maxMembersCount;
  final int distance;

  const Trip({
    required this.title,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.minCost,
    required this.minMembersCount,
    required this.maxMembersCount,
    required this.distance,
  });
}
