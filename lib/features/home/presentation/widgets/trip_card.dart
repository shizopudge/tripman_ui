import 'package:flutter/material.dart';

import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/service/date_formater.dart';
import '../../../../core/styles/styles.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;
  final VoidCallback onMapTap;
  const TripCard({
    super.key,
    required this.trip,
    required this.onMapTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 451,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(.1),
              blurRadius: 5.0,
              spreadRadius: 1.5,
              offset: const Offset(1.5, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 335,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        20,
                      ),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        trip.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.title,
                        overflow: TextOverflow.ellipsis,
                        style: kSFProDisplaySemiBold.copyWith(
                          color: kBlack,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'от ${trip.minCost} ₽',
                              overflow: TextOverflow.ellipsis,
                              style: kSFProDisplayMedium.copyWith(
                                fontSize: 16,
                                color: kBlack,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormater.tripCardDateFormater(
                                    interval: trip.interval,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  style: kSFProDisplayRegular.copyWith(
                                    color: kBlack50,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '${trip.minMembersCount}-${trip.maxMembersCount} гостей',
                                  overflow: TextOverflow.ellipsis,
                                  style: kSFProDisplayRegular.copyWith(
                                    color: kBlack50,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 16,
                ),
                child: RoundedRowIconButton(
                  mainAxisSize: MainAxisSize.min,
                  iconPath: 'assets/icons/map_arrow.svg',
                  text: '${trip.distance} км',
                  onTap: () {},
                  verticalPadding: 8,
                  horizontalPadding: 8,
                  backgroundColor: kWhite,
                  borderColor: kWhite,
                  inRowPadding: 6,
                  textStyle: kSFProDisplayRegular.copyWith(
                    color: kBlack,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
