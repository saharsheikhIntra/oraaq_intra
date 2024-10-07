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

class CategoryEntity {
  final int id;
  final String name;
  final String description;
  final int sequenceNo;
  final String imageUrl;
  final String promptMessage;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.sequenceNo,
    required this.imageUrl,
    required this.promptMessage,
  });

  CategoryEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? sequenceNo,
    String? imageUrl,
    String? promptMessage,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sequenceNo: sequenceNo ?? this.sequenceNo,
      imageUrl: imageUrl ?? this.imageUrl,
      promptMessage: promptMessage ?? this.promptMessage,
    );
  }

  @override
  String toString() =>
      'CategoryEntity(id: $id, name: $name, description: $description, sequenceNo: $sequenceNo, imageUrl: $imageUrl, promptMessage: $promptMessage)';

  @override
  bool operator ==(covariant CategoryEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.sequenceNo == sequenceNo &&
        other.imageUrl == imageUrl &&
        other.promptMessage == promptMessage;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      sequenceNo.hashCode ^
      imageUrl.hashCode ^
      promptMessage.hashCode;
}
