import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../animations/fade_animation_y_down.dart';
import '../../constants/styles/styles.dart';
import '../../utils/popup_utils.dart';
import '../bottom_sheet/scaffold_bottom_sheet.dart';
import '../buttons/close_button.dart';
import '../buttons/rounded_text_button.dart';
import '../common/default_text_field.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({
    super.key,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  late final ValueNotifier<double> _ratingNotifier;
  late final TextEditingController _commentController;
  late final FocusNode _commentFocusNode;
  @override
  void initState() {
    _commentController = TextEditingController();
    _commentFocusNode = FocusNode();
    _ratingNotifier = ValueNotifier<double>(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _ratingNotifier.dispose();
    super.dispose();
  }

  void _showCommentSheet() => PopupUtils.showMyBottomSheet(
        context: context,
        bottomSheet: ScaffoldBottomSheet(
          title: 'Комментарий',
          child: TextField(
            controller: _commentController,
            focusNode: _commentFocusNode,
            cursorColor: kBlack,
            maxLines: 5,
            style: kSFProDisplayRegular.copyWith(
              color: kBlack,
              fontSize: 15,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FadeAnimationYDown(
      delay: .4,
      child: SimpleDialog(
        elevation: 0,
        backgroundColor: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        insetPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Оставьте отзыв',
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    style: kSFProDisplaySemiBold.copyWith(
                      fontSize: 24,
                      color: kBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Мы развиваем сервис и очень важно узнать ваше мнение об месте отдыха и удобства приложения',
                    style: kSFProDisplayRegular.copyWith(
                      fontSize: 15,
                      color: kBlack50,
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Center(
                    child: RatingBar(
                      wrapAlignment: WrapAlignment.spaceBetween,
                      itemPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .025,
                      ),
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star_rounded,
                          size: 26,
                        ),
                        half: const SizedBox(),
                        empty: const Icon(
                          Icons.star_outline_rounded,
                          size: 26,
                        ),
                      ),
                      onRatingUpdate: (rating) =>
                          _ratingNotifier.value = rating,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    'Комментарий',
                    style: kSFProDisplayRegular.copyWith(
                      color: kBlack50,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultTextField(
                    controller: _commentController,
                    isReadOnly: true,
                    onTap: _showCommentSheet,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _ratingNotifier,
                    builder: (context, rating, _) => RoundedTextButton(
                      isEnabled: rating != 0.0,
                      text: 'Отправить',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              const MyCloseButton(),
            ],
          ),
        ],
      ),
    );
  }
}
