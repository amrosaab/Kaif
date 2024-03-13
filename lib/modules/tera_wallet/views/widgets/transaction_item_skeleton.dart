import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';

class TransactionItemSkeleton extends StatelessWidget {
  const TransactionItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 20,
        minVerticalPadding: 4,
        minLeadingWidth: 24,
        leading: Skeleton(
          height: 30,
          width: 30,
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                height: 16,
                width: 180,
              ),
              SizedBox(height: 4),
              Skeleton(
                height: 14,
                width: 100,
              ),
              SizedBox(height: 12),
              Skeleton(
                height: 10,
                width: 100,
              ),
            ],
          ),
        ),
        trailing: Skeleton(
          height: 22,
          width: 100,
        ),
      ),
    );
  }
}
