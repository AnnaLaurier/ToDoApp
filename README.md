# ToDoApp

Тестовое задание:
Необходимо разработать простое приложение для ведения списка дел (ToDo List) с возможностью добавления, редактирования, удаления задач.

## Требования:
### 1. Список задач:
- [x] Отображение списка задач на главном экране.
- [x] Задача должна содержать название, описание, дату создания и статус (выполнена/не выполнена).
- [ ] Возможность добавления новой задачи.
- [x] Возможность редактирования существующей задачи.
- [x] Возможность удаления задачи.
- [ ] Возможность поиска по задачам.

### 2. Загрузка списка задач
- [x] Загрузка из dummyjson api: https://dummyjson.com/todos. При первом запуске приложение должно загрузить список задач из указанного json api.

### 3. Многопоточность:
- [x] Обработка создания, загрузки, редактирования, удаления и поиска задач должна выполняться в фоновом потоке с использованием GCD или NSOperation.
- [x] Интерфейс не должен блокироваться при выполнении операций.

### 4. CoreData:
- [x] Данные о задачах должны сохраняться в CoreData.
- [x] Приложение должно корректно восстанавливать данные при повторном запуске.

### 5. Git
- [x] Используйте систему контроля версий GIT для разработки.

### 6. Unit-тесты
- [x] Напишите unit-тесты для основных компонентов приложения.

## Будет бонусом:
### 7. Архитектура VIPER
- [x] Приложение должно быть построено с использованием архитектуры VIPER. Каждый модуль должен быть четко разделен на компоненты: View, Interactor, Presenter, Entity, Router.

[Дизайн Figma](https://www.figma.com/design/ElcIDP3PIp5iOE4dCtPGmd/Задачи?node-id=0-1&node-type=canvas&t=1uqFEd8nag96yTmM-0)

