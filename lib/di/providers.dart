import 'package:my_own_flashcards/model/db/data_base_manager.dart';
import 'package:my_own_flashcards/view_model/edit_screen_view_model.dart';
import 'package:my_own_flashcards/view_model/home_screen_view_model.dart';
import 'package:my_own_flashcards/view_model/test_screen_view_model.dart';
import 'package:my_own_flashcards/view_model/word_list_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<DataBaseManager>(create: (context) => DataBaseManager()),
];

List<SingleChildWidget> dependentModels = [

];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeScreenViewModel>(create: (context) => HomeScreenViewModel()),
  ChangeNotifierProvider<TestScreenViewModel>(
    create: (context) => TestScreenViewModel(
      dataBaseManager: context.read<DataBaseManager>(),
    ),
  ),
  ChangeNotifierProvider<WordListScreenViewModel>(
    create: (context) => WordListScreenViewModel(
      dataBaseManager: context.read<DataBaseManager>(),
    ),
  ),
  ChangeNotifierProvider<EditScreenViewModel>(
    create: (context) => EditScreenViewModel(
      dataBaseManager: context.read<DataBaseManager>(),
    ),
  ),
];
