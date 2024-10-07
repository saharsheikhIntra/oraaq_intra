import 'package:oraaq/src/domain/entities/category_entity.dart';

// class CategoryResponseDto {
//   final int id;
//   final String name;

//   CategoryResponseDto({
//     required this.id,
//     required this.name,
//   });

//   factory CategoryResponseDto.fromMap(Map<String, dynamic> map) {
//     return CategoryResponseDto(
//       id: map['Category_ID'] ?? -1,
//       name: map['Category_Name'] ?? '',
//     );
//   }

//   CategoryEntity get toCategoryEntity => CategoryEntity(id: id, name: name);
// }

class CategoryResponseDto {
  final int categoryId;
  final String shortTitle;
  final String description;
  final int sequenceNo;
  final String imageUrl;
  final String promptMessage;

  CategoryResponseDto({
    required this.categoryId,
    required this.shortTitle,
    required this.description,
    required this.sequenceNo,
    required this.imageUrl,
    required this.promptMessage,
  });

  factory CategoryResponseDto.fromMap(Map<String, dynamic> map) {
    return CategoryResponseDto(
      categoryId: map['category_id'] ?? -1,
      shortTitle: map['short_title'] ?? '',
      description: map['description'] ?? '',
      sequenceNo: map['sequence_no'] ?? -1,
      imageUrl: map['image_url'] ?? '',
      promptMessage: map['prompt_message'] ?? '',
    );
  }

  CategoryEntity get toCategoryEntity => CategoryEntity(
        id: categoryId,
        name: shortTitle,
        description: description,
        sequenceNo: sequenceNo,
        imageUrl: imageUrl,
        promptMessage: promptMessage,
      );
}
