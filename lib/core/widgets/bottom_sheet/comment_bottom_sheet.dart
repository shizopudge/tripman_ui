import 'package:flutter/material.dart';

import '../../constants/styles/styles.dart';
import 'scaffold_bottom_sheet.dart';

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({
    super.key,
    required TextEditingController commentController,
  }) : _commentController = commentController;

  final TextEditingController _commentController;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBottomSheet(
      title: 'Комментарий',
      child: TextField(
        controller: _commentController,
        cursorColor: kBlack,
        maxLines: 2,
        autofocus: true,
        style: kSFProDisplayRegular.copyWith(
          color: kBlack,
          fontSize: 15,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
