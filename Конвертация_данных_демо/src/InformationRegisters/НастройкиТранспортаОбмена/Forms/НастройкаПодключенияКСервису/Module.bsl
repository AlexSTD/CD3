
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиСервер.ПроверитьВозможностьАдминистрированияОбменов();
	
	УстановитьПривилегированныйРежим(Истина);
	
	АдресДляВосстановленияПароляУчетнойЗаписи = Параметры.АдресДляВосстановленияПароляУчетнойЗаписи;
	НастройкаАвтоматическойСинхронизации = Параметры.НастройкаАвтоматическойСинхронизации;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
		Элементы.ПараметрыДоступаВИнтернет.Видимость = Истина;
	Иначе
		Элементы.ПараметрыДоступаВИнтернет.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ПустаяСтрока(Запись.WSИмяПользователя) Тогда
		
		Пользователь = Пользователи.НайтиПоИмени(Запись.WSИмяПользователя);
		
	КонецЕсли;
	
	Для Каждого ПользовательСинхронизации Из ПользователиСинхронизацииДанных() Цикл
		
		Элементы.Пользователь.СписокВыбора.Добавить(ПользовательСинхронизации.Пользователь, ПользовательСинхронизации.Представление);
		
	КонецЦикла;
	
	Элементы.ЗабылиПароль.Видимость = Не ПустаяСтрока(АдресДляВосстановленияПароляУчетнойЗаписи);
	
	Если ЗначениеЗаполнено(Запись.Узел) Тогда
		Пароль = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Запись.Узел, "WSПароль", Истина);
		WSПароль = ?(ЗначениеЗаполнено(Пароль), ЭтотОбъект.УникальныйИдентификатор, "");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ПроверитьПодключениеКСервису(Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если НастройкаАвтоматическойСинхронизации Тогда
		
		Оповестить("Запись_НастройкиТранспортаОбмена",
			Новый Структура("НастройкаАвтоматическойСинхронизации"));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.WSЗапомнитьПароль = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура WSПарольПриИзменении(Элемент)
	WSПарольИзменен = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗабылиПароль(Команда)
	
	ОбменДаннымиКлиент.ОткрытьИнструкциюКакИзменитьПарольСинхронизацииДанных(АдресДляВосстановленияПароляУчетнойЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыДоступаВИнтернет(Команда)
	
	ОбменДаннымиКлиент.ОткрытьФормуПараметровПроксиСервера();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПроверитьПодключениеКСервису(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Определяем имя пользователя.
	СвойстваПользователя = Пользователи.СвойстваПользователяИБ(
		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Пользователь, "ИдентификаторПользователяИБ"));
	Если СвойстваПользователя <> Неопределено Тогда
		Запись.WSИмяПользователя = СвойстваПользователя.Имя
	КонецЕсли;
	
	// Выполняем проверку подключения к корреспонденту.
	ПараметрыПодключения = ОбменДаннымиСервер.СтруктураПараметровWS();
	ЗаполнитьЗначенияСвойств(ПараметрыПодключения, Запись);
	
	Если WSПарольИзменен Тогда
		ПараметрыПодключения.WSПароль = WSПароль;
	Иначе
		ПараметрыПодключения.WSПароль = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Запись.Узел, "WSПароль", Истина);
	КонецЕсли;
	
	СообщениеПользователю = "";
	Если Не ОбменДаннымиСервер.ЕстьПодключениеККорреспонденту(Запись.Узел, ПараметрыПодключения, СообщениеПользователю) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеПользователю,, "WSПароль",, Отказ);
	Иначе
		// Проверка подключения прошла успешно, записываем пароль, если он был изменен
		Если WSПарольИзменен Тогда
			ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Запись.Узел, WSПароль, "WSПароль");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПользователиСинхронизацииДанных()
	
	Результат = Новый ТаблицаЗначений;
	Результат.Колонки.Добавить("Пользователь"); // Тип: СправочникСсылка.Пользователи
	Результат.Колонки.Добавить("Представление");
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Пользователи.Ссылка КАК Пользователь,
	|	Пользователи.Наименование КАК Представление,
	|	Пользователи.ИдентификаторПользователяИБ КАК ИдентификаторПользователяИБ
	|ИЗ
	|	Справочник.Пользователи КАК Пользователи
	|ГДЕ
	|	НЕ Пользователи.ПометкаУдаления
	|	И НЕ Пользователи.Недействителен
	|	И НЕ Пользователи.Служебный
	|
	|УПОРЯДОЧИТЬ ПО
	|	Пользователи.Наименование";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Если ЗначениеЗаполнено(Выборка.ИдентификаторПользователяИБ) Тогда
			
			ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(Выборка.ИдентификаторПользователяИБ);
			
			Если ПользовательИБ <> Неопределено
				И ОбменДаннымиСервер.СинхронизацияДанныхРазрешена(ПользовательИБ) Тогда
				
				ЗаполнитьЗначенияСвойств(Результат.Добавить(), Выборка);
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти
