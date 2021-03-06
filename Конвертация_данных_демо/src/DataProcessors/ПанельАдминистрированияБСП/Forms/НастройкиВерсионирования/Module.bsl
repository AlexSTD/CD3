&НаКлиенте
Перем ОбновитьИнтерфейс;
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ИспользоватьВерсионированиеОбъектов = НаборКонстант.ИспользоватьВерсионированиеОбъектов;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
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
Процедура НаборКонстантИспользоватьВерсионированиеОбъектовПриИзменении(Элемент)
	ПриИзмененииРеквизита();
	УстановитьДоступность();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастроитьВерсионирование(Команда)
	ОткрытьФорму("РегистрСведений.НастройкиВерсионированияОбъектов.ФормаСписка");
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	#Если НЕ ВебКлиент Тогда
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбновитьИнтерфейс();
	КонецЕсли;
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступность()
	Элементы.НастроитьВерсионирование.Доступность = ИспользоватьВерсионированиеОбъектов;
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииРеквизита()
	
	ПриИзмененииРеквизитаСервер();
	
	#Если НЕ ВебКлиент Тогда
	ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 1, Истина);
	ОбновитьИнтерфейс = Истина;
	#КонецЕсли
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииРеквизитаСервер()
	
	КонстантаМенеджер = Константы.ИспользоватьВерсионированиеОбъектов;
	КонстантаЗначение = ИспользоватьВерсионированиеОбъектов;
	
	Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
		КонстантаМенеджер.Установить(КонстантаЗначение);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

