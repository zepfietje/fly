import 'dart:io';

import 'package:args/command_runner.dart';

import '../stubs/stubs.dart';
import '../utils/name.dart';

class MakeRepositorySubcommand extends Command {
  @override
  String get name => 'repository';

  @override
  String get description => 'Create a new repository.';

  @override
  void run() async {
    if (argResults.rest.isEmpty) {
      throw UsageException('Missing "name" argument.', usage);
    }

    var name = argResults.rest.first;

    var directoryPath = 'lib/repositories';
    var file = File('$directoryPath/${name.toSnakeCase()}_repository.dart');

    if (await file.exists()) {
      throw Exception('Repository already exists!');
    }

    await Directory(directoryPath).create();
    await file.writeAsString(RepositoryStub(name).filled);

    print('Repository created successfully.');
  }
}
