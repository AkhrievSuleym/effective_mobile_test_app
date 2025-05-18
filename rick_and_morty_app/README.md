# rick_and_morty_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Тестовое задание для EffectiveMobile

Реализовано два экрана:

1. Главный экран (Список персонажей)
    Отображает список персонажей в виде карточек.
    Карточка персонажа содержит:
    - Изображение персонажа.
    - Имя персонажа.
    - Дополнительные характеристики
    - Сортировка (по имени, по статусу).
2. Экран "Избранное"
    Отображает список избранных персонажей.
    Такие же карточки, как на главном экране.
    Возможность удаления персонажа из избранного.

Навигация - BottomNavigationBar
Дополнительно: 
 - Пагинация: подгрузка новых персонажей на главном экране при скролле.
 - Фавориты сохраняются в базе данных(SharedPreferences).
 - State Management - Bloc
 - API-запросы - REST
 - Чистая архитектура/ SOLID принципы
