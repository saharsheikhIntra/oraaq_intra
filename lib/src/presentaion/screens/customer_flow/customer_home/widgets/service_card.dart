import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/widgets/image_widget.dart';

class ServiceCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback onTap;
  const ServiceCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Stack(
          children: [
            ImageWidget(
              category.imageUrl,
              borderRadius: 12,
              height: 180,
              width: double.infinity,
              type: ImageType.network,
            ),
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
                      const Icon(
                        Symbols.face_2_rounded,
                        size: 32,
                      ),
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
                          style: TextStyleTheme.bodyMedium.copyWith(fontWeight: FontWeight.w400),
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
