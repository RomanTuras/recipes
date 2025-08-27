import 'package:recipes/features/mixed_entities/domain/models/mixed_entity.dart';

import '../../../../core/constants/database_const.dart';

class Category extends MixedEntity {
  late int? id;
  late String title;
  late int parentId;

  Category({
    this.id,
    required this.title,
    required this.parentId,
  });


  Map<String, dynamic> toMap() {
    return {
      columnTitle: title,
      columnParentCategoryId: parentId,
    };
  }

  Category.fromMap(Map<String, dynamic> map) {
    id = int.parse(map[columnId].toString());
    title = map[columnTitle].toString();
    parentId = int.parse(map[columnParentCategoryId].toString());
  }

}
