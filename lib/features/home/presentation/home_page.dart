import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/presentation/animations/fade_animation_y_down.dart';
import '../../../core/presentation/animations/fade_animation_y_up.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../core/utils/popup_utils.dart';
import '../../../core/presentation/widgets/bottom_sheet/sized_bottom_sheet.dart';
import '../../../core/presentation/widgets/buttons/rounded_border_button.dart';
import '../../../core/presentation/widgets/calendar/calendar.dart';
import '../../../core/presentation/widgets/common/error_message.dart';
import '../../../core/presentation/widgets/common/loader.dart';
import '../../../core/data/fake_data.dart';
import '../../../core/data/entities/trip.dart';
import '../../../core/data/entities/trip_type.dart';
import '../../../core/styles/styles.dart';
import '../../authorization/presentation/bloc/auth_bloc.dart';
import '../../authorization/presentation/pages/start_page.dart';
import 'bloc/home_bloc.dart';
import '../../../core/presentation/widgets/cards/trip_card.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_menu_bar.dart';

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
      ..addListener(_selectedtripTypeListener);
    _selectedIntervalNotifier = ValueNotifier<DateTimeRange?>(null)
      ..addListener(_selectedIntervalListener);
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

  void _selectedtripTypeListener() => _homeBloc.add(
        HomeGetTripsEvent(
          type: _selectedTripTypeNotifier.value.title,
          interval: _selectedIntervalNotifier.value,
        ),
      );

  void _selectedIntervalListener() => _homeBloc.add(
        HomeGetTripsEvent(
          type: _selectedTripTypeNotifier.value.title,
          interval: _selectedIntervalNotifier.value,
        ),
      );

  void _showCalendar() => showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBottomSheet(
            heightFactor: .95,
            title: 'Даты поездки',
            isScrollable: false,
            child: Calendar(
              selectedIntervalNotifier: _selectedIntervalNotifier,
            ),
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
    NavigationUtils.pushWithFade(
      context: context,
      page: const StartPage(),
    );
    context.read<AuthBloc>().add(AuthLogoutEvent());
  }

  void _onMapTap() => PopupUtils.showBanner(context: context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ValueListenableBuilder(
        valueListenable: _isMenuOpenedNotifier,
        builder: (context, isMenuOpened, _) => Scaffold(
          appBar: isMenuOpened
              ? homeMenuBar(
                  context,
                  closeShowMenu: _closeShowMenu,
                  logout: _logout,
                )
              : homeAppBar(
                  closeShowMenu: _closeShowMenu,
                  showCalendar: _showCalendar,
                  clear: _clearInterval,
                  selectedIntervalNotifier: _selectedIntervalNotifier,
                  selectedTripTypeNotifier: _selectedTripTypeNotifier,
                ),
          floatingActionButton: FadeAnimationYUp(
            delay: .8,
            child: RoundedBorderButton(
              onTap: _onMapTap,
              mainAxisSize: MainAxisSize.min,
              backgroundColor: kBlack,
              borderColor: kBlack,
              horizontalPadding: 25,
              children: [
                SvgPicture.asset(
                  'assets/icons/map.svg',
                ),
                const SizedBox(
                  width: 13,
                ),
                Flexible(
                  child: Text(
                    'На карте',
                    overflow: TextOverflow.ellipsis,
                    style: kSFProDisplayMedium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
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
                      return Column(
                        children: [
                          const FadeAnimationYDown(
                            delay: 0,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 22,
                                bottom: 2,
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
                                      .copyWith(top: 20),
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
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: 20),
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          final Trip trip = trips[index];
                          return TripCard(
                            trip: trip,
                          );
                        },
                      );
                    }
                    return FadeAnimationYDown(
                      delay: 0,
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
                      delay: 0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ErrorMessage(
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
