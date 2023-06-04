import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/date_range_picker/calendar_bottom_sheet.dart';
import '../../../../core/common_widgets/error_message_widget.dart';
import '../../../../core/common_widgets/loader.dart';
import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/entities/trip_type.dart';
import '../../../../core/styles/styles.dart';
import '../../../authorization/presentation/bloc/auth_bloc.dart';
import '../../../authorization/presentation/pages/start_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/menu.dart';
import '../widgets/trip_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<TripType> _selectedTripTypeNotifier;
  late final ValueNotifier<DateTimeRange?> _selectedIntervalNotifier;
  late final ValueNotifier<bool> _isMenuOpenedNotifier;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _selectedTripTypeNotifier = ValueNotifier<TripType>(tripTypes.first)
      ..addListener(_tripTypeListener);
    _selectedIntervalNotifier = ValueNotifier<DateTimeRange?>(null)
      ..addListener(_datesListener);
    _isMenuOpenedNotifier = ValueNotifier<bool>(false);
    _homeBloc = HomeBloc()..add(HomeInititalEvent());
    super.initState();
  }

  @override
  void dispose() {
    _selectedTripTypeNotifier.dispose();
    _selectedIntervalNotifier.dispose();
    _isMenuOpenedNotifier.dispose();
    _homeBloc.close();
    super.dispose();
  }

  void _tripTypeListener() {
    debugPrint(
        'Get ${_selectedTripTypeNotifier.value.title} trips on trip type change');
    _homeBloc.add(
      HomeGetTripsEvent(
        type: _selectedTripTypeNotifier.value.title,
        interval: _selectedIntervalNotifier.value,
      ),
    );
  }

  void _datesListener() {
    debugPrint(
        'Get ${_selectedTripTypeNotifier.value.title} trips on interval change');
    _homeBloc.add(
      HomeGetTripsEvent(
        type: _selectedTripTypeNotifier.value.title,
        interval: _selectedIntervalNotifier.value,
      ),
    );
  }

  void _showCalendar() => showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CalendarBottomSheet(
            selectedIntervalNotifier: _selectedIntervalNotifier,
          );
        },
      );

  void _closeShowMenu() {
    if (_isMenuOpenedNotifier.value == true) {
      _isMenuOpenedNotifier.value = false;
    } else {
      _isMenuOpenedNotifier.value = true;
    }
  }

  void _clearInterval() => _selectedIntervalNotifier.value = null;

  void _logout() {
    Navigator.of(context).push(
      PageTransition(
        duration: const Duration(milliseconds: 250),
        type: PageTransitionType.fade,
        child: const StartPage(),
      ),
    );
    context.read<AuthBloc>().add(AuthLogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ValueListenableBuilder(
        valueListenable: _isMenuOpenedNotifier,
        builder: (context, isMenuOpened, _) => Scaffold(
          appBar: isMenuOpened
              ? buildMenu(
                  context,
                  closeShowMenu: _closeShowMenu,
                  logout: _logout,
                )
              : buildAppBar(
                  closeShowMenu: _closeShowMenu,
                  showCalendar: _showCalendar,
                  clear: _clearInterval,
                  selectedIntervalNotifier: _selectedIntervalNotifier,
                  selectedTripTypeNotifier: _selectedTripTypeNotifier,
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                    final isRefreshing =
                        (state as HomeLoadingState).isRefreshing;
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
                                  return TripCard(
                                    trip: trip,
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
                            return TripCard(
                              trip: trip,
                            );
                          },
                        ),
                      );
                    }
                    return FadeAnimationYDown(
                      delay: 1,
                      child: Center(
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
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _showCalendar,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  case HomeErrorState:
                    final errorState = state as HomeErrorState;
                    return FadeAnimationYDown(
                      delay: 1,
                      child: Center(
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
                      ),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
