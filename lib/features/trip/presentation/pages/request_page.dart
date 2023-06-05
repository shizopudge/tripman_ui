import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/rounded_text_button.dart';
import '../../../../core/common_widgets/trip_text_field.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/common_widgets/comment_bottom_sheet.dart';
import '../widgets/request_card.dart';

class RequestPage extends StatefulWidget {
  final Trip trip;
  final DateTimeRange selectedInterval;
  final ValueNotifier<bool> _isRequestSentNotifier;
  const RequestPage({
    super.key,
    required this.selectedInterval,
    required ValueNotifier<bool> isRequestSentNotifier,
    required this.trip,
  }) : _isRequestSentNotifier = isRequestSentNotifier;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  late final ValueNotifier<bool> _isPhoneFieldEmptyNotifier;
  late final ValueNotifier<bool> _isCommentFieldEmptyNotifier;
  late final ValueNotifier<bool> _isPhoneFieldValidatedNotifier;
  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _commentFocusNode;
  late final TextEditingController _commentController;

  @override
  void initState() {
    _phoneController = TextEditingController()..addListener(_phoneListener);
    _commentController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _commentFocusNode = FocusNode();
    _isPhoneFieldEmptyNotifier = ValueNotifier<bool>(true);
    _isCommentFieldEmptyNotifier = ValueNotifier<bool>(true);
    _isPhoneFieldValidatedNotifier = ValueNotifier<bool>(false);
    super.initState();
  }

  void _phoneListener() {
    if (_phoneController.text.isNotEmpty) {
      _isPhoneFieldEmptyNotifier.value = false;
      if (_phoneController.text.length > 3) {
        _isPhoneFieldValidatedNotifier.value = true;
      } else {
        _isPhoneFieldValidatedNotifier.value = false;
      }
    } else {
      _isPhoneFieldEmptyNotifier.value = true;
    }
  }

  void _clearPhoneField() {
    _phoneController.clear();
    _phoneFocusNode.requestFocus();
  }

  void _showCommentSheet() => showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CommentBottomSheet(
            commentController: _commentController,
            commentFocusNode: _commentFocusNode,
          );
        },
      );

  void _sendRequest() {
    Navigator.of(context).pop();
    widget._isRequestSentNotifier.value = true;
  }

  @override
  void dispose() {
    _isCommentFieldEmptyNotifier.dispose();
    _isPhoneFieldEmptyNotifier.dispose();
    _isPhoneFieldValidatedNotifier.dispose();
    _phoneController.dispose();
    _commentController.dispose();
    _phoneFocusNode.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FadeAnimationYDown(
              delay: .6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Заявка на бронирование',
                      style: kSFProDisplaySemiBold.copyWith(
                        fontSize: 20,
                        color: kBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: SvgPicture.asset(
                          'assets/icons/close.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  FadeAnimationYDown(
                    delay: .7,
                    child: RequestCard(
                      trip: widget.trip,
                      selectedInterval: widget.selectedInterval,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  FadeAnimationYDown(
                    delay: .8,
                    child: Text(
                      'Номер телефона',
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack50,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FadeAnimationYDown(
                    delay: .9,
                    child: ValueListenableBuilder(
                      valueListenable: _isPhoneFieldEmptyNotifier,
                      builder: (context, isEmpty, _) => TripTextField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        isEmpty: isEmpty,
                        onClear: _clearPhoneField,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeAnimationYDown(
                    delay: 1,
                    child: Text(
                      'Комментарий',
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack50,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FadeAnimationYDown(
                    delay: 1.1,
                    child: TripTextField(
                      controller: _commentController,
                      isReadOnly: true,
                      onTap: _showCommentSheet,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeAnimationYDown(
                    delay: 1.2,
                    child: Text(
                      'Бронирование будет подтверждено\nв течении 24 часов',
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeAnimationYUp(
              delay: 1.2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder(
                  valueListenable: _isPhoneFieldValidatedNotifier,
                  builder: (context, isPhoneFieldValidated, _) =>
                      RoundedTextButton(
                    backgroundColor: isPhoneFieldValidated ? kBlack : kBlack10,
                    textColor: isPhoneFieldValidated ? kWhite : kBlack50,
                    text: 'Отправить заявку',
                    onTap: isPhoneFieldValidated ? _sendRequest : null,
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
