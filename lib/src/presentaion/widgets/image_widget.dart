// add following dependencies
//    -> easy_image_viewer ^1.5.0
//    -> flutter_svg ^2.0.10+1
//    -> cached_network_image ^3.3.1

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oraaq/src/core/extensions/base64_to_bytes_extensions.dart';
import 'package:oraaq/src/imports.dart';

enum ImageType { asset, file, network, base64, unknown }

enum ImageFormat { raster, vector }

class ImageWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double opacity;
  final double borderRadius;
  final String placeholderImage;
  final double loadingIndicatorSize;
  final Color? loadingIndicatorColor;
  final ImageType? type;
  final ImageFormat? format;
  const ImageWidget(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.opacity = 1,
    this.borderRadius = 0,
    this.loadingIndicatorSize = 24,
    this.placeholderImage = AssetConstants.services1,
    this.loadingIndicatorColor,
    this.type,
    this.format,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: switch (type ?? _imageType) {
          ImageType.network when _isVector => _buildSvgNetwork(),
          ImageType.asset when _isVector => _buildSvgAsset(),
          ImageType.file when _isVector => _buildSvgFile(),
          ImageType.network => _buildImageNetwork(),
          ImageType.asset => _buildImageAsset(),
          ImageType.file => _buildImageFile(),
          ImageType.base64 => _buildImageBase64(),
          ImageType.unknown => _buildError(),
        });
  }

  // MARK: HELPERS

  ImageType get _imageType {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return ImageType.network;
    } else if (path.startsWith('/') || path.startsWith('file://')) {
      return ImageType.file;
    } else if (path.startsWith('assets/')) {
      return ImageType.asset;
    } else if (_isBase64(path)) {
      return ImageType.base64;
    } else {
      return ImageType.unknown;
    }
  }

  bool _isBase64(String str) {
    final regex = RegExp(r'^[A-Za-z0-9+/=]+\$');
    return regex.hasMatch(str) && str.length % 4 == 0;
  }

  bool get _isVector =>
      format == ImageFormat.vector || path.toLowerCase().endsWith('.svg');

  Widget get _placeholder => Image.asset(
        placeholderImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
      );

  // MARK: BUILDERS

  Container _buildError() {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: 8.allPadding,
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.grey.shade200,
            )),
        child: Text("Error\n\n$path",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            )));
  }

  Image _buildImageFile() {
    return Image.file(
      File(path),
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }

  Image _buildImageAsset() {
    return Image.asset(
      path,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }

  SvgPicture _buildSvgNetwork() {
    return SvgPicture.network(
      path,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      placeholderBuilder: (_) => _placeholder,
    );
  }

  SvgPicture _buildSvgFile() {
    return SvgPicture.file(
      File(path),
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      placeholderBuilder: (_) => _placeholder,
    );
  }

  SvgPicture _buildSvgAsset() {
    return SvgPicture.asset(
      path,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      placeholderBuilder: (_) => _placeholder,
    );
  }

  CachedNetworkImage _buildImageNetwork() {
    return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorWidget: (context, url, error) => _placeholder,
        progressIndicatorBuilder: (_, __, progress) => Center(
            child: SizedBox(
                width: loadingIndicatorSize,
                height: loadingIndicatorSize,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  value: progress.progress,
                  color: loadingIndicatorColor,
                ))));
  }

  Widget _buildImageBase64() {
    try {
      final imageBytes = path.toImageBytes;
      return Image.memory(
        imageBytes,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
      );
    } catch (e) {
      return _buildError();
    }
  }
}
