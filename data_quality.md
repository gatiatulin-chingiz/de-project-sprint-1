# 1.3. Качество данных

## Оцените, насколько качественные данные хранятся в источнике.
Проверил все таблицы на наличие дублей через COUNT() И COUNT(DISTINCT()). Сгенерировал DDL посмотреть какие инструменты по обеспечению качества данных добавлены в таблицы.

## Укажите, какие инструменты обеспечивают качество данных в источнике.
Ответ запишите в формате таблицы со следующими столбцами:
- `Наименование таблицы` - наименование таблицы, объект которой рассматриваете.
- `Объект` - Здесь укажите название объекта в таблице, на который применён инструмент. Например, здесь стоит перечислить поля таблицы, индексы и т.д.
- `Инструмент` - тип инструмента: первичный ключ, ограничение или что-то ещё.
- `Для чего используется` - здесь в свободной форме опишите, что инструмент делает.

| Таблицы                   | Объект                                    | Инструмент | Для чего используется                              |
| ---------------------     | ----------------------------------------- | -----------| -------------------------------------------------  |
| production.orderitems     | id int NOT NULL GENERATED ALWAYS NO CYCLE | Проверка   | Проверка на NAN, постоянную генерацияю, зацикленн. |
| production.orderitems     | product_id NOT NULL                       | Проверка   | Проверка на NAN                                    |
| production.orderitems     | order_id NOT NULL                         | Проверка   | Проверка на NAN                                    |
| production.orderitems     | name NOT NULL                             | Проверка   | Проверка на NAN                                    |
| production.orderitems     | discount NOT NULL DEFAULT 0               | Проверка   | Проверка на NAN                                    |
| production.orderitems     | quantity NOT NULL                         | Проверка   | Проверка на NAN                                    |
| production.orderitems     | discount CHECK                            | Проверка   | Чек на discount > 0 и discount <= price            |
| production.orderitems     | order_id, product_id Unique               | Проверка   | Чек на уникальность                                |
| production.orderitems     | id PRIMARY KEY                            | Проверка   | Обеспечивает уникальность записей о пользователях  |
| production.orderitems     | price                                     | Проверка   | Ввод ограничений для данных                        |
| production.orderitems     | quantity                                  | Проверка   | Чек на quantity > 0                                |
| production.orders         | order_id NOT NULL                         | Проверка   | Проверка на NAN                                    |
| production.orders         | order_ts NOT NULL                         | Проверка   | Проверка на NAN                                    |
| production.orders         | user_id NOT NULL                          | Проверка   | Проверка на NAN                                    |
| production.orders         | bonus_payment NOT NULL                    | Проверка   | Проверка на NAN                                    |
| production.orders         | payment NOT NULL                          | Проверка   | Проверка на NAN                                    |
| production.orders         | cost NOT NULL                             | Проверка   | Проверка на NAN                                    |
| production.orders         | bonus_grant NOT NULL                      | Проверка   | Проверка на NAN                                    |
| production.orders         | status NOT NULL                           | Проверка   | Проверка на NAN                                    |
| production.orders         | cost CHECK                                | Проверка   | Чек на cost = (payment + bonus_payment             |
| production.orders         | orders_pkey PRIMARY KEY                   | Проверка   | Обеспечивает уникальность записей о пользователях  |
| production.orderstatuses  | id NOT NULL                               | Проверка   | Проверка на NAN                                    |
| production.orderstatuses  | key NOT NULL                              | Проверка   | Проверка на NAN                                    |
| production.orderstatuses  | CONSTRAINT PRIMARY KEY                    | Проверка   | Обеспечивает уникальность записей о пользователях  |
| production.orderstatuslog | id int NOT NULL GENERATED ALWAYS NO CYCLE | Проверка   | Проверка на NAN, постоянную генерацияю, зацикленн. |
| production.orderstatuslog | order_id NOT NULL                         | Проверка   | Проверка на NAN                                    |
| production.orderstatuslog | status_id NOT NULL                        | Проверка   | Проверка на NAN                                    |
| production.orderstatuslog | dttm NOT NULL                             | Проверка   | Проверка на NAN                                    |
| production.orderstatuslog | order_id, status_id UNIQUE                | Проверка   | Проверка на уникальность                           |
| production.orderstatuslog | id PRIMARY KEY                            | Проверка   | Обеспечивает уникальность записей о пользователях  |
| production.orderstatuslog | dttm NOT NULL                             | Проверка   | Проверка на NAN                                    |
| production.products       | id NOT NULL                               | Проверка   | Проверка на NAN                                    |
| production.products       | name NOT NULL                             | Проверка   | Проверка на NAN                                    |
| production.products       | price NOT NULL                            | Проверка   | Проверка на NAN                                    |
| production.products       | id PRIMARY KEY                            | Проверка   | Обеспечивает уникальность записей о пользователях  |
| production.products       | price CHECK                               | Проверка   | Чек на price >= 0                                  |
| production.users          | id PRIMARY KEY                            | Проверка   | Обеспечивает уникальность записей о пользователях  |
| production.users          | name NOT NULL                             | Проверка   | Проверка на NAN                                    |
| production.users          | login NOT NULL                            | Проверка   | Проверка на NAN                                    |
| production.users          | id   NOT NULL                             | Проверка   | Проверка на NAN                                    |