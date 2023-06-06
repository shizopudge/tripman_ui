import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/utils/popup_utils.dart';
import '../../../../core/widgets/bottom_sheet/comment_bottom_sheet.dart';
import '../../../../core/widgets/buttons/close_button.dart';
import '../../../../core/widgets/buttons/rounded_text_button.dart';
import '../../../../core/widgets/common/default_text_field.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/constants/styles/styles.dart';

import '../../../../core/widgets/cards/request_card.dart';

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
  late final TextEditingController _commentController;
  final _maskFormatter = MaskTextInputFormatter(
    mask: '+7 ### ## ## ###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    _phoneController = TextEditingController()..addListener(_phoneListener);
    _commentController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _isPhoneFieldEmptyNotifier = ValueNotifier<bool>(true);
    _isCommentFieldEmptyNotifier = ValueNotifier<bool>(true);
    _isPhoneFieldValidatedNotifier = ValueNotifier<bool>(false);
    super.initState();
  }

  void _phoneListener() {
    if (_phoneController.text.isNotEmpty) {
      _isPhoneFieldEmptyNotifier.value = false;
    } else {
      _isPhoneFieldEmptyNotifier.value = true;
    }
    if (_maskFormatter.isFill()) {
      _isPhoneFieldValidatedNotifier.value = true;
    } else {
      _isPhoneFieldValidatedNotifier.value = false;
    }
  }

  void _clearPhoneField() {
    _phoneController.clear();
    _phoneFocusNode.requestFocus();
    _isPhoneFieldValidatedNotifier.value = false;
  }

  void _showCommentSheet() => PopupUtils.showMyBottomSheet(
        context: context,
        bottomSheet: CommentBottomSheet(
          commentController: _commentController,
        ),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        titleSpacing: 20,
        title: Text(
          'Заявка на бронирование',
          style: kSFProDisplaySemiBold.copyWith(
            fontSize: 20,
            color: kBlack,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 26),
            child: MyCloseButton(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      builder: (context, isEmpty, _) => DefaultTextField(
                        inputFormatters: [
                          _maskFormatter,
                        ],
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
                    child: DefaultTextField(
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
                    isEnabled: isPhoneFieldValidated,
                    text: 'Отправить заявку',
                    onTap: _sendRequest,
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
