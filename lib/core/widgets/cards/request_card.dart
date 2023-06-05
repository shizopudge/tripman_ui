import 'package:flutter/material.dart';

import '../../entities/trip.dart';
import '../../service/date_formater.dart';
import '../../styles/styles.dart';
import '../images/image_cached.dart';

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
          ImageCached(
            imageUrl: trip.images.first,
            height: 160,
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
                RequestCardTextRow(
                  title: 'Заезд',
                  info: DateFormater.datesFieldDateFormater(
                    interval: selectedInterval,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RequestCardTextRow(
                  title: 'Вместимость',
                  info: '${trip.minMembersCount}-${trip.maxMembersCount}',
                ),
                const SizedBox(
                  height: 16,
                ),
                RequestCardTextRow(
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

class RequestCardTextRow extends StatelessWidget {
  final String title;
  final String info;
  const RequestCardTextRow({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kSFProDisplayRegular.copyWith(
            color: kBlack50,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Text(
            info,
            overflow: TextOverflow.visible,
            style: kSFProDisplayRegular.copyWith(
              fontSize: 15,
              color: kBlack,
            ),
          ),
        ),
      ],
    );
  }
}
