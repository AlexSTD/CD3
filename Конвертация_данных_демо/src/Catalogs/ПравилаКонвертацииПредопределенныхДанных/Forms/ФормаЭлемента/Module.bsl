#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	Если НЕ (Объект.ИспользоватьДляОтправки ИЛИ Объект.ИспользоватьДляПолучения) Тогда
		Объект.ИспользоватьДляОтправки = Истина;
	КонецЕсли;
	
	// Заполнение списка конвертаций данного правила.
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
	
	ЗаполнитьСпискиОбъектов();
	ЗаполнитьСпискиЗначений(Истина, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Объект.ИспользоватьДляОтправки И Объект.ИспользоватьДляПолучения Тогда
		ОбластьПрименения = 2;
	ИначеЕсли Объект.ИспользоватьДляПолучения Тогда
		ОбластьПрименения = 1;
	Иначе
		ОбластьПрименения = 0;
	КонецЕсли;
	НастроитьСпискиВыбораОбъектов();
	НастроитьСпискиВыбораЗначений(Истина, Истина);
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	КонвертацияДанныхXDTOВызовСервера.ПроверитьВозможностьЗаписиПравила(Отказ, ТекущийОбъект, Ложь);
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	// Для нового правила создать запись в регистре
	КонвертацияДанныхXDTOВызовСервера.ЗаписатьЭлементКонвертацииВСоставКонвертации(Объект.Ссылка, СписокКонвертаций);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	// Закрыта форма вопроса о составе конвертаций с изменением состава.
	Если ТипЗнч(ВыбранноеЗначение) = Тип("СписокЗначений") Тогда
		ОбработкаВыбораНаСервере();
		ЭтаФорма.ОбновитьОтображениеДанных();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаВыбораНаСервере()
	// Изменился состав конвертаций.
	КонвертацияДанныхXDTOВызовСервера.ПолучитьСписокКонвертацийДляЭлементаКонвертации(Объект.Ссылка, СписокКонвертаций);
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Тумблер_ОбластьПримененияПриИзменении(Элемент)
	Если ОбластьПрименения = 0 Тогда
		Объект.ИспользоватьДляОтправки = Истина;
		Объект.ИспользоватьДляПолучения = Ложь;
	ИначеЕсли ОбластьПрименения = 1 Тогда
		Объект.ИспользоватьДляОтправки = Ложь;
		Объект.ИспользоватьДляПолучения = Истина;
	Иначе
		Объект.ИспользоватьДляОтправки = Истина;
		Объект.ИспользоватьДляПолучения = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбъектКонфигурацииПриИзменении(Элемент)
	ЗаполнитьСпискиЗначений(Истина, Ложь);
	НастроитьСпискиВыбораЗначений(Истина, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ОбъектФорматаПриИзменении(Элемент)
	ЗаполнитьСпискиЗначений(Ложь, Истина);
	НастроитьСпискиВыбораЗначений(Ложь, Истина);
КонецПроцедуры

&НаКлиенте
Процедура СопоставлениеЗначенийПередНачаломИзменения(Элемент, Отказ)
	Если НЕ ЗначениеЗаполнено(Объект.ОбъектКонфигурации) ИЛИ НЕ ЗначениеЗаполнено(Объект.ОбъектФормата) Тогда
		ТекстПредупреждения = НСтр("ru = 'Не указан объект конфигурации или объект формата'");
		ПоказатьПредупреждение(,ТекстПредупреждения);
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбъектФорматаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПараметрыФормыВыбора = Новый Структура("МассивКонвертаций, ТекущаяСтрока, РежимРаботы", 
					СписокКонвертаций, Объект.ОбъектФормата, "ОбъектФормата");
	ПараметрыФормыВыбора.Вставить("ДляПКПД", Истина);
	ОткрытьФорму("ОбщаяФорма.ВыборОбъектаИлиСвойства",ПараметрыФормыВыбора,Элемент,,,,
			Новый ОписаниеОповещения("ВыбранОбъектФормата", ЭтотОбъект),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры
		
&НаКлиенте
Процедура ОбъектКонфигурацииНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПараметрыФормыВыбора = Новый Структура("МассивКонвертаций, ТекущаяСтрока, РежимРаботы", 
					СписокКонвертаций, Объект.ОбъектКонфигурации, "ОбъектКонфигурации");
	ПараметрыФормыВыбора.Вставить("ДляПКПД", Истина);
	ОткрытьФорму("ОбщаяФорма.ВыборОбъектаИлиСвойства",ПараметрыФормыВыбора,Элемент,,,,
			Новый ОписаниеОповещения("ВыбранОбъектКонфигурации", ЭтотОбъект),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры


#КонецОбласти
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьЭлементВСоставКонвертации(Команда)
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ТекстПредупреждения = НСтр("ru = 'Сначала необходимо записать правило конвертации предопределенных данных'");
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

&НаСервере
Процедура ЗаполнитьСпискиОбъектов()
	МассивКонвертаций = СписокКонвертаций.ВыгрузитьЗначения();
	КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокОбъектовКонфигурации(СписокОбъектовКонфигурации, МассивКонвертаций,, Истина);
	КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокОбъектовФормата(СписокОбъектовФормата, МассивКонвертаций,, Истина);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСпискиЗначений(ДляЗначенийКонфигурации, ДляЗначенийФормата)
	МассивКонвертаций = СписокКонвертаций.ВыгрузитьЗначения();
	Если ДляЗначенийКонфигурации Тогда
		КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокЗначенийКонфигурации(СписокЗначенийКонфигурации, МассивКонвертаций, Объект.ОбъектКонфигурации);
	КонецЕсли;
	Если ДляЗначенийФормата Тогда
		КонвертацияДанныхXDTOВызовСервера.ЗаполнитьСписокЗначенийФормата(СписокЗначенийФормата, МассивКонвертаций, Объект.ОбъектФормата);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НастроитьСпискиВыбораОбъектов()
	КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ОбъектКонфигурации, СписокОбъектовКонфигурации);
	КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ОбъектФормата, СписокОбъектовФормата);
	ЭтаФорма.ОбновитьОтображениеДанных();
КонецПроцедуры

&НаКлиенте
Процедура НастроитьСпискиВыбораЗначений(ДляЗначенийКонфигурации, ДляЗначенийФормата)
	Если ДляЗначенийКонфигурации Тогда
		КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(
			Элементы.СопоставлениеЗначений.ПодчиненныеЭлементы.СопоставлениеЗначенийЗначениеКонфигурации,
			СписокЗначенийКонфигурации);
	КонецЕсли;
	Если ДляЗначенийФормата Тогда
		КонвертацияДанныхXDTOКлиент.ЗаполнитьСписокВыбораЭлементаФормы(
			Элементы.СопоставлениеЗначений.ПодчиненныеЭлементы.СопоставлениеЗначенийЗначениеФормата,
			СписокЗначенийФормата);
	КонецЕсли;
	ЭтаФорма.ОбновитьОтображениеДанных();

КонецПроцедуры


&НаКлиенте
Процедура ВыбранОбъектФормата(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	Если НЕ ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		Возврат;
	КонецЕсли;
	Объект.ОбъектФормата = РезультатЗакрытия;
	ОбъектФорматаПриИзменении(Элементы.ОбъектФормата);
КонецПроцедуры

&НаКлиенте
Процедура ВыбранОбъектКонфигурации(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	Если НЕ ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		Возврат;
	КонецЕсли;
	Объект.ОбъектКонфигурации = РезультатЗакрытия;
	ОбъектКонфигурацииПриИзменении(Элементы.ОбъектКонфигурации);
КонецПроцедуры




#КонецОбласти








