import 'package:flutter/material.dart';

class Trip {
  final String id;
  final String title;
  final List<String> images;
  final DateTimeRange interval;
  final int minCost;
  final int minMembersCount;
  final int maxMembersCount;
  final int distance;

  const Trip({
    required this.id,
    required this.title,
    required this.images,
    required this.interval,
    required this.minCost,
    required this.minMembersCount,
    required this.maxMembersCount,
    required this.distance,
  });
}
