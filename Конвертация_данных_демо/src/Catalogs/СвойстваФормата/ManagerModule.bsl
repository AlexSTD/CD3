#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
#Область ПрограммныйИнтерфейс
// Возвращает ссылку на общее свойство, которое является хранителем свойств текущего свойства.
// Параметры:
//  Ссылка - СправочникСсылка.СвойстваФормата - ссылка на обычное свойство формата.
// Возвращаемое значение:
//  СправочникСсылка.СвойстваФормата - Ссылка на свойство, которое является хранителем свойств.
Функция ОпределитьОбщийРеквизит(Ссылка) Экспорт
	Если НЕ 
		(ЗначениеЗаполнено(Ссылка.ОбъектХранительСвойств)
		ИЛИ ЗначениеЗаполнено(Ссылка.Родитель.ОбъектХранительСвойств)) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВладелецОбъекта", Ссылка.Владелец.Владелец);
	Если Ссылка.ЭтоГруппа Тогда
		Запрос.УстановитьПараметр("ТипОбщегоРеквизита", Ссылка.ТипОбщегоСвойства);
		Запрос.УстановитьПараметр("НаименованиеОбъекта", Ссылка.ОбъектХранительСвойств);
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		|	Ссылка КАК Ссылка
		|ИЗ Справочник.ОбъектыФормата 
		|ГДЕ Владелец = &ВладелецОбъекта И Наименование = &НаименованиеОбъекта
		|	И ТипОбщегоРеквизита = &ТипОбщегоРеквизита
		|	";
	Иначе
		Запрос.УстановитьПараметр("НаименованиеСвойства", Ссылка.Наименование);
		Если ЗначениеЗаполнено(Ссылка.Родитель) Тогда
			Запрос.УстановитьПараметр("ТипОбщегоРеквизита", Ссылка.Родитель.ТипОбщегоСвойства);
			Запрос.УстановитьПараметр("НаименованиеОбъекта", Ссылка.Родитель.ОбъектХранительСвойств);
		Иначе
			Запрос.УстановитьПараметр("ТипОбщегоРеквизита", Ссылка.ТипОбщегоСвойства);
			Запрос.УстановитьПараметр("НаименованиеОбъекта", Ссылка.ОбъектХранительСвойств);
		КонецЕсли;
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		|	Ссылка КАК Ссылка
		|ИЗ Справочник.СвойстваФормата 
		|ГДЕ Владелец.Владелец = &ВладелецОбъекта И Владелец.Наименование = &НаименованиеОбъекта
		|	И Владелец.ТипОбщегоРеквизита = &ТипОбщегоРеквизита 
		|	И Наименование = &НаименованиеСвойства";
	КонецЕсли;
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	Иначе
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.Ссылка;
	КонецЕсли;
КонецФункции
#КонецОбласти
#КонецЕсли