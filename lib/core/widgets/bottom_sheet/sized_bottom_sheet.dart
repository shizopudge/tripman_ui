import 'package:flutter/widgets.dart';

import '../../constants/styles/styles.dart';
import 'bottom_sheet_divider.dart';

class SizedBottomSheet extends StatelessWidget {
  final double heightFactor;
  final String title;
  final Widget child;
  final bool isScrollable;
  const SizedBottomSheet({
    super.key,
    required this.heightFactor,
    required this.title,
    required this.child,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: Column(
        children: [
          const BottomSheetDivider(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: isScrollable
                  ? ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          title,
                          style: kSFProDisplaySemiBold.copyWith(
                            color: kBlack,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        child,
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            title,
                            style: kSFProDisplaySemiBold.copyWith(
                              color: kBlack,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        child,
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
