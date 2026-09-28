# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Язык

- Общайся с пользователем на русском языке.
- Все комментарии в коде пиши на русском.
- Тексты для пользователя (алерты, подписи, ошибки) — на русском.
- Сообщения коммитов — на русском.
- Имена типов, переменных и функций — на английском, в существующем стиле проекта.

## Проект

iOS-приложение для сотрудников компании (UIKit, iOS 14+). Разделы: лента новостей, отпуска, зарплата, транспорт и карта автобусов, карта лояльности, меню ресторана, чат с HR, список компетенций, Сбер Здоровье (ДМС).

## Сборка и запуск

Собирать и запускать через Xcode (или через xcode-tools `BuildProject` / `RunProject`). Есть две общие схемы:

| Схема | Конфигурация Run | Сервер |
|---|---|---|
| `remitApp_main_test` | Debug | тестовый (`roadServer.test*`) |
| `remitApp_main` | Release | боевой (`roadServer.prod*`) |

Сервер выбирается при компиляции через `#if DEBUG` в каждой Model. При разработке используй `remitApp_main_test`, чтобы не обращаться к боевому серверу.

Тестовых таргетов и линтера нет.

Зависимости SPM: SnapKit (вёрстка), RealmSwift (хранилище), MessageKit + InputBarAccessoryView (интерфейс чата).

## Секреты

Папка `remitApp_main/SecretModule/` исключена из git (`.gitignore`). В ней лежат:
- `NetworkManager` — синглтон `NetworkManager.shared` с методом `universalRequstPost(jsonRequest:url:completion:)`;
- enum `roadServer` с адресами серверов.

Не выводи её содержимое, не перемещай и не коммить. Без неё свежий клон не соберётся.

## Архитектура

**Навигация — координаторы, без storyboard.** Storyboard используется только для экрана запуска.
- `SceneDelegate` → `AppCoordinator.start()` показывает `LaunchScreenVC`.
- Экран запуска вызывает `showLoginVC()` или `showHomeScreenVC()`. Оба метода делают корневым общий `UINavigationController`.
- `LoginCoordinator` → `LoginVC`, `MainCoordinator` → `HomeScreenVC`.
- Плитки главного экрана соответствуют `enum ButtonName` (`HomeScreenModel.swift`) через `tag`/rawValue кнопки.
- `MainCoordinator.openChildVC(typeVC:userRealm:completion:)` — единая точка перехода на экраны разделов:
  - для экранов с данными с сервера (зарплата, лояльность, ресторан) координатор сначала загружает данные, а потом открывает VC и передаёт данные в его инициализатор;
  - если пользователь не авторизован (`userRealm == nil`), подставляется ответ-заглушка.
- Новый раздел = новый case в `ButtonName` + ветка в `openChildVC`.

**Структура модуля** (`Interface/<name>Module/`):
- `…Model` — сеть и бизнес-логика;
- `…View` — наследник `UIView`, вёрстка кодом через SnapKit;
- `…VC` — загружает View и связывает действия;
- кастомные ячейки.

Многие типы названы с маленькой буквы (`salaryVC`, `transortVC`, `realmManager`). При обращении к ним сохраняй существующие имена.

**Сетевой запрос** (одинаковый порядок во всех Model):
1. Взять UUID пользователя из 1С в Realm: `realmManager().fetchUUID1C()`.
2. Закодировать запрос, обычно `uneversalRequestScheme(UUIDUser:methodName:)`. `methodName` выбирает метод на бэкенде.
3. Вызвать `NetworkManager.shared.universalRequstPost`.
4. Если статус не 200 — декодировать `errorResponceScheme`.
5. Иначе декодировать схему ответа из `JsonModule/*JsonScheme.swift`. В ответах есть поля `result: Bool` и `error`.

Ошибки показываются пользователю через `CustomAlert().showFastAlertError(textError:)`. Даты с бэкенда (`yyyy-MM-dd'T'HH:mm:ss`, UTC) разбирай через `CustomDecoder().getCustomDecoder()`. Асинхронный код написан на completion-хендлерах (без async/await и Combine).

**Хранилище — Realm, только через `StorageModule/realmManager.swift`.**
- Модели объектов — в `realmModels.swift`. Корневой объект пользователя — `InformationUserRealm` (новости, отпуска, история чата, ДМС и т.д.).
- Версия схемы и миграции задаются в lazy-свойстве `Realm.Configuration` внутри `realmManager`.
- **При изменении любой Realm-модели увеличь `schemaVersion` и добавь блок миграции `if oldSchemaVersion < N`.**

**Общие UI-компоненты** лежат в `CustomObjects/`: кнопки, стеки, date picker, алерты, хелперы устройства, цвета. `CustomColor` ссылается на `Assets.xcassets/customColor`.

## Подводные камни

- В исходниках есть случайные дубликаты файлов с временной меткой в имени (например, `MainCoordinator.swift 22-27-01-571.swift`, `settingVC.swift 22-27-01-553.swift`). Ещё в `remitApp_main/` лежат отдельные `.svg`/`.png`. Это артефакты копирования, а не рабочий код. Редактируй файл без суффикса.
- `pageDevelopmentVC` — заглушка «в разработке» для недоделанных плиток.
