import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'data_base_manager.g.dart';

class Words extends Table {
  TextColumn get strQuestion => text()();

  TextColumn get strAnswer => text()();

  BoolColumn get isMemorized => boolean().withDefault(Constant(false))();

  @override
  // TODO: implement primaryKey
  Set<Column>? get primaryKey => {strQuestion};
}

@DriftDatabase(tables: [Words])
class DataBaseManager extends _$DataBaseManager {
  DataBaseManager() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 2;

  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.addColumn(words, words.isMemorized);
          }
        },
      );

  Future addWord(Word word) => into(words).insert(word);

  Future<List<Word>> get allWords => select(words).get();

  Future<List<Word>> get unMemorizeWords =>
      (select(words)..where((table) => table.isMemorized.equals(false))).get();

  Future<List<Word>> get sortAllWords =>
      (select(words)..orderBy([(table) => OrderingTerm(expression: table.isMemorized)])).get();

  Future updateWord(Word word) => update(words).replace(word);

  Future deleteWord(Word word) =>
      (delete(words)..where((table) => table.strQuestion.equals(word.strQuestion))).go();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'words.db'));
    return NativeDatabase(file);
  });
}
