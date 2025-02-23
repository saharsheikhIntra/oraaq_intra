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

// class CategoryResponseDto {
//   final int categoryId;
//   final String shortTitle;
//   final String description;
//   final int sequenceNo;
//   final String imageUrl;
//   final String promptMessage;

//   CategoryResponseDto({
//     required this.categoryId,
//     required this.shortTitle,
//     required this.description,
//     required this.sequenceNo,
//     required this.imageUrl,
//     required this.promptMessage,
//   });

//   factory CategoryResponseDto.fromMap(Map<String, dynamic> map) {
//     return CategoryResponseDto(
//       categoryId: map['category_id'] ?? -1,
//       shortTitle: map['short_title'] ?? '',
//       description: map['description'] ?? '',
//       sequenceNo: map['sequence_no'] ?? -1,
//       imageUrl: map['image_url'] ?? '',
//       promptMessage: map['prompt_message'] ?? '',
//     );
//   }

//   CategoryEntity get toCategoryEntity => CategoryEntity(
//         id: categoryId,
//         name: shortTitle,
//         description: description,
//         sequenceNo: sequenceNo,
//         imageUrl: imageUrl,
//         promptMessage: promptMessage,
//       );
// }


// class CategoryResponseDto {
//   final int categoryId;
//   final String shortTitle;
//   final String description;
//   final int sequenceNo;
//   final String imageUrl;
//   final String promptMessage;
//   final String mimeType;
//   final String imageBlob;

//   CategoryResponseDto({
//     required this.categoryId,
//     required this.shortTitle,
//     required this.description,
//     required this.sequenceNo,
//     required this.imageUrl,
//     required this.promptMessage,
//     required this.mimeType,
//     required this.imageBlob,
//   });

//   factory CategoryResponseDto.fromMap(Map<String, dynamic> map) {
//     return CategoryResponseDto(
//       categoryId: map['category_id'] ?? -1,
//       shortTitle: map['short_title'] ?? '',
//       description: map['description'] ?? '',
//       sequenceNo: map['sequence_no'] ?? -1,
//       imageUrl: map['image_url'] ?? '',
//       promptMessage: map['prompt_message'] ?? '',
//       mimeType: map['mime_type'] ?? '',
//       imageBlob: map['image_blob'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'category_id': categoryId,
//       'short_title': shortTitle,
//       'description': description,
//       'sequence_no': sequenceNo,
//       'image_url': imageUrl,
//       'prompt_message': promptMessage,
//       'mime_type': mimeType,
//       'image_blob': imageBlob,
//     };
//   }

//   CategoryEntity get toCategoryEntity => CategoryEntity(
//         id: categoryId,
//         name: shortTitle,
//         description: description,
//         sequenceNo: sequenceNo,
//         imageUrl: imageUrl,
//         promptMessage: promptMessage,
//         mimeType: mimeType,
//         imageBlob: imageBlob,
//       );
// }


class CategoryResponseDto {
  final int categoryId;
  final String shortTitle;
  final String description;
  final int sequenceNo;
  final String imageUrl;
  final String promptMessage;
  final String mimeType;
  final String imageBlob;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;
  final List<LinkDto> links;

  CategoryResponseDto({
    required this.categoryId,
    required this.shortTitle,
    required this.description,
    required this.sequenceNo,
    required this.imageUrl,
    required this.promptMessage,
    required this.mimeType,
    required this.imageBlob,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
    required this.links,
  });

  factory CategoryResponseDto.fromMap(Map<String, dynamic> map) {
    return CategoryResponseDto(
      categoryId: map['category_id'] ?? -1,
      shortTitle: map['short_title'] ?? '',
      description: map['description'] ?? '',
      sequenceNo: map['sequence_no'] ?? -1,
      imageUrl: map['image_url'] ?? '',
      promptMessage: map['prompt_message'] ?? '',
      mimeType: map['mime_type'] ?? '',
      imageBlob: map['image_blob'] ?? '',
      hasMore: map['hasMore'] ?? false,
      limit: map['limit'] ?? 0,
      offset: map['offset'] ?? 0,
      count: map['count'] ?? 0,
      links: map['links'] != null
          ? List<LinkDto>.from(map['links'].map((x) => LinkDto.fromMap(x)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'short_title': shortTitle,
      'description': description,
      'sequence_no': sequenceNo,
      'image_url': imageUrl,
      'prompt_message': promptMessage,
      'mime_type': mimeType,
      'image_blob': imageBlob,
      'hasMore': hasMore,
      'limit': limit,
      'offset': offset,
      'count': count,
      'links': links.map((x) => x.toMap()).toList(),
    };
  }

  CategoryEntity get toCategoryEntity => CategoryEntity(
        id: categoryId,
        name: shortTitle,
        description: description,
        sequenceNo: sequenceNo,
        imageUrl: imageUrl,
        promptMessage: promptMessage,
        mimeType: mimeType,
        imageBlob: imageBlob,
        hasMore: hasMore,
        limit: limit,
        offset: offset,
        count: count,
        links: links.map((e) => e.toLinkEntity).toList(),
      );
}

class LinkDto {
  final String rel;
  final String href;

  LinkDto({required this.rel, required this.href});

  factory LinkDto.fromMap(Map<String, dynamic> map) {
    return LinkDto(
      rel: map['rel'] ?? '',
      href: map['href'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rel': rel,
      'href': href,
    };
  }

  LinkEntity get toLinkEntity => LinkEntity(
        rel: rel,
        href: href,
      );
}
