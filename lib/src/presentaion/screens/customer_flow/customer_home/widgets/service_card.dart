import 'dart:convert';
import 'dart:developer';

import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/widgets/image_widget.dart';

class ServiceCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback onTap;
  // final Map<String, String> categoryImageMap = {
  //   'Mechanic': AssetConstants.serviceImage4,
  //   'AC Service': AssetConstants.serviceImage3,
  //   'Catering': AssetConstants.serviceImage2,
  //   'Salon': AssetConstants.serviceImage1,
  //   // static image temporary need to remove and use blob image
  // };
  ServiceCard({
    super.key,
    required this.category,
    required this.onTap,
  });
  ImageProvider<Object> _getImageFromBlob(String? blobData) {
    if (blobData == null || blobData.isEmpty) {
      return AssetImage(AssetConstants.services1); // Fallback image
    }
    try {
      return MemoryImage(base64Decode(blobData));
    } catch (e) {
      return AssetImage(AssetConstants.services1); // Handle invalid BLOB
    }
  }

  @override
  Widget build(BuildContext context) {
    // String assetImagePath =
    //     categoryImageMap[category.name] ?? AssetConstants.services1;
    log('catBlob: ${category.imageUrl}');
    return InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: _getImageFromBlob(category.imageUrl), // Using BLOB
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // ImageWidget(
            //   // assetImagePath,

            //   // category.imageUrl,
            //   borderRadius: 12,
            //   height: 180,
            //   width: double.infinity,
            //   type: ImageType.asset,
            // ),
            Ink(
                height: 180,
                padding: 24.allPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: ColorTheme.neutral1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      // const Icon(
                      //   Symbols.face_2_rounded,
                      //   size: 32,
                      // ),
                      12.horizontalSpace,
                      Text(
                        category.name,
                        style: TextStyleTheme.headlineSmall,
                      ),
                    ]),
                    16.verticalSpace,
                    SizedBox(
                        width: ScreenUtil().screenWidth * 0.5,
                        child: Text(
                          category.description,
                          style: TextStyleTheme.bodyMedium
                              .copyWith(fontWeight: FontWeight.w400),
                        )),
                    const Spacer(),
                    const Icon(
                      Symbols.arrow_forward_rounded,
                      size: 24,
                    ),
                  ],
                )),
          ],
        ));
  }
}
