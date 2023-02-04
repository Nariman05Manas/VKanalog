# VKanalog
### Установка
1. brew install carthage 
2. В папке проекта выполнить
- Carthage update --platform ios --use-xcframeworks

Для работы приложения необходимо создать Standalone-приложение тут https://vk.com/apps?act=manage

ID приложения необходимо поместить в info.plist, а так же в конфиг Services\API.swift
___
### Стэк
1. API: SDK VK
2. Верстка: [Tiny Constraints](https://github.com/roberthein/TinyConstraints)
3. Архитектура - Clean Swift
4. RealmSwift
___
### Реализованные функции
1. API: SDK VK.
-
![imgonline-com-ua-Resize-7zJ37cPSWk](https://user-images.githubusercontent.com/91676796/216775675-d18f25d6-4788-4487-8e52-67a6c532f8e4.jpg)
___
2. Лента новостей пользователя.
- На данный момент поддерживаются посты с текстом и фотографиями. Если пост содержит несколько фотографий - в приложении отображается только первое.
- Сохранение последнего просмотренного поста (при перезагрузке приложения на экране показывает пост, на котором пользователь остановился).
- Подсветка наличия непрочитанных постов.
- Кнопка "лайк" - при нажатии на нее в пост добавляется/убирается лайк и пост добавляется/удаляется в/из раздел(а) Избранное.
- 
![imgonline-com-ua-Resize-hj1FnZpgaLIcwP (1)](https://user-images.githubusercontent.com/91676796/216776919-e7aa6b82-29ed-4958-b94c-670e5e6fb885.jpg)
![imgonline-com-ua-Resize-dNqdP6fQkno](https://user-images.githubusercontent.com/91676796/216776960-d94a69c3-6daa-44e8-99d5-6c6b99ccd7b9.jpg)
___
3. Страница профиля пользователя.
- На данный момент поддерживаются только 2 типа постов: пост с текстом и пост с 1 фотографией и текстом.
- Обновление данных происходит при каждом открытии раздела Профиль.
- При нажатии на "плашку" фотографий открывается весь список фото.
- 
![imgonline-com-ua-Resize-7BhtV9PXZFADqT](https://user-images.githubusercontent.com/91676796/216776206-33aba036-986d-4b30-b94a-3cb222afdf84.jpg)
![imgonline-com-ua-Resize-e1UrVjam5qpm56](https://user-images.githubusercontent.com/91676796/216776278-48f53ae8-aefb-4e5d-bd5f-bfda970d2a07.jpg)
___
4. Раздел Избранное.
- при удалении "лайка" с поста, он автоматически удаляется из Избранного.
-
![imgonline-com-ua-Resize-WEgXiApIus51cXrf](https://user-images.githubusercontent.com/91676796/216776327-82204988-0e88-4484-9eb2-e2173f661561.jpg)
