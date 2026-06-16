import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
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

    return GestureDetector(
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
          color: backgroundColor ?? (dark ? AppColors.black : AppColors.white),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: overlayColor,
                  placeholder: (context, url) =>
                      const ShimmerEffect(width: 80, height: 80, radius: 80),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person, size: 40),
                )
              : Image.asset(image, fit: fit, color: overlayColor),
        ),
      ),
    );
  }
}
