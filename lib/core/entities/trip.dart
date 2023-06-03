import 'package:flutter/material.dart';

class Trip {
  final String title;
  final String image;
  final DateTimeRange interval;
  final int minCost;
  final int minMembersCount;
  final int maxMembersCount;
  final int distance;

  const Trip({
    required this.title,
    required this.image,
    required this.interval,
    required this.minCost,
    required this.minMembersCount,
    required this.maxMembersCount,
    required this.distance,
  });
}
