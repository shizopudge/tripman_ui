import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/error_message_widget.dart';
import '../../../../core/common_widgets/loader.dart';
import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/entities/trip_type.dart';
import '../../../../core/styles/styles.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/trip_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<TripType> _selectedTripTypeNotifier;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _selectedTripTypeNotifier = ValueNotifier<TripType>(tripTypes.first)
      ..addListener(_tripTypeListener);
    _homeBloc = HomeBloc()..add(HomeInititalEvent());
    super.initState();
  }

  @override
  void dispose() {
    _selectedTripTypeNotifier.dispose();
    super.dispose();
  }

  void _tripTypeListener() {
    debugPrint('Get ${_selectedTripTypeNotifier.value.title} trips');
    _homeBloc.add(
      HomeGetTripsEvent(
        type: _selectedTripTypeNotifier.value.title,
        isRefresh: false,
      ),
    );
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
          forceMaterialTransparency: true,
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
          child: RoundedRowIconButton(
            mainAxisSize: MainAxisSize.min,
            iconPath: 'assets/icons/map.svg',
            text: 'На карте',
            onTap: () {},
            verticalPadding: 14,
            horizontalPadding: 25,
            backgroundColor: kBlack,
            borderColor: kBlack,
            inRowPadding: 13,
            textStyle: kSFProDisplayMedium.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: RefreshIndicator(
          onRefresh: () async {
            _homeBloc.add(
              HomeGetTripsEvent(
                type: _selectedTripTypeNotifier.value.title,
                isRefresh: true,
              ),
            );
          },
          color: kWhite,
          backgroundColor: kBlack,
          child: BlocConsumer<HomeBloc, HomeState>(
            bloc: _homeBloc,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case HomeLoadingState:
                  final isRefreshing = (state as HomeLoadingState).isRefreshing;
                  if (isRefreshing) {
                    return FadeAnimationYDown(
                      delay: 1.1,
                      child: Column(
                        children: [
                          const FadeAnimationYDown(
                            delay: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 22,
                              ),
                              child: Loader(
                                color: kBlack,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20)
                                      .copyWith(top: 18),
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
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: FadeAnimationYDown(
                        delay: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 22,
                          ),
                          child: Loader(
                            color: kBlack,
                          ),
                        ),
                      ),
                    );
                  }
                case HomeLoadedState:
                  final loadedState = state as HomeLoadedState;
                  final trips = loadedState.trips;
                  if (trips.isNotEmpty) {
                    return FadeAnimationYDown(
                      delay: 1.1,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: 18),
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
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 76),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'Свободных объектов не найдено. Попробуйте изменить ',
                          style: kSFProDisplayRegular.copyWith(
                            fontSize: 15,
                            color: kBlack50,
                          ),
                          children: [
                            TextSpan(
                              text: 'даты поездки.',
                              style: kSFProDisplayRegular.copyWith(
                                fontSize: 15,
                                color: kBlack,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                case HomeErrorState:
                  final errorState = state as HomeErrorState;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ErrorMessageWidget(
                          message: errorState.message,
                          iconPath: 'assets/icons/error.svg',
                          color: kBlack,
                        ),
                      ],
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
