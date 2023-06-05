import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/trip_image.dart';
import '../../../../core/common_widgets/trip_image_placeholder.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/service/date_formater.dart';
import '../../../../core/styles/styles.dart';
import 'request_text_row.dart';

class RequestCard extends StatelessWidget {
  final Trip trip;
  final DateTimeRange selectedInterval;
  const RequestCard({
    super.key,
    required this.trip,
    required this.selectedInterval,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: trip.images.first,
            imageBuilder: (context, imageProvider) => TripImage(
              height: 160,
              imageProvider: imageProvider,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  20,
                ),
              ),
            ),
            placeholder: (context, url) => const TripImagePlaceholder(
              height: 160,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  20,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const TripImagePlaceholder(
              height: 160,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  20,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(
                  20,
                ),
              ),
              border: Border.all(
                color: kBlack10,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: kSFProDisplaySemiBold.copyWith(
                    fontSize: 18,
                    color: kBlack,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RequestTextRow(
                  title: 'Заезд',
                  info: DateFormater.datesFieldDateFormater(
                    interval: selectedInterval,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RequestTextRow(
                  title: 'Вместимость',
                  info: '${trip.minMembersCount}-${trip.maxMembersCount}',
                ),
                const SizedBox(
                  height: 16,
                ),
                RequestTextRow(
                  title: 'Оплата',
                  info: '${trip.minCost} ₽ / сутки',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
