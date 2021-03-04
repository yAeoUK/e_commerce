import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/infrastructure/category/category_factory.dart';

import 'infrastructure/category_repository.dart';
import 'infrastructure/note_repository.dart';

void main() {
  final repository = CategoryRepository();
  final noteRepository = NoteRepository();

  final app = CategoryAppService(
    factory: const CategoryFactory(),
    repository: repository,
    noteRepository: noteRepository,
  );

  group('Category', () {
    test('registering existing name should fail', () async {
      noteRepository.clear();
      repository.clear();

      await app.saveCategory(name: 'category name');

      bool isSuccessful = true;
      try {
        await app.saveCategory(name: 'category name');
      } catch (e) {
        if (e.runtimeType == NotUniqueException) {
          isSuccessful = false;
        }
      }

      expect(isSuccessful, false);
    });

    test('new category should be registered', () async {
      repository.clear();
      noteRepository.clear();

      await app.saveCategory(name: 'category name');

      final categories = await app.getCategoryList();
      expect(categories.length, 1);
    });

    test('update without change should be successful', () async {
      repository.clear();
      noteRepository.clear();

      await app.saveCategory(name: 'category name');

      final categories = await app.getCategoryList();

      bool isSuccessful = true;
      try {
        await app.updateCategory(
          id: categories[0].id,
          name: 'category name',
        );
      } catch (_) {
        isSuccessful = false;
      }

      expect(isSuccessful, true);
    });

    test('category should be removed', () async {
      repository.clear();
      noteRepository.clear();

      await app.saveCategory(name: 'category name');

      final categories = await app.getCategoryList();
      await app.removeCategory(categories[0].id);

      expect(await app.getCategoryList(), isEmpty);
    });
  });
}
