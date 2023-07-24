/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/flower.jpg
  AssetGenImage get flower => const AssetGenImage('assets/icons/flower.jpg');

  /// File path: assets/icons/icon_drink.svg
  SvgGenImage get iconDrink => const SvgGenImage('assets/icons/icon_drink.svg');

  /// File path: assets/icons/icon_food.svg
  SvgGenImage get iconFood => const SvgGenImage('assets/icons/icon_food.svg');

  /// File path: assets/icons/logo_restaurant.png
  AssetGenImage get logoRestaurant =>
      const AssetGenImage('assets/icons/logo_restaurant.png');

  /// List of all assets
  List<dynamic> get values => [flower, iconDrink, iconFood, logoRestaurant];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/illustration_no_connection.svg
  SvgGenImage get illustrationNoConnection =>
      const SvgGenImage('assets/images/illustration_no_connection.svg');

  /// File path: assets/images/illustration_notfound.svg
  SvgGenImage get illustrationNotfound =>
      const SvgGenImage('assets/images/illustration_notfound.svg');

  /// File path: assets/images/illustration_question.svg
  SvgGenImage get illustrationQuestion =>
      const SvgGenImage('assets/images/illustration_question.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [illustrationNoConnection, illustrationNotfound, illustrationQuestion];
}

class $AssetsMarkersGen {
  const $AssetsMarkersGen();

  /// File path: assets/markers/car.png
  AssetGenImage get car => const AssetGenImage('assets/markers/car.png');

  /// File path: assets/markers/locatpin.png
  AssetGenImage get locatpin =>
      const AssetGenImage('assets/markers/locatpin.png');

  /// File path: assets/markers/map-pin.png
  AssetGenImage get mapPin => const AssetGenImage('assets/markers/map-pin.png');

  /// File path: assets/markers/mappin.png
  AssetGenImage get mappin => const AssetGenImage('assets/markers/mappin.png');

  /// File path: assets/markers/pin.png
  AssetGenImage get pin => const AssetGenImage('assets/markers/pin.png');

  /// List of all assets
  List<AssetGenImage> get values => [car, locatpin, mapPin, mappin, pin];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMarkersGen markers = $AssetsMarkersGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
