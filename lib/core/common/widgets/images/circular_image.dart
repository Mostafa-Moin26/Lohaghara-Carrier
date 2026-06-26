import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    required this.image,
    this.isNetworkImage = false,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = 0,
    this.onTap,
  });

  final String image;
  final bool isNetworkImage;
  final BoxFit fit;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width;
  final double height;
  final double padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            border: Border.all(
              color: dark ? AppColors.white : AppColors.primaryDark,
              width: 1.5,
            ),
            color:
                backgroundColor ?? (dark ? AppColors.black : AppColors.white),
            shape: BoxShape.circle,
          ),
          child: ClipOval(child: _buildImage()),
        ),
      ),
    );
  }

  Widget _buildImage() {
    /// Network Image
    if (isNetworkImage) {
      /// Empty URL
      if (image.trim().isEmpty) {
        return Image.asset(
          AppImageStrings.emptyProfilePicture,
          fit: fit,
          color: overlayColor,
        );
      }

      return CachedNetworkImage(
        imageUrl: image,

        fit: fit,

        color: overlayColor,

        fadeInDuration: const Duration(milliseconds: 200),

        // memCacheWidth: (width * 3).toInt(),
        // memCacheHeight: (height * 3).toInt(),
        placeholder: (_, _) =>
            ShimmerEffect(width: width, height: height, radius: width),

        errorWidget: (_, _, _) => Image.asset(
          AppImageStrings.emptyProfilePicture,
          fit: fit,
          color: overlayColor,
        ),
      );
    }

    /// Asset Image
    return Image.asset(image, fit: fit, color: overlayColor);
  }
}
