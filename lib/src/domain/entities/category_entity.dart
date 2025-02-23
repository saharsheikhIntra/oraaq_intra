// class CategoryEntity {
//   final int id;
//   final String name;

//   CategoryEntity({
//     required this.id,
//     required this.name,
//   });

//   CategoryEntity copyWith({
//     int? id,
//     String? name,
//   }) {
//     return CategoryEntity(
//       id: id ?? this.id,
//       name: name ?? this.name,
//     );
//   }

//   @override
//   String toString() => 'Category(id: $id, name: $name)';

//   @override
//   bool operator ==(covariant CategoryEntity other) {
//     if (identical(this, other)) return true;

//     return other.id == id && other.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

// class CategoryEntity {
//   final int id;
//   final String name;
//   final String description;
//   final int sequenceNo;
//   final String imageUrl;
//   final String promptMessage;

//   CategoryEntity({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.sequenceNo,
//     required this.imageUrl,
//     required this.promptMessage,
//   });

//   CategoryEntity copyWith({
//     int? id,
//     String? name,
//     String? description,
//     int? sequenceNo,
//     String? imageUrl,
//     String? promptMessage,
//   }) {
//     return CategoryEntity(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       sequenceNo: sequenceNo ?? this.sequenceNo,
//       imageUrl: imageUrl ?? this.imageUrl,
//       promptMessage: promptMessage ?? this.promptMessage,
//     );
//   }

//   @override
//   String toString() =>
//       'CategoryEntity(id: $id, name: $name, description: $description, sequenceNo: $sequenceNo, imageUrl: $imageUrl, promptMessage: $promptMessage)';

//   @override
//   bool operator ==(covariant CategoryEntity other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.name == name &&
//         other.description == description &&
//         other.sequenceNo == sequenceNo &&
//         other.imageUrl == imageUrl &&
//         other.promptMessage == promptMessage;
//   }

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       name.hashCode ^
//       description.hashCode ^
//       sequenceNo.hashCode ^
//       imageUrl.hashCode ^
//       promptMessage.hashCode;
// }

class CategoryEntity {
  final int id;
  final String name;
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
  final List<LinkEntity> links;

  CategoryEntity({
    required this.id,
    required this.name,
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

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['category_id'] ?? -1,
      name: map['short_title'] ?? '',
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
          ? List<LinkEntity>.from(
              map['links'].map((x) => LinkEntity.fromMap(x)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': id,
      'short_title': name,
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

  CategoryEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? sequenceNo,
    String? imageUrl,
    String? promptMessage,
    String? mimeType,
    String? imageBlob,
    bool? hasMore,
    int? limit,
    int? offset,
    int? count,
    List<LinkEntity>? links,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sequenceNo: sequenceNo ?? this.sequenceNo,
      imageUrl: imageUrl ?? this.imageUrl,
      promptMessage: promptMessage ?? this.promptMessage,
      mimeType: mimeType ?? this.mimeType,
      imageBlob: imageBlob ?? this.imageBlob,
      hasMore: hasMore ?? this.hasMore,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      count: count ?? this.count,
      links: links ?? this.links,
    );
  }

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, description: $description, sequenceNo: $sequenceNo, imageUrl: $imageUrl, promptMessage: $promptMessage, mimeType: $mimeType, imageBlob: $imageBlob, hasMore: $hasMore, limit: $limit, offset: $offset, count: $count, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryEntity &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.sequenceNo == sequenceNo &&
        other.imageUrl == imageUrl &&
        other.promptMessage == promptMessage &&
        other.mimeType == mimeType &&
        other.imageBlob == imageBlob &&
        other.hasMore == hasMore &&
        other.limit == limit &&
        other.offset == offset &&
        other.count == count &&
        other.links == links;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        sequenceNo.hashCode ^
        imageUrl.hashCode ^
        promptMessage.hashCode ^
        mimeType.hashCode ^
        imageBlob.hashCode ^
        hasMore.hashCode ^
        limit.hashCode ^
        offset.hashCode ^
        count.hashCode ^
        links.hashCode;
  }
}

class LinkEntity {
  final String rel;
  final String href;

  LinkEntity({required this.rel, required this.href});

  factory LinkEntity.fromMap(Map<String, dynamic> map) {
    return LinkEntity(
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

  @override
  String toString() => 'LinkEntity(rel: $rel, href: $href)';
}
