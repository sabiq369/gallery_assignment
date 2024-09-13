import 'package:flutter/material.dart';
import 'package:gallery/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

shimmer() {
  return Shimmer.fromColors(
      baseColor: ColorConstants.shimmerBase,
      highlightColor: ColorConstants.shimmerHighlight,
      child: Container(
        color: ColorConstants.shimmerBase,
      ));
}
