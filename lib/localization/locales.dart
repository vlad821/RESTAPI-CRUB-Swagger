import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("uk", LocaleData.UK),
];

mixin LocaleData {
  static const String title = 'title';
  static const String titleAdd = 'titleAdd';
  static const String floatingButton = 'floatingbutton';
  static const String description = 'description';
  static const String update = 'update';
  static const String submit = 'submit';
  static const String successUpdate = 'successUpdate';
  static const String failureUpdate = ' failureUpdate';
  static const String successCreation = '  successCreation';
  static const String failureCreation = 'failureCreation';

  static const String editTask = 'editItem';
  static const String addTask = 'addItem';

  static const String delete = 'delete';
  static const String noItems = 'noItems';

  static const Map<String, dynamic> EN = {
    title: 'List of items',
    floatingButton: 'Add item',
    titleAdd: 'Title',
    description: 'Description',
    update: 'Update',
    submit: 'Submit',
    delete: 'Delete',
    noItems: 'No items yet!',
    successUpdate: 'The item was updated',
    failureUpdate: 'Unfortunately, item was NOT updated',
    successCreation: 'Great, item was created',
    failureCreation: 'Unfortunately, item was NOT created',
    editTask: 'Edit Item',
    addTask: 'Add Item',
  };
  static const Map<String, dynamic> UK = {
    title: "Список об'єктів",
    floatingButton: "Додати об'єкт",
    titleAdd: 'Назва',
    description: 'Опис',
    update: 'Оновити',
    delete: 'Видалити',
    submit: 'Підтвердити',
    successUpdate: 'Об`єкт був оновлений',
    failureUpdate: 'На жаль, об`єкт не був оновлений',
    successCreation: 'Об`єкт був створений',
    failureCreation: 'На жаль, об`єкт не був створений',
    editTask: 'Оновити об`єкт',
    addTask: 'Додати завдання',
    noItems: 'Об`єктів ще немає!',
  };
}
