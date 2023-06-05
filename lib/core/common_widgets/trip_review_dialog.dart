import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'comment_bottom_sheet.dart';
import '../animations/fade_animation_y_down.dart';
import '../styles/styles.dart';
import 'rounded_text_button.dart';
import 'trip_text_field.dart';

class TripReviewDialog extends StatefulWidget {
  const TripReviewDialog({
    super.key,
  });

  @override
  State<TripReviewDialog> createState() => _TripReviewDialogState();
}

class _TripReviewDialogState extends State<TripReviewDialog> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: FadeAnimationYDown(
        delay: .4,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              color: kWhite,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimationYDown(
                      delay: .5,
                      child: Text(
                        'Оставьте отзыв',
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: kSFProDisplaySemiBold.copyWith(
                          fontSize: 24,
                          color: kBlack,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FadeAnimationYDown(
                      delay: .6,
                      child: Text(
                        'Мы развиваем сервис и очень важно узнать ваше мнение об месте отдыха и удобства приложения',
                        style: kSFProDisplayRegular.copyWith(
                          fontSize: 15,
                          color: kBlack50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    FadeAnimationYDown(
                      delay: .7,
                      child: Center(
                        child: RatingBar(
                          wrapAlignment: WrapAlignment.spaceBetween,
                          itemPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .025,
                          ),
                          itemSize: MediaQuery.of(context).size.width * .09,
                          ratingWidget: RatingWidget(
                            full: SvgPicture.asset(
                              'assets/icons/star_filled.svg',
                            ),
                            half: const SizedBox(),
                            empty: SvgPicture.asset(
                              'assets/icons/star_empty.svg',
                            ),
                          ),
                          onRatingUpdate: (rating) =>
                              _ratingNotifier.value = rating,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    FadeAnimationYDown(
                      delay: .8,
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
                      delay: .9,
                      child: TripTextField(
                        controller: _commentController,
                        isReadOnly: true,
                        onTap: _showCommentSheet,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    FadeAnimationYDown(
                      delay: 1,
                      child: ValueListenableBuilder(
                        valueListenable: _ratingNotifier,
                        builder: (context, rating, _) => RoundedTextButton(
                          backgroundColor: rating != 0.0 ? kBlack : kBlack10,
                          textColor: rating != 0.0 ? kWhite : kBlack50,
                          text: 'Отправить',
                          onTap: rating != 0.0
                              ? () => Navigator.of(context).pop()
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                FadeAnimationYDown(
                  delay: .5,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6, top: 6),
                      child: SvgPicture.asset(
                        'assets/icons/close.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
