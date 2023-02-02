# VKanalog
### Установка
1. brew install carthage 
2. В папке проекта выполнить
- Carthage update --platform ios --use-xcframeworks

Для работы приложения необходимо создать Standalone-приложение тут https://vk.com/apps?act=manage

ID приложения необходимо поместить в info.plist, а так же в конфиг Services\API.swift

### Стэк
1. API: SDK VK
2. Верстка: [Tiny Constraints](https://github.com/roberthein/TinyConstraints)
3. Архитектура - Clean Swift (VIP)
4. RealmSwift

### Реализованные функции
1. Лента новостей пользователя.
- На данный момент поддерживаются посты с текстом и фотографиями. Если пост содержит несколько фотографий - в приложении отображается только первое.
- Сохранение последнего просмотренного поста (при перезагрузке приложения на экране показывает пост, на котором пользователь остановился).
- Подсветка наличия непрочитанных постов.
- Кнопка "лайк" - при нажатии на нее в пост добавляется/убирается лайк и пост добавляется/удаляется в/из раздел(а) Избранное.
- ![Simulator Screen Shot - iPhone 11 - 2023-02-02 at 14 13 05](https://user-images.githubusercontent.com/91676796/216323449-b592638e-51e0-460c-8e0c-1ec1851b5aa6.png)


2. Страница профиля пользователя.
- На данный момент поддерживаются только 2 типа постов: пост с текстом и пост с 1 фотографией и текстом.
- Обновление данных происходит при каждом открытии раздела Профиль.
- При нажатии на "плашку" фотографий открывается весь список фото.
- 
![Simulator Screen Shot - iPhone 11 - 2023-02-02 at 14 19 48](https://user-images.githubusercontent.com/91676796/216325225-ff423db4-5eb8-48cd-afd5-62d0413c39c8.png)
![Simulator Screen Shot - iPhone 11 - 2023-02-02 at 15 28 16](https://user-images.githubusercontent.com/91676796/216325234-adabef57-874a-4061-b4bb-ea4660106b4c.png)


3. Раздел Избранное.
- при удалении "лайка" с поста, он автоматически удаляется из Избранного.
-
![Simulator Screen Shot - iPhone 11 - 2023-02-02 at 14 13 05](https://user-images.githubusercontent.com/91676796/216325739-c6c3a721-0bf1-4fb7-8c05-139470510143.png)

4. API: SDK VK.
-
![Simulator Screen Shot - iPhone 11 - 2023-02-02 at 15 27 40](https://user-images.githubusercontent.com/91676796/216325936-4201281f-bce7-456f-bd7f-d40d8b7e7fd4.png)

