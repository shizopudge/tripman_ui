import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../animations/fade_animation_y_down.dart';
import 'bottom_sheet_divider.dart';
import '../styles/styles.dart';

class CommentBottomSheet extends StatefulWidget {
  final TextEditingController _commentController;
  final FocusNode _commentFocusNode;
  const CommentBottomSheet({
    super.key,
    required TextEditingController commentController,
    required FocusNode commentFocusNode,
  })  : _commentController = commentController,
        _commentFocusNode = commentFocusNode;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  @override
  void initState() {
    widget._commentFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetDivider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                      controller: widget._commentController,
                      focusNode: widget._commentFocusNode,
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
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
