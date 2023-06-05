import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../animations/fade_animation_y_down.dart';
import 'bottom_sheet_divider.dart';
import '../styles/styles.dart';

class CommentBottomSheet extends StatelessWidget {
  final TextEditingController _commentController;
  final FocusNode _commentFocusNode;
  const CommentBottomSheet({
    super.key,
    required TextEditingController commentController,
    required FocusNode commentFocusNode,
  })  : _commentController = commentController,
        _commentFocusNode = commentFocusNode;

  @override
  Widget build(BuildContext context) {
    _commentFocusNode.requestFocus();
    return FractionallySizedBox(
      heightFactor: .65,
      child: Column(
        children: [
          const BottomSheetDivider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  FadeAnimationYDown(
                    delay: .5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Комментарий',
                          style: kSFProDisplaySemiBold.copyWith(
                            color: kBlack,
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6, top: 6),
                            child: SvgPicture.asset(
                              'assets/icons/close.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeAnimationYDown(
                    delay: .5,
                    child: TextField(
                      controller: _commentController,
                      focusNode: _commentFocusNode,
                      cursorColor: kBlack,
                      maxLines: 10,
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack,
                        fontSize: 15,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
