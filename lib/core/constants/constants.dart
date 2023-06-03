import 'package:flutter/material.dart';

import '../entities/trip.dart';
import '../entities/trip_type.dart';

const List<TripType> tripTypes = [
  TripType(
    title: 'Кэмпинги',
    image: 'assets/icons/camping.svg',
  ),
  TripType(
    title: 'Глэмпинги ',
    image: 'assets/icons/glamping.svg',
  ),
  TripType(
    title: 'Базы отдыха',
    image: 'assets/icons/rest_base.svg',
  ),
  TripType(
    title: 'Шале',
    image: 'assets/icons/chalet.svg',
  ),
];

final List<Trip> trips = [
  Trip(
    id: '1',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '2',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '3',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '4',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '5',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '6',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '7',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
  Trip(
    id: '8',
    title: 'Глэминг Караидель',
    image: 'assets/images/c67add00-2934-4814-994c-88e2459b295b.jpg',
    interval: DateTimeRange(
      start: DateTime(2023, 6, 1),
      end: DateTime(2023, 6, 8),
    ),
    minCost: 15000,
    minMembersCount: 6,
    maxMembersCount: 12,
    distance: 888,
  ),
];
