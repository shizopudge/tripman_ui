import 'package:flutter/material.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/entities/trip_type.dart';
import '../../../../core/styles/styles.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/trip_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<TripType> _selectedTripTypeNotifier;

  @override
  void initState() {
    _selectedTripTypeNotifier = ValueNotifier<TripType>(tripTypes.first)
      ..addListener(_tripTypeListener);
    super.initState();
  }

  @override
  void dispose() {
    _selectedTripTypeNotifier.dispose();
    super.dispose();
  }

  void _tripTypeListener() {
    debugPrint('Get ${_selectedTripTypeNotifier.value.title} trips');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //TODO? onWillPop
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          titleSpacing: 20,
          centerTitle: true,
          backgroundColor: kWhite,
          elevation: 0,
          title: FadeAnimationYDown(
            delay: 1,
            child: HomeAppBar(
              selectedTripTypeNotifier: _selectedTripTypeNotifier,
            ),
          ),
        ),
        floatingActionButton: FadeAnimationYUp(
          delay: 1.2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.38,
            child: RoundedRowIconButton(
              iconPath: 'assets/icons/map.svg',
              text: 'На карте',
              onTap: () {},
              verticalPadding: 14.0,
              horizontalPadding: 25,
              inRowPadding: 13,
              backgroundColor: kBlack,
              borderColor: kBlack,
              textColor: kWhite,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FadeAnimationYDown(
          delay: 1.1,
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 18),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final Trip trip = trips[index];
              return FadeAnimationYUp(
                delay: .3,
                child: TripCard(
                  onMapTap: () {},
                  onTap: () {},
                  trip: trip,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
