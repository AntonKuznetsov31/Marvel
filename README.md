**Marvel**
=====

В данном приложении я использую API предоставленный Marvel, чтобы вывести на экран список героев вселенной Marvel.

![characters](https://github.com/AntonKuznetsov31/Marvel/blob/master/Screenshots/IMG_2593.png)

Согласно требованиям Marvel, чтобы отправить запрос к их API необходимо наряду с уникальным ключем предоставить значение хэш-функции, созданное с помощью приватного и публичного ключей, а также времени в секундах с 1970 года.

В классе NetworkManager я использую библиотеку **CommonCrypto**, чтобы получить необходимую хэш-функцию. Для сетевого запроса в этом классе использую библиотеку **Alamofire**.

Для подгрузки изображений персонажей использую класс ImageView, в котором реализовал кэширование изображений с помощью **URLCache**, чтобы они подгружались корректно при быстром скроллинге. Для сетевого запроса использую **URLSession**.

В классе Character реализована работа с **JSON**, который возвращает нам Marvel.
