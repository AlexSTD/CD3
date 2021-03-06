#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

	Если НЕ (Объект.ИспользоватьДляОтправки ИЛИ Объект.ИспользоватьДляПолучения) Тогда
		Объект.ИспользоватьДляОтправки = Истина;
	КонецЕсли;
	// Заполнение списка конвертаций данного правила
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		КонвертацияДанныхXDTOВызовСервера.ПолучитьСписокКонвертацийДляЭлементаКонвертации(Объект.Ссылка, СписокКонвертаций);
	Иначе
		Если ЗначениеЗаполнено(ЭтаФорма.Параметры.Конвертация) Тогда
			СписокКонвертаций.Добавить(ЭтаФорма.Параметры.Конвертация);
		ИначеЕсли ЗначениеЗаполнено(ЭтаФорма.Параметры.ЗначениеКопирования) Тогда
			// Возможно новый элемент копируется - тогда список конвертаций необходимо заполнить.
			КонвертацияДанныхXDTOВызовСервера.ПолучитьСписокКонвертацийДляЭлементаКонвертации(ЭтаФорма.Параметры.ЗначениеКопирования, СписокКонвертаций);
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(Объект.Группа) Тогда
			Объект.Группа = ЭтаФорма.Параметры.Группа;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Объект.ПравилаКонвертацииОбъектов.Количество() > 0 Тогда
		ИспользоватьНесколькоПравилКонвертации = Истина;
	КонецЕсли;
	ПеречитатьИменаОбработчиков();
	КонвертацияДанныхXDTOКлиент.ДобавитьТекущееЗначениеВСписокВыбораЭлементаФормы(Элементы.ОбъектВыборки, Объект.ОбъектВыборки);
	КонвертацияДанныхXDTOКлиент.ДобавитьТекущееЗначениеВСписокВыбораЭлементаФормы(Элементы.ПравилоКонвертацииОбъекта, Объект.ПравилоКонвертацииОбъекта);
	Для Каждого СтрокаТЧ Из Объект.ПравилаКонвертацииОбъектов Цикл
		КонвертацияДанныхXDTOКлиент.ДобавитьТекущееЗначениеВСписокВыбораЭлементаФормы(Элементы.ПравилаКонвертацииОбъектовПравилоКонвертацииОбъекта, СтрокаТЧ.ПравилоКонвертацииОбъекта);
	КонецЦикла;
	УстановитьВидимость();
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	// Для нового правила создать запись в регистре
	КонвертацияДанныхXDTOВызовСервера.ЗаписатьЭлементКонвертацииВСоставКонвертации(Объект.Ссылка, СписокКонвертаций);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	// Закрыта форма вопроса о составе конвертаций с изменением состава
	Если ТипЗнч(ВыбранноеЗначение) = Тип("СписокЗначений") Тогда
		ОбработкаВыбораНаСервере();
		ЭтаФорма.ОбновитьОтображениеДанных();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаВыбораНаСервере()
	// Изменился состав конвертаций
	КонвертацияДанныхXDTOВызовСервера.ПолучитьСписокКонвертацийДляЭлементаКонвертации(Объект.Ссылка, СписокКонвертаций);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьДляОтправкиПриИзменении(Элемент)
	Объект.ИспользоватьДляПолучения = НЕ Объект.ИспользоватьДляОтправки;
	ПроверитьОбъектВыборки();
	НастроитьСпискиВыбора();
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьНесколькоПравилКонвертацииПриИзменении(Элемент)
	Если ИспользоватьНесколькоПравилКонвертации Тогда
		НоваяСтрока = Объект.ПравилаКонвертацииОбъектов.Добавить();
		НоваяСтрока.ПравилоКонвертацииОбъекта = Объект.ПравилоКонвертацииОбъекта;
		Объект.ПравилоКонвертацииОбъекта = Неопределено;
	Иначе  // Флаг сброшен
		Если Объект.ПравилаКонвертацииОбъектов.Количество() > 0 Тогда
			Объект.ПравилоКонвертацииОбъекта =  Объект.ПравилаКонвертацииОбъектов[0].ПравилоКонвертацииОбъекта;
			Объект.ПравилаКонвертацииОбъектов.Очистить();
		КонецЕсли;
	КонецЕсли;
	
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура СпособВыборкиПриИзменении(Элемент)
	Если Объект.СпособВыборки = 1 Тогда
		Объект.ОбъектВыборки = Неопределено;
	КонецЕсли;
	СписокПКОЗаполнен = Ложь;
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	ПеречитатьИменаОбработчиков();
КонецПроцедуры

&НаКлиенте
Процедура ОбъектВыборкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПараметрыФормыВыбора = Новый Структура("МассивКонвертаций, ТекущаяСтрока, РежимРаботы", 
					СписокКонвертаций, Объект.ОбъектВыборки);

	Если Объект.ИспользоватьДляОтправки Тогда
		ПараметрыФормыВыбора.РежимРаботы = "ОбъектКонфигурации";
		Если НЕ СписокОбъектовКонфигурацииЗаполнен Тогда
			ОбъектВыборкиНачалоВыбораИзСпискаНаСервере(Истина, Ложь, СписокОбъектовКонфигурации, СписокКонвертаций.ВыгрузитьЗначения());
			СписокОбъектовКонфигурацииЗаполнен = Истина;
			КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ОбъектВыборки, СписокОбъектовКонфигурации);
		КонецЕсли;
	ИначеЕсли Объект.ИспользоватьДляПолучения Тогда
		ПараметрыФормыВыбора.РежимРаботы = "ОбъектФормата";
		Если НЕ СписокОбъектовФорматаЗаполнен Тогда
			ОбъектВыборкиНачалоВыбораИзСпискаНаСервере(Ложь, Истина, СписокОбъектовФормата, СписокКонвертаций.ВыгрузитьЗначения());
			СписокОбъектовФорматаЗаполнен = Истина;
			КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ОбъектВыборки, СписокОбъектовФормата);
		КонецЕсли;
	КонецЕсли;
	ОткрытьФорму("ОбщаяФорма.ВыборОбъектаИлиСвойства",ПараметрыФормыВыбора,Элемент,,,,
			Новый ОписаниеОповещения("ВыбранОбъектВыборки", ЭтотОбъект),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

&НаКлиенте
Процедура ОбъектВыборкиПриИзменении(Элемент)
	СписокПКОЗаполнен = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ПравилоКонвертацииОбъектаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Если НЕ СписокПКОЗаполнен Тогда
		ПравилоКонвертацииОбъектаНачалоВыбораНаСервере(СписокПКО, СписокКонвертаций.ВыгрузитьЗначения(), Объект.ИспользоватьДляОтправки, Объект.ОбъектВыборки);
		СписокПКОЗаполнен = Истина;
		КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ПравилоКонвертацииОбъекта, СписокПКО);
		КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ПравилаКонвертацииОбъектовПравилоКонвертацииОбъекта, СписокПКО);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ДобавитьЭлементВСоставКонвертации(Команда)
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ТекстПредупреждения = НСтр("ru = 'Сначала необходимо записать правило обработки данных'");
		ПоказатьПредупреждение(,ТекстПредупреждения);
		Возврат;
	КонецЕсли;
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбранаКонвертация", ЭтаФорма);
	ОткрытьФорму("Справочник.Конвертации.ФормаВыбора",, ЭтаФорма,,,,ОписаниеОповещения);
КонецПроцедуры
#КонецОбласти
#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбранаКонвертация(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	Если НЕ ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		Возврат;
	КонецЕсли;
	ОтказДобавления = Ложь;
	ДополнитьСоставКонвертации(РезультатЗакрытия, Объект.Ссылка, ОтказДобавления);
	Если ОтказДобавления Тогда
		ТекстПредупреждения = НСтр("ru = 'Данный элемент уже входит в состав выбранной конвертации'");
		ПоказатьПредупреждение(,ТекстПредупреждения);
	Иначе
		Элементы.СписокКонвертаций.ОбновитьТекстРедактирования();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ДополнитьСоставКонвертации(Конвертация, ЭлементКонвертации, ОтказДобавления)
	// Проверка на дубли
	Если КонвертацияДанныхXDTOВызовСервера.ЭлементКонвертацииВходитВСоставКонвертации(Конвертация, ЭлементКонвертации) Тогда
		ОтказДобавления = Истина;
		Возврат;
	КонецЕсли;
	Справочники.СоставыКонвертаций.ДополнитьСоставКонвертации(Конвертация, ЭлементКонвертации);
	КонвертацияДанныхXDTOВызовСервера.ПолучитьСписокКонвертацийДляЭлементаКонвертации(Объект.Ссылка, СписокКонвертаций);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимость()
	// Табличная часть с ПКО
	Элементы.ПравилаКонвертацииОбъектов.Видимость = ИспользоватьНесколькоПравилКонвертации;
	Элементы.ПравилоКонвертацииОбъекта.Видимость = НЕ  ИспользоватьНесколькоПравилКонвертации;
	
	// Объект выборки
	Элементы.ОбъектВыборки.Доступность = (Объект.СпособВыборки = 0);
	
	Элементы.Страница_ВыборкаДанных.Видимость = Объект.ИспользоватьДляОтправки;
	Элементы.ОчисткаДанных.Видимость = ИспользоватьНесколькоПравилКонвертации И Объект.ИспользоватьДляОтправки;
	
КонецПроцедуры

&НаКлиенте
Процедура ПеречитатьИменаОбработчиков()
	ИмяОбработчикаПередОбработкой = "ПОД_"+СокрЛП(Объект.Наименование)+"_ПередОбработкой";
	ИмяОбработчикаПриОбработке = "ПОД_"+СокрЛП(Объект.Наименование)+"_ПриОбработке";
	ИмяОбработчикаВыборкаДанных = "ПОД_"+СокрЛП(Объект.Наименование)+"_ВыборкаДанных";

КонецПроцедуры

&НаКлиенте
Процедура ПроверитьОбъектВыборки()
	Если СокрЛП(Объект.ОбъектВыборки) = "" Тогда
		Возврат;
	КонецЕсли;
	Если Объект.ИспользоватьДляОтправки И СписокОбъектовКонфигурации.НайтиПоЗначению(СокрЛП(Объект.ОбъектВыборки)) = Неопределено Тогда
		Объект.ОбъектВыборки = "";
	ИначеЕсли Объект.ИспользоватьДляПолучения И СписокОбъектовФормата.НайтиПоЗначению(СокрЛП(Объект.ОбъектВыборки)) = Неопределено Тогда
		Объект.ОбъектВыборки = "";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НастроитьСпискиВыбора()
	Если Объект.ИспользоватьДляОтправки Тогда
		КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ОбъектВыборки, СписокОбъектовКонфигурации);
	ИначеЕсли Объект.ИспользоватьДляПолучения Тогда
		КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ОбъектВыборки, СписокОбъектовФормата);
	КонецЕсли;
	ЭтаФорма.ОбновитьОтображениеДанных();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОбъектВыборкиНачалоВыбораИзСпискаНаСервере(ЗаполнитьСписокОбъектовКонфигурации, ЗаполнитьСписокОбъектовФормата, ЗаполняемыйСписок, МассивКонвертаций)
	Если ЗаполнитьСписокОбъектовКонфигурации Тогда
		КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокОбъектовКонфигурации(ЗаполняемыйСписок, МассивКонвертаций, Истина);
	КонецЕсли;
	Если ЗаполнитьСписокОбъектовФормата Тогда
		КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокОбъектовФормата(ЗаполняемыйСписок, МассивКонвертаций, Истина);
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПравилоКонвертацииОбъектаНачалоВыбораНаСервере(СписокПКО, МассивКонвертаций, ИспользоватьДляОтправки, ОбъектВыборки)
	Если ИспользоватьДляОтправки Тогда
		КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокПКО(СписокПКО, МассивКонвертаций, Истина, Неопределено, ОбъектВыборки, Неопределено);
	Иначе
		КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокПКО(СписокПКО, МассивКонвертаций, Неопределено, Истина, Неопределено, ОбъектВыборки);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыбранОбъектВыборки(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	Если НЕ ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		Возврат;
	КонецЕсли;
	Объект.ОбъектВыборки = РезультатЗакрытия;
	ОбъектВыборкиПриИзменении(Элементы.ОбъектВыборки);
КонецПроцедуры

#КонецОбласти




