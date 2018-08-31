&НаКлиенте
Перем ОбновитьИнтерфейс;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Значения реквизитов формы
	РежимРаботы = ОбщегоНазначенияПовтИсп.РежимРаботыПрограммы();
	РежимРаботы = Новый ФиксированнаяСтруктура(РежимРаботы);
	
	ЧасовойПоясПрограммы = ПолучитьЧасовойПоясИнформационнойБазы();
	Если ПустаяСтрока(ЧасовойПоясПрограммы) Тогда
		ЧасовойПоясПрограммы = ЧасовойПояс();
	КонецЕсли;
	Элементы.ЧасовойПоясПрограммы.СписокВыбора.Добавить(ЧасовойПоясПрограммы);
	
	Элементы.ГруппаНастройкаИспользованияПрофилейБезопасности.Видимость = РаботаВБезопасномРежимеСлужебный.ДоступнаНастройкаПрофилейБезопасности() И РежимРаботы.ЭтоАдминистраторСистемы;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
		Элементы.ГруппаОткрытьПараметрыПроксиСервера.Видимость = РежимРаботы.КлиентСерверный И РежимРаботы.ЭтоАдминистраторСистемы;
	Иначе
		Элементы.ГруппаОткрытьПараметрыПроксиСервера.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Интеграция1СБухфон") Тогда
		Элементы.ГруппаИнтеграция1СБухфон.Видимость = РежимРаботы.ЭтоWindowsКлиент;
	Иначе
		Элементы.ГруппаИнтеграция1СБухфон.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЭлектроннаяПодпись") Тогда
		Элементы.ГруппаЭлектроннаяПодписьИШифрование.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		Элементы.ГруппаДополнительныеРеквизитыИСведения.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.ГруппаПубликацияИнформационнойБазы.Видимость = Не (ОбщегоНазначенияПовтИсп.РазделениеВключено() 
		Или ОбщегоНазначенияПовтИсп.ЭтоАвтономноеРабочееМесто());
	
	УстановитьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЗаголовокПрограммыПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	СтандартныеПодсистемыКлиент.УстановитьРасширенныйЗаголовокПриложения();
КонецПроцедуры

&НаКлиенте
Процедура ЧасовойПоясПрограммыПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ЧасовойПоясПрограммыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Если Элемент.СписокВыбора.Количество() < 2 Тогда
		ЗагрузитьЧасовыеПояса();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьДополнительныеРеквизитыИСведенияПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Интеграция1СБухфонПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВИнтернетеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПодключитьОбработчикОжидания("АдресПубликацииИнформационнойБазыВИнтернетеНачалоВыбораПродолжение", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВЛокальнойСетиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПодключитьОбработчикОжидания("АдресПубликацииИнформационнойБазыВЛокальнойСетиНачалоВыбораПродолжение", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПоказатьВремяТекущегоСеанса(Команда)
	
	ПоказатьПредупреждение(,
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Время сеанса: %1
				|На сервере: %2
				|На клиенте: %3
				|
				|Время сеанса - это время сервера,
				|приведенное к часовому поясу клиента.'"),
			Формат(ОбщегоНазначенияКлиент.ДатаСеанса(), "ДЛФ=T"),
			Формат(ДатаСервера(), "ДЛФ=T"),
			Формат(ТекущаяДата(), "ДЛФ=T")));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеПрофилейБезопасности(Команда)
	
	РаботаВБезопасномРежимеКлиент.ОткрытьДиалогНастройкиИспользованияПрофилейБезопасности();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВИнтернетеНачалоВыбораПродолжение()
	
	АдресПубликацииИнформационнойНачалоВыбораЗавершение("АдресПубликацииИнформационнойБазыВИнтернете");
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВЛокальнойСетиНачалоВыбораПродолжение()
	
	АдресПубликацииИнформационнойНачалоВыбораЗавершение("АдресПубликацииИнформационнойБазыВЛокальнойСети");
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойНачалоВыбораЗавершение(ИмяРеквизита)
	
	Если ОбщегоНазначенияКлиентСервер.КлиентПодключенЧерезВебСервер() Тогда
		АдресПубликацииИнформационнойБазыНачалоВыбораНаСервере(ИмяРеквизита, СтрокаСоединенияИнформационнойБазы());
		Подключаемый_ПриИзмененииРеквизита(Элементы[ИмяРеквизита]);
	Иначе
		ПоказатьПредупреждение(, НСтр("ru = 'Не удалось автоматически заполнить поле, т.к. клиентское приложение не подключено через веб-сервер.'"));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура АдресПубликацииИнформационнойБазыНачалоВыбораНаСервере(ИмяРеквизита, СтрокаСоединения)
	
	ПараметрыСоединения = СтроковыеФункцииКлиентСервер.ПолучитьПараметрыИзСтроки(СтрокаСоединения);
	Если ПараметрыСоединения.Свойство("WS") Тогда
		НаборКонстант[ИмяРеквизита] = ПараметрыСоединения.WS;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
	Если КонстантаИмя <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
	
	УстановитьДоступность(РеквизитПутьКДанным);
	
	Если ИмяЭлемента = "ИспользоватьСервисСклоненияMorpher"
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.СклонениеПредставленийОбъектов") Тогда
		МодульСклонениеПредставленийОбъектов = ОбщегоНазначения.ОбщийМодуль("СклонениеПредставленийОбъектов");
		МодульСклонениеПредставленийОбъектов.УстановитьДоступностьСервисаСклонения(Истина);
	КонецЕсли;
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаСервере
Процедура ЗагрузитьЧасовыеПояса()
	
	Элементы.ЧасовойПоясПрограммы.СписокВыбора.ЗагрузитьЗначения(ПолучитьДопустимыеЧасовыеПояса());
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДатаСервера()
	
	Возврат ТекущаяДата();
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "ЧасовойПоясПрограммы" Тогда
		Если ЧасовойПоясПрограммы <> ПолучитьЧасовойПоясИнформационнойБазы() Тогда 
			УстановитьПривилегированныйРежим(Истина);
			Попытка
				ОбщегоНазначения.ЗаблокироватьИБ();
				УстановитьЧасовойПоясИнформационнойБазы(ЧасовойПоясПрограммы);
				ОбщегоНазначения.РазблокироватьИБ();
			Исключение
				ОбщегоНазначения.РазблокироватьИБ();
				ВызватьИсключение;
			КонецПопытки;
			УстановитьПривилегированныйРежим(Ложь);
			УстановитьЧасовойПоясСеанса(ЧасовойПоясПрограммы);
		КонецЕсли;
		Возврат "";
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
		
		Если КонстантаИмя = "ИспользоватьДополнительныеРеквизитыИСведения" И КонстантаЗначение = Ложь Тогда
			ЭтотОбъект.Прочитать();
		КонецЕсли;
	КонецЕсли;
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьДополнительныеРеквизитыИСведения" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаДополнительныеРеквизитыИСведенияПрочиеНастройки",
			"Доступность", НаборКонстант.ИспользоватьДополнительныеРеквизитыИСведения);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаДополнительныеРеквизитыИлиСведения",
			"Доступность", НаборКонстант.ИспользоватьДополнительныеРеквизитыИСведения);
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьЭлектронныеПодписи"
		Или РеквизитПутьКДанным = "НаборКонстант.ИспользоватьШифрование" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЭлектроннаяПодпись") Тогда
		
		Элементы.ГруппаНастройкиЭлектроннойПодписиИШифрования.Доступность =
			НаборКонстант.ИспользоватьЭлектронныеПодписи Или НаборКонстант.ИспользоватьШифрование;
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "" Тогда
		ДоступностьНастройкиПроксиНаСервере = Не ПолучитьФункциональнуюОпцию("ИспользуютсяПрофилиБезопасности");
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаОткрытьПараметрыПроксиСервера",
			"Доступность", ДоступностьНастройкиПроксиНаСервере);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаНастройкаПроксиСервераНаСервереНедоступнаПриИспользованииПрофилейБезопасности",
			"Видимость", Не ДоступностьНастройкиПроксиНаСервере);
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьИнтеграцию1СБухфон" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Интеграция1СБухфон") Тогда
		Элементы.ГруппаНастройка1СБухфон.Доступность = НаборКонстант.ИспользоватьИнтеграцию1СБухфон;
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьСервисСклоненияMorpher" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.СклонениеПредставленийОбъектов") Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаНастройкаСклонения", "Доступность",
			НаборКонстант.ИспользоватьСервисСклоненияMorpher);
			
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
