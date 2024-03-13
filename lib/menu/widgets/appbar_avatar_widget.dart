import 'package:flutter/material.dart';

import '../../widgets/common/flux_image.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.width,
    this.imageColor,
    this.height,
    this.defaultAvatar,
    this.iconColor,
    required this.fit,
    required this.radius,
    required this.imageUrl,
  });

  final BoxFit fit;
  final double radius;
  final double? width;
  final double? height;
  final String imageUrl;

  /// If the user avatar is not available, it will display the default avatar
  /// from a link. If not set default avatar, it will show the person icon.
  final String? defaultAvatar;

  /// `imageColor` only work for default avatar with transparent png image. Do
  /// not apply for user avatar
  final Color? imageColor;

  final Color? iconColor;

  bool get checkDefaultAvatar => defaultAvatar?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    final avatar = imageUrl.isNotEmpty
        ? imageUrl
        : (checkDefaultAvatar ? defaultAvatar! : '');
    if (avatar.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        child: FluxImage(
          imageUrl: avatar,
          width: width ?? 50,
          height: height ?? 50,
          fit: BoxFit.cover,
          color: imageUrl.isNotEmpty ? null : imageColor,
        ),
      );
    }

    return Container(
      width: width ?? 50.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Icon(
        Icons.person,
        size: 30.0,
        color: iconColor,
      ),
    );
  }
}
