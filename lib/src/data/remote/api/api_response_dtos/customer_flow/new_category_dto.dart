import 'package:oraaq/src/domain/entities/category_entity.dart';

class NewCategoryResponseDto {
  final int categoryId;
  final String shortTitle;
  final String description;
  final int sequenceNo;
  final String imageUrl;
  final String promptMessage;
  final String mimeType; // New field
  final String imageBlob; // New field

  NewCategoryResponseDto({
    required this.categoryId,
    required this.shortTitle,
    required this.description,
    required this.sequenceNo,
    required this.imageUrl,
    required this.promptMessage,
    required this.mimeType,
    required this.imageBlob,
  });

  factory NewCategoryResponseDto.fromMap(Map<String, dynamic> map) {
    return NewCategoryResponseDto(
      categoryId: map['category_id'] ?? -1,
      shortTitle: map['short_title'] ?? '',
      description: map['description'] ?? '',
      sequenceNo: map['sequence_no'] ?? -1,
      imageUrl: map['image_url'] ?? '',
      promptMessage: map['prompt_message'] ?? '',
      mimeType: map['mime_type'] ?? '', // Mapping new field
      imageBlob: map['image_blob'] ?? '', // Mapping new field
    );
  }

  static List<NewCategoryResponseDto> fromList(List<dynamic> list) {
    return list.map((item) => NewCategoryResponseDto.fromMap(item)).toList();
  }

  CategoryEntity get toCategoryEntity => CategoryEntity(
        id: categoryId,
        name: shortTitle,
        description: description,
        sequenceNo: sequenceNo,
        imageUrl: imageBlob,
        promptMessage: promptMessage,
      );
}
