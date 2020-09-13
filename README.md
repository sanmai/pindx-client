[![Latest Stable Version](https://poser.pugx.org/sanmai/pindx-client/v/stable)](https://packagist.org/packages/sanmai/pindx-client)
[![Build Status](https://travis-ci.com/sanmai/pindx-client.svg?branch=master)](https://travis-ci.com/sanmai/pindx-client)
[![JSON API](https://img.shields.io/badge/json%20api-live-green.svg)](https://www.postindexapi.ru/)

# Клиент для API справочника почтовых индексов 

Установка делается как обычно.

```
composer require sanmai/pindx-client
```

## Получение данных отделения используя JSON API

```php
$client = new \RussianPostIndex\Client();
$office = $client->getOffice(101000);
```
Возвращает или объект имплементирующий интерфейс `Record`, или, если такого отделения нет, `null`. Нет необходимости как-то отдельно проверять корректность индекса. Если индекса в БД нет, то вернётся `null`.

Конструктор класса `\RussianPostIndex\Client` опционально берёт на вход стандартный [интерфейс клиента Guzzle](http://docs.guzzlephp.org/en/stable/quickstart.html#making-a-request), что позволяет добавить подключение через прокси или поменять используемый сервер, поднять таймауты для соединения.

### Пример использования

```php
<?php
require 'vendor/autoload.php';

$postalCode = 130980;

$client = new \RussianPostIndex\Client();
if ($office = $client->getOffice($postalCode)) {
    var_dump($office->getIndex()); // int(130980)
    var_dump($office->getName()); // string(25) "Москва EMS ММПО"
    var_dump($office->getType()); // string(8) "ММПО"
    var_dump($office->getSuperior()); // int(104040)
    var_dump($office->getRegion()); // string(12) "Москва"
    var_dump($office->getAutonomousRegion()); // string(0) ""
    var_dump($office->getArea()); // string(0) ""
    var_dump($office->getCity()); // string(0) ""
    var_dump($office->getDistrict()); // string(0) ""
    var_dump($office->getDate()->format('Y-m-d')); // string(10) "2017-04-28"
}
```

