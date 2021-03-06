
#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	НомерЗакладки = 0;
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.Результат;
	ИзменитьДоступностьЭлементовФормы(Истина);
	УстановитьВидимость();
КонецПроцедуры
#КонецОбласти
#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ВерсияФорматаПриИзменении(Элемент)
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.Ожидание;
	ИзменитьДоступностьЭлементовФормы(Ложь);
	ПодключитьОбработчикОжидания("ЗапускОбработки", 5, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоФорматаПриАктивизацииСтроки(Элемент)
	Если ДеревоФормата.ПолучитьЭлементы().Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	ПодключитьОбработчикОжидания("ОбновитьДанныеТекущейСтроки",1, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ОтображатьПоискСсылокПриИзменении(Элемент)
	УстановитьВидимость();
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы
#Область Закладки
&НаКлиенте
Процедура ДобавитьЗакладку(Команда)
	Если ДеревоФормата.ПолучитьЭлементы().Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	ИдентификаторСтрокиДерева = Элементы.ДеревоФормата.ТекущиеДанные.ПолучитьИдентификатор();
	Если СписокЗакладокДерева.НайтиПоЗначению(ИдентификаторСтрокиДерева) = Неопределено Тогда
		СписокЗакладокДерева.Добавить(ИдентификаторСтрокиДерева);
	КонецЕсли;
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура СледующаяЗакладка(Команда)
	Если СписокЗакладокДерева.Количество() = 0 Тогда
		Возврат;
	ИначеЕсли СписокЗакладокДерева.Количество() = 1
		Или НомерЗакладки > СписокЗакладокДерева.Количество()
		Или НомерЗакладки = 0 Тогда
		НомерЗакладки = 1;
	КонецЕсли;
	ИдентификаторСтрокиДерева = СписокЗакладокДерева[НомерЗакладки-1].Значение;
	Элементы.ДеревоФормата.ТекущаяСтрока = ИдентификаторСтрокиДерева;
	Если СписокЗакладокДерева.Количество() > 1 Тогда
		НомерЗакладки = НомерЗакладки + 1;
	КонецЕсли;
	ОбновитьДанныеТекущейСтроки();
КонецПроцедуры

&НаКлиенте
Процедура ПредыдущаяЗакладка(Команда)
	Если СписокЗакладокДерева.Количество() = 0 Тогда
		Возврат;
	ИначеЕсли СписокЗакладокДерева.Количество() = 1 Тогда
		НомерЗакладки = 1;
	ИначеЕсли НомерЗакладки = 0 Или НомерЗакладки > СписокЗакладокДерева.Количество() Тогда
		НомерЗакладки = СписокЗакладокДерева.Количество();
	КонецЕсли;
	ИдентификаторСтрокиДерева = СписокЗакладокДерева[НомерЗакладки-1].Значение;
	Элементы.ДеревоФормата.ТекущаяСтрока = ИдентификаторСтрокиДерева;
	Если СписокЗакладокДерева.Количество() > 1 Тогда
		НомерЗакладки = НомерЗакладки - 1;
	КонецЕсли;
	ОбновитьДанныеТекущейСтроки();
КонецПроцедуры

&НаКлиенте
Процедура УдалитьЗакладки(Команда)
	СписокЗакладокДерева.Очистить();
	НомерЗакладки = 0;
	УстановитьВидимость();
КонецПроцедуры
#КонецОбласти

#Область ПоискСсылок
&НаКлиенте
Процедура ПоискСсылокНаОбъект(Команда)
	ТаблицаСсылокНаОбъектФормата.Очистить();
	Если ДеревоФормата.ПолучитьЭлементы().Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	ТекущаяСтрока = Элементы.ДеревоФормата.ТекущиеДанные;
	ПоискСсылокНаОбъектНаСервере(ТекущаяСтрока.Элемент);
	УстановитьВидимость();
	ОбновитьДанныеТекущейСтроки();
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКСсылке(Команда)
	Если ТаблицаСсылокНаОбъектФормата.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПерейтиКСтрокеДереваПоСсылке(Элементы.ТаблицаСсылокНаОбъектФормата.ТекущиеДанные.СвойствоФормата);
КонецПроцедуры
#КонецОбласти
#Область РедактированиеДерева
&НаКлиенте
Процедура ДобавитьСтроку(Команда)
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ОткрытьФормуСКонтекстом(Результат);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьГруппуСвойств(Команда)
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Результат.ИмяОбъекта <> "СвойстваФормата" Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Добавление группы возможно только для свойств.'"));
		Возврат;
	КонецЕсли;
	Если НЕ Результат.ДоступноИзменение Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Добавление группы в данном контексте невозможно.'"));
		Возврат;
	КонецЕсли;
	Результат.Вставить("ГруппаСвойств", Истина);
	ОткрытьФормуСКонтекстом(Результат);
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьСтроку(Команда)
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Результат.Вставить("ОбъектКопирования", Элементы.ДеревоФормата.ТекущиеДанные.Элемент);
	ОткрытьФормуСКонтекстом(Результат);
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСтроку(Команда)
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если НЕ Результат.ДоступноИзменение Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Удаление невозможно.'"));
		Возврат;
	КонецЕсли;
	ТекСсылка = Элементы.ДеревоФормата.ТекущиеДанные.Элемент;
	УдалитьСтрокуНаСервере(ТекСсылка);
КонецПроцедуры

&НаСервере
Процедура УдалитьСтрокуНаСервере(ТекСсылка)
	ТекОбъект = ТекСсылка.ПолучитьОбъект();
	ТекОбъект.УстановитьПометкуУдаления(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПереместитьВверх(Команда)
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Результат.ИмяОбъекта <> "СвойстваФормата" Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Перемещение доступно только для свойств формата.'"));
		Возврат;
	КонецЕсли;
	Если НЕ Результат.ДоступноИзменение Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Изменение порядка для данного свойства недоступно.'"));
		Возврат;
	КонецЕсли;
	ТекЭлемент = Элементы.ДеревоФормата.ТекущиеДанные.Элемент;
	ТекРодитель = Элементы.ДеревоФормата.ТекущиеДанные.ПолучитьРодителя();
	// Выборка элементов текущего родителя.
	МассивЭлементов = Новый Массив;
	КоллекцияЭлементов = ТекРодитель.ПолучитьЭлементы();
	Для Каждого ЭлементДерева Из КоллекцияЭлементов Цикл
		МассивЭлементов.Добавить(ЭлементДерева.Элемент);
	КонецЦикла;

	ПереместитьНаСервере(1, ТекЭлемент, МассивЭлементов);
КонецПроцедуры

&НаКлиенте
Процедура ПереместитьВниз(Команда)
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Результат.ИмяОбъекта <> "СвойстваФормата" Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Перемещение доступно только для свойств формата.'"));
		Возврат;
	КонецЕсли;
	Если НЕ Результат.ДоступноИзменение Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Изменение порядка для данного свойства недоступно.'"));
		Возврат;
	КонецЕсли;
	ТекЭлемент = Элементы.ДеревоФормата.ТекущиеДанные.Элемент;
	ТекРодитель = Элементы.ДеревоФормата.ТекущиеДанные.ПолучитьРодителя();
	// Выборка элементов текущего родителя.
	МассивЭлементов = Новый Массив;
	КоллекцияЭлементов = ТекРодитель.ПолучитьЭлементы();
	Для Каждого ЭлементДерева Из КоллекцияЭлементов Цикл
		МассивЭлементов.Добавить(ЭлементДерева.Элемент);
	КонецЦикла;

	ПереместитьНаСервере(-1, ТекЭлемент, МассивЭлементов);
КонецПроцедуры
#КонецОбласти
#Область Прочее

&НаКлиенте
Процедура ТипСвойстваСтрокойНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если Элементы.ДеревоФормата.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДанныеСтрокиДерева = Элементы.ДеревоФормата.ТекущиеДанные;
	Если ДанныеСтрокиДерева.ТипСвойстваСтрокой = "" Тогда
		Возврат;
	КонецЕсли;
	СсылкаНаОбъект = НайтиСсылкуНаТип(ДанныеСтрокиДерева.ТипСвойстваСтрокой);
	ПерейтиКСтрокеДереваПоСсылке(СсылкаНаОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ТипСвойстваМассивВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если Элементы.ТипСвойстваМассив.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	СсылкаНаОбъект = НайтиСсылкуНаТип(Элементы.ТипСвойстваМассив.ТекущиеДанные.Значение);
	ПерейтиКСтрокеДереваПоСсылке(СсылкаНаОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДерево(Команда)
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.Ожидание;
	ИзменитьДоступностьЭлементовФормы(Ложь);
	ПодключитьОбработчикОжидания("ЗапускОбработки", 5, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоФорматаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если ДеревоФормата.ПолучитьЭлементы().Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	ТекДанные = Элементы.ДеревоФормата.ТекущиеДанные;
	Если ТипЗнч(ТекДанные.Элемент) = Тип("Строка") Тогда
		Возврат;
	КонецЕсли;
	Результат = ОпределитьТекущийКонтекст();
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ПараметрыФормы = Новый Структура("Ключ", ТекДанные.Элемент);
	Если Результат.ИмяОбъекта = "СвойстваФормата" Тогда
		ИмяФормыСправочника = ФормаСправочникаСвойстваФормата(ТекДанные.Элемент);
	Иначе
		ИмяФормыСправочника = "Справочник." + Результат.ИмяОбъекта + ".ФормаОбъекта"
	КонецЕсли;
	ОткрытьФорму(ИмяФормыСправочника, ПараметрыФормы); 
КонецПроцедуры

&НаСервере
Функция ФормаСправочникаСвойстваФормата(ТекСсылка)
	Если ТекСсылка.ЭтоГруппа Тогда
		Возврат "Справочник.СвойстваФормата.ФормаГруппы";
	Иначе
		Возврат "Справочник.СвойстваФормата.ФормаОбъекта";
	КонецЕсли;
	
КонецФункции

#КонецОбласти
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
#Область ОбработчикиОжидания
&НаКлиенте
Процедура ЗапускОбработки()
	ПодключитьОбработчикОжидания("ОбработчикОжиданияДлительнойОперации", 5, Истина);
	ЗаполнитьДеревоФормата();
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияДлительнойОперации()
	Если НЕ ДлительнаяОперация Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.Результат;
		ИзменитьДоступностьЭлементовФормы(Истина);
		УстановитьВидимость();
		Возврат;
	КонецЕсли;
	Если ДлительнаяОперацияВыполнена() Тогда
		ДлительнаяОперация = Ложь;
		ПодключитьОбработчикОжидания("ОкончаниеЗаполненияДерева", 1, Истина);
	Иначе
		ПодключитьОбработчикОжидания("ОбработчикОжиданияДлительнойОперации", 5, Истина);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОкончаниеЗаполненияДерева()
	ПерерисоватьДеревоНаФормеСервер();
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.Результат;
	ИзменитьДоступностьЭлементовФормы(Истина);
	УстановитьВидимость();
КонецПроцедуры


#КонецОбласти
#Область ЗаполнениеДерева
&НаСервере
Процедура ЗаполнитьДеревоФормата()
		ИдентификаторЗадания = Неопределено;
	ДлительнаяОперация = Ложь;
	АдресХранилищаРезультата = Неопределено;
	СтруктураПараметров = Новый Структура("ВерсияФормата", Объект.ВерсияФормата);
	Попытка
		Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
			УникальныйИдентификатор,
			"Обработки.ДеревоОбъектовФормата.ПолучитьДеревоОбъектовФормата",
			СтруктураПараметров,
			НСтр("ru = 'Заполнение дерева объектов формата'"));
		АдресХранилищаРезультата = Результат.АдресХранилища;
		Если Результат.ЗаданиеВыполнено Тогда
			ПерерисоватьДеревоНаФормеСервер();
		Иначе
			ДлительнаяОперация = Истина;
			ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		КонецЕсли;
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'При формировании дерева объектов формата произошла ошибка'") + ": " + ОписаниеОшибки());
		Возврат;
	КонецПопытки

КонецПроцедуры

&НаСервере
Процедура ПерерисоватьДеревоНаФормеСервер()
	РезультатФормирования = ПолучитьИзВременногоХранилища(АдресХранилищаРезультата);
	ТаблицаДляПоискаПоДереву.Загрузить(РезультатФормирования.ТаблицаДляПоискаПоДереву);
	Уровень0_Исх = РезультатФормирования.ДеревоФормата.Строки;
	Уровень0_Нов = ДеревоФормата.ПолучитьЭлементы();
	Уровень0_Нов.Очистить();
	СкопироватьДерево(Уровень0_Нов, Уровень0_Исх);
КонецПроцедуры

&НаСервере
Процедура СкопироватьДерево(Получатель, Источник)
	Для Каждого СтрокаИсточник Из Источник Цикл
		СтрокаПолучатель = Получатель.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПолучатель, СтрокаИсточник);
		
		СтрОтбор = ТаблицаДляПоискаПоДереву.НайтиСтроки(Новый Структура("Элемент", СтрокаИсточник.Элемент));
		Если СтрОтбор.Количество() > 0 Тогда
			СтрОтбор[0].Идентификатор = СтрокаПолучатель.ПолучитьИдентификатор();
		КонецЕсли;
		
		УровеньНижеИсточник = СтрокаИсточник.Строки;
		УровеньНижеПолучатель = СтрокаПолучатель.ПолучитьЭлементы();
		СкопироватьДерево(УровеньНижеПолучатель, УровеньНижеИсточник);
	КонецЦикла;
КонецПроцедуры



&НаСервере
Функция ДлительнаяОперацияВыполнена()
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
КонецФункции
#КонецОбласти

#Область ПереходПоСсылками
&НаСервере
Процедура ПоискСсылокНаОбъектНаСервере(ТекущийЭлемент)
	ТекстЗапроса = "";
	ТекОбъектФормата = Неопределено;
	Если ТипЗнч(ТекущийЭлемент) = Тип("СправочникСсылка.ОбъектыФормата") Тогда
		ТекОбъектФормата = ТекущийЭлемент;
		Если НЕ ЗначениеЗаполнено(ТекОбъектФормата.ТипОбщегоРеквизита) Тогда
			ТекстЗапроса = "ВЫБРАТЬ ПЕРВЫЕ 1
			|	ВЫРАЗИТЬ(СвойстваФормата.Тип КАК Строка(1000))	КАК ИмяТипа
			|ПОМЕСТИТЬ КлючевоеСвойство
			|ИЗ Справочник.СвойстваФормата КАК СвойстваФормата
			|ГДЕ СвойстваФормата.Владелец.Владелец = &ВерсияФормата
			|	И СвойстваФормата.ПометкаУдаления = ЛОЖЬ
			|	И СвойстваФормата.Владелец = &ОбъектФормата
			|	И СвойстваФормата.Наименование = ""КлючевыеСвойства""
			|ОБЪЕДИНИТЬ ВСЕ
			|ВЫБРАТЬ ПЕРВЫЕ 1
			|	ЗначенияФормата.Владелец.Наименование КАК ИмяТипа
			|ИЗ Справочник.ЗначенияФормата КАК ЗначенияФормата
			|ГДЕ ЗначенияФормата.Владелец = &ОбъектФормата
			|	И ЗначенияФормата.Владелец.Владелец = &ВерсияФормата
			|	И ЗначенияФормата.ПометкаУдаления = ЛОЖЬ
			|;
			|///////////////////////////////////////////////////////
			|ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Ссылка			 						КАК СвойствоФормата,
			|	Ссылка.Родитель 						КАК СвойствоФорматаРодитель,
			|	Ссылка.Владелец 						КАК ОбъектФормата
			|ИЗ Справочник.СвойстваФормата КАК СвойстваФормата
			|ГДЕ СвойстваФормата.Владелец.Владелец = &ВерсияФормата
			|	И СвойстваФормата.ПометкаУдаления = ЛОЖЬ
			|	И ВЫРАЗИТЬ(СвойстваФормата.Тип КАК Строка(1000)) В (ВЫБРАТЬ ИмяТипа ИЗ КлючевоеСвойство)
			|УПОРЯДОЧИТЬ ПО ОбъектФормата, СвойствоФормата";
		ИначеЕсли ТекОбъектФормата.ТипОбщегоРеквизита = Перечисления.ТипыОбщихРеквизитов.ОбщаяТабличнаяЧасть Тогда
			ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Ссылка.Родитель 						КАК СвойствоФормата,
			|	Ссылка.Родитель.Родитель				КАК СвойствоФорматаРодитель,
			|	Ссылка.Владелец 						КАК ОбъектФормата
			|ИЗ Справочник.СвойстваФормата КАК СвойстваФормата
			|ГДЕ СвойстваФормата.Владелец.Владелец = &ВерсияФормата
			|	И СвойстваФормата.ПометкаУдаления = ЛОЖЬ
			|	И СвойстваФормата.Родитель.ОбъектХранительСвойств = &Наименование
			|УПОРЯДОЧИТЬ ПО ОбъектФормата, СвойствоФормата";
		ИначеЕсли ТекОбъектФормата.ТипОбщегоРеквизита = Перечисления.ТипыОбщихРеквизитов.ГруппаОбщихСвойств Тогда
			ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Ссылка			 						КАК СвойствоФормата,
			|	Ссылка.Родитель 						КАК СвойствоФорматаРодитель,
			|	Ссылка.Владелец 						КАК ОбъектФормата
			|ИЗ Справочник.СвойстваФормата КАК СвойстваФормата
			|ГДЕ СвойстваФормата.Владелец.Владелец = &ВерсияФормата
			|	И СвойстваФормата.ПометкаУдаления = ЛОЖЬ
			|	И СвойстваФормата.ОбъектХранительСвойств = &Наименование
			|УПОРЯДОЧИТЬ ПО ОбъектФормата, СвойствоФормата";
		ИначеЕсли ТекОбъектФормата.ТипОбщегоРеквизита = Перечисления.ТипыОбщихРеквизитов.КлючевыеСвойства Тогда
			ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Ссылка КАК СвойствоФормата,
			|	Ссылка.Родитель КАК СвойствоФорматаРодитель,
			|	Ссылка.Владелец КАК ОбъектФормата
			|ИЗ Справочник.СвойстваФормата КАК СвойстваФормата
			|ГДЕ СвойстваФормата.Владелец.Владелец = &ВерсияФормата
			|	И СвойстваФормата.ПометкаУдаления = ЛОЖЬ
			|	И СвойстваФормата.Тип ПОДОБНО &Наименование_Поиск
			|УПОРЯДОЧИТЬ ПО ОбъектФормата, СвойствоФормата";
		КонецЕсли;
	ИначеЕсли ТипЗнч(ТекущийЭлемент) = Тип("СправочникСсылка.ТипыФормата") Тогда
		ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Ссылка КАК СвойствоФормата,
		|	Ссылка.Родитель КАК СвойствоФорматаРодитель,
		|	Ссылка.Владелец КАК ОбъектФормата
		|ИЗ Справочник.СвойстваФормата КАК СвойстваФормата
		|ГДЕ СвойстваФормата.Владелец.Владелец = &ВерсияФормата
		|	И СвойстваФормата.ПометкаУдаления = ЛОЖЬ
		|	И СвойстваФормата.Тип ПОДОБНО &Наименование_Поиск
		|УПОРЯДОЧИТЬ ПО ОбъектФормата, СвойствоФормата";
	Иначе
		Возврат;
	КонецЕсли;
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("Наименование", ТекущийЭлемент.Наименование);
	Запрос.УстановитьПараметр("Наименование_Поиск", "%"+СокрЛП(ТекущийЭлемент.Наименование)+"%");
	Запрос.УстановитьПараметр("ОбъектФормата", ТекОбъектФормата);
	Запрос.УстановитьПараметр("ВерсияФормата", Объект.ВерсияФормата);
	ТабСсылки = Запрос.Выполнить().Выгрузить();
	ТабСсылки.Колонки.Добавить("СвойствоФорматаПредставление");
	Для Каждого СтрТаб Из ТабСсылки Цикл
		Если ЗначениеЗаполнено(СтрТаб.СвойствоФорматаРодитель) Тогда
			СтрТаб.СвойствоФорматаПредставление = СокрЛП(СтрТаб.СвойствоФорматаРодитель) + "." + СокрЛП(СтрТаб.СвойствоФормата);
		Иначе
			СтрТаб.СвойствоФорматаПредставление = СокрЛП(СтрТаб.СвойствоФормата);
		КонецЕсли;
	КонецЦикла;
	ТаблицаСсылокНаОбъектФормата.Загрузить(ТабСсылки);
КонецПроцедуры

&НаСервере
Функция НайтиСсылкуНаТип(НаименованиеТипа)
	Запрос = Новый Запрос;
	Если Лев(НаименованиеТипа,16) = "КлючевыеСвойства" Тогда
		// Необходим объект формата, у которого тип ключевых свойств по названию соответствует переданному.
		// Объекты = Ключевые свойства в дереве не отображаются.
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		|	Ссылка.Владелец КАК Ссылка,
		|	0 КАК Приоритет
		|ИЗ Справочник.СвойстваФормата
		|ГДЕ Владелец.Владелец = &ВерсияФормата И Наименование = ""КлючевыеСвойства""
		|	И Тип ПОДОБНО &Наименование_Поиск
		|	И НЕ ПометкаУдаления";
	Иначе
		// Тип формата либо объект формата с указанным наименованием.
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		|	Ссылка КАК Ссылка,
		|	1 КАК Приоритет
		|ИЗ Справочник.ТипыФормата
		|ГДЕ Владелец = &ВерсияФормата И Наименование = &Наименование
		|	И НЕ ПометкаУдаления
		|ОБЪЕДИНИТЬ ВСЕ
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	Ссылка КАК Ссылка,
		|	0 КАК Приоритет
		|ИЗ Справочник.ОбъектыФормата
		|ГДЕ Владелец = &ВерсияФормата И Наименование = &Наименование
		|	И НЕ ПометкаУдаления";
	КонецЕсли;
	Запрос.УстановитьПараметр("ВерсияФормата", Объект.ВерсияФормата);
	Запрос.УстановитьПараметр("Наименование", НаименованиеТипа);
	Запрос.УстановитьПараметр("Наименование_Поиск", "%"+СокрЛП(НаименованиеТипа)+"%");

	Выборка = Запрос.Выполнить().Выбрать();
	СсылкаНомер2 = Неопределено;
	Пока Выборка.Следующий() Цикл
		Если Выборка.Приоритет = 0 Тогда
			Возврат Выборка.Ссылка;
		КонецЕсли;
		СсылкаНомер2 = Выборка.Ссылка;
	КонецЦикла;
	Возврат СсылкаНомер2;
КонецФункции

&НаКлиенте
Процедура ПерейтиКСтрокеДереваПоСсылке(ЭлементСсылка)
	СтрокиТаб = ТаблицаДляПоискаПоДереву.НайтиСтроки(Новый Структура("Элемент", ЭлементСсылка));
	Если СтрокиТаб.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	Элементы.ДеревоФормата.ТекущаяСтрока = СтрокиТаб[0].Идентификатор;
	ОбновитьДанныеТекущейСтроки();
КонецПроцедуры
#КонецОбласти
#Область ВнешнийВидФормы
&НаКлиенте
Процедура УстановитьВидимость()
	ЕстьЗакладки = (СписокЗакладокДерева.Количество()>0);
	Элементы.ФормаСледующаяЗакладка.Доступность = ЕстьЗакладки;
	Элементы.ФормаПредыдущаяЗакладка.Доступность = ЕстьЗакладки;
	Элементы.ФормаУдалитьЗакладки.Доступность = ЕстьЗакладки;
	
	Элементы.ТаблицаСсылокНаОбъектФормата.Видимость = ОтображатьПоискСсылок;
	Элементы.ТипСвойстваМассив.Видимость = Ложь;
	Элементы.ПредопределенныеЗначенияМассив.Видимость = Ложь;
	Если ОтображатьПоискСсылок Тогда
		ЕстьСсылки = ТаблицаСсылокНаОбъектФормата.Количество();
		Элементы.ПерейтиКСсылке.Доступность = ЕстьСсылки;
		Элементы.ПоискСсылокНаОбъект.Доступность = (ДеревоФормата.ПолучитьЭлементы().Количество() > 0);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьДоступностьЭлементовФормы(ФлагДоступность)
	Элементы.ФормаОбновитьДерево.Доступность = ФлагДоступность;
	Элементы.ФормаЗакладки.Доступность = ФлагДоступность;
	Элементы.ВерсияФормата.Доступность = ФлагДоступность;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеТекущейСтроки()
	Если Элементы.ДеревоФормата.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДанныеСтрокиДерева = Элементы.ДеревоФормата.ТекущиеДанные;
	Обязательное = ДанныеСтрокиДерева.Обязательное;
	ТипСвойстваСтрокой = "";
	ТипСвойстваМассив.Очистить();
	Элементы.ТипСвойстваСтрокой.Гиперссылка = Ложь;
	Если ДанныеСтрокиДерева.ТипСвойстваМассив.Количество() > 0 Тогда
		Элементы.ТипСвойстваСтрокой.Видимость = Ложь;
		Элементы.ТипСвойстваМассив.Видимость = Истина;
		Для Каждого СтрТип Из ДанныеСтрокиДерева.ТипСвойстваМассив Цикл
			ТипСвойстваМассив.Добавить(СтрТип.Значение);
		КонецЦикла;
		Возврат;
	Иначе
		Элементы.ТипСвойстваСтрокой.Видимость = Истина;
		Элементы.ТипСвойстваМассив.Видимость = Ложь;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ДанныеСтрокиДерева.ТипСвойстваСтрокой) Тогда
		Возврат;
	КонецЕсли;
	ТипСвойстваСтрокой = ДанныеСтрокиДерева.ТипСвойстваСтрокой;
	Если Найти(ТипСвойстваСтрокой, ";") > 0 Тогда
		ТипСвойстваСтрокой = СтрЗаменить(ТипСвойстваСтрокой, "; ",";"+Символы.ПС);
		Элементы.ТипСвойстваСтрокой.Высота = 2;
	Иначе
		Элементы.ТипСвойстваСтрокой.Высота = 0;
	КонецЕсли;
	
	Элементы.ТипСвойстваСтрокой.ЦветТекста = ?(ДанныеСтрокиДерева.ТипЭтоСсылка,Новый Цвет(83,106,194), Новый Цвет(51,51,51));
	Элементы.ТипСвойстваСтрокой.Гиперссылка = ДанныеСтрокиДерева.ТипЭтоСсылка;
	
	ПредопределенныеЗначенияМассив.Очистить();
	Если ДанныеСтрокиДерева.ПредопределенныеЗначенияМассив.Количество() > 0 Тогда
		Элементы.ПредопределенныеЗначенияМассив.Видимость = Истина;
		Для Каждого СтрТип Из ДанныеСтрокиДерева.ПредопределенныеЗначенияМассив Цикл
			ПредопределенныеЗначенияМассив.Добавить(СтрТип.Значение);
		КонецЦикла;
	Иначе
		Элементы.ПредопределенныеЗначенияМассив.Видимость = Ложь;
	КонецЕсли;

КонецПроцедуры
#КонецОбласти
#Область РедактированиеДерева
&НаКлиенте
Функция ОпределитьТекущийКонтекст()
	Если ДеревоФормата.ПолучитьЭлементы().Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	ТекДанные = Элементы.ДеревоФормата.ТекущиеДанные;
	Результат = Новый Структура("ИмяОбъекта, ДоступноИзменение, ВерсияФормата");
	Результат.ДоступноИзменение = ТекДанные.ДоступноИзменение;
	Результат.ВерсияФормата = Объект.ВерсияФормата;
	ТекЭлемент = ТекДанные.Элемент;
	ВеткаРодитель = ТекДанные.ПолучитьРодителя();
	ЭлементРодитель = Неопределено;
	Если ВеткаРодитель <> Неопределено Тогда
		ЭлементРодитель = ВеткаРодитель.Элемент;
	КонецЕсли;
	ЕстьОпределенность = Ложь;
	Если ТипЗнч(ТекЭлемент) = Тип("СправочникСсылка.ТипыФормата") Тогда
		Результат.ИмяОбъекта = "ТипыФормата";
		Если ЭлементРодитель = "Простые" Тогда
			Результат.Вставить("ПространствоИменБазовогоТипа", "http://www.w3.org/2001/XMLSchema");
		ИначеЕсли ЭлементРодитель = "Ссылочные" Тогда
			Результат.Вставить("ПространствоИменБазовогоТипа", "http://www.1c.ru/SSL/Exchange/Message");
			Результат.Вставить("БазовыйТип", "Ref");
		КонецЕсли;
		ЕстьОпределенность = Истина;
	ИначеЕсли ТипЗнч(ТекЭлемент) = Тип("СправочникСсылка.СвойстваФормата") Тогда
		Результат.ИмяОбъекта = "СвойстваФормата";
		Результат.Вставить("ОбъектФормата", ЭлементРодитель);
		Результат.Вставить("ПредыдущееСвойство", ТекЭлемент);
		ЕстьОпределенность = Истина;
	ИначеЕсли ТипЗнч(ТекЭлемент) = Тип("СправочникСсылка.ЗначенияФормата") Тогда
		Результат.ИмяОбъекта = "ЗначенияФормата";
		Результат.Вставить("ОбъектФормата", ЭлементРодитель);
		ЕстьОпределенность = Истина;
	ИначеЕсли ТипЗнч(ТекЭлемент) = Тип("СправочникСсылка.ОбъектыФормата") Тогда
		Результат.ИмяОбъекта = "ОбъектыФормата";
		ЕстьОпределенность = Истина;
		Если ЗначениеЗаполнено(ТекДанные.ТипОбщегоРеквизита) Тогда
			Результат.Вставить("ТипОбщегоРеквизита", ТекДанные.ТипОбщегоРеквизита);
			Результат.Вставить("ШаблонНаименования", ?(СокрЛП(ТекДанные.ТипОбщегоРеквизита) = НСтр("ru = 'Группа общих свойств'"),"ОбщиеСвойства",""));
		ИначеЕсли ЭлементРодитель = "Документы" Тогда
			Результат.Вставить("ШаблонНаименования", "Документ.");
		ИначеЕсли ЭлементРодитель = "Справочники" Тогда
			Результат.Вставить("ШаблонНаименования", "Справочник.");
		КонецЕсли;
	ИначеЕсли ТипЗнч(ТекЭлемент) = Тип("Строка") Тогда
		Результат.ДоступноИзменение = Истина;
		Если ТекЭлемент = "Перечисления" Тогда
			Результат.ИмяОбъекта = "ОбъектыФормата";
			Результат.Вставить("ШаблонНаименования", "Перечисление.");
			ЕстьОпределенность = Истина;
		ИначеЕсли ТекЭлемент = "Документы" Тогда
			Результат.ИмяОбъекта = "ОбъектыФормата";
			Результат.Вставить("ШаблонНаименования", "Документ.");
			ЕстьОпределенность = Истина;
		ИначеЕсли ТекЭлемент = "Справочники" Тогда
			Результат.ИмяОбъекта = "ОбъектыФормата";
			Результат.Вставить("ШаблонНаименования", "Справочник.");
			ЕстьОпределенность = Истина;
		ИначеЕсли ТекЭлемент = "Типы" ИЛИ ТекЭлемент = "Ссылочные" ИЛИ ТекЭлемент = "Простые" Тогда
			Результат.ИмяОбъекта = "ТипыФормата";
			ЕстьОпределенность = Истина;
			Если ТекЭлемент = "Простые" Тогда
				Результат.Вставить("ПространствоИменБазовогоТипа", "http://www.w3.org/2001/XMLSchema");
			ИначеЕсли ТекЭлемент = "Ссылочные" Тогда
				Результат.Вставить("ПространствоИменБазовогоТипа", "http://www.1c.ru/SSL/Exchange/Message");
				Результат.Вставить("БазовыйТип", "Ref");
			КонецЕсли;
		ИначеЕсли ТекЭлемент = НСтр("ru = 'Группы общих свойств'") Тогда
			Результат.ИмяОбъекта = "ОбъектыФормата";
			Результат.Вставить("ТипОбщегоРеквизита", "ГруппаОбщихСвойств");
			Результат.Вставить("ШаблонНаименования", "ОбщиеСвойства");
			ЕстьОпределенность = Истина;
		ИначеЕсли ТекЭлемент = НСтр("ru = 'Общие табличные части'") Тогда
			Результат.ИмяОбъекта = "ОбъектыФормата";
			Результат.Вставить("ТипОбщегоРеквизита", "ОбщаяТабличнаяЧасть");
			ЕстьОпределенность = Истина;
		КонецЕсли;
	КонецЕсли;
	Если НЕ ЕстьОпределенность Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуСКонтекстом(СтруктураКонтекст)
	ПараметрыФормы = Новый Структура("ПараметрыДерева", СтруктураКонтекст);
	Если СтруктураКонтекст.ИмяОбъекта = "ОбъектыФормата" Тогда
		ИмяФормыСправочника = "Справочник.ОбъектыФормата.ФормаОбъекта";
	ИначеЕсли СтруктураКонтекст.ИмяОбъекта = "СвойстваФормата" Тогда
		Если СтруктураКонтекст.ДоступноИзменение = Ложь Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Добавление свойства невозможно.'"));
			Возврат;
		КонецЕсли;
		Если СтруктураКонтекст.Свойство("ГруппаСвойств") Тогда
			Если СтруктураКонтекст.ГруппаСвойств Тогда
				ПараметрыФормы.Вставить("ЭтоГруппа", Истина);
				ИмяФормыСправочника = "Справочник.СвойстваФормата.ФормаГруппы";
			Иначе
				ИмяФормыСправочника = "Справочник.СвойстваФормата.ФормаОбъекта";
			КонецЕсли;
		Иначе
			ИмяФормыСправочника = ФормаСправочникаСвойстваФормата(Элементы.ДеревоФормата.ТекущиеДанные.Элемент);
		КонецЕсли;
	ИначеЕсли СтруктураКонтекст.ИмяОбъекта = "ЗначенияФормата" Тогда
		ИмяФормыСправочника = "Справочник.ЗначенияФормата.ФормаОбъекта";
	ИначеЕсли СтруктураКонтекст.ИмяОбъекта = "ТипыФормата" Тогда
		ИмяФормыСправочника = "Справочник.ТипыФормата.ФормаОбъекта";
	Иначе
		Возврат;
	КонецЕсли;
	ОткрытьФорму(ИмяФормыСправочника, ПараметрыФормы);
КонецПроцедуры

&НаСервере
Процедура ПереместитьНаСервере(Направление, ТекЭлемент, МассивЭлементов)
	ТекПорядок = ТекЭлемент.Порядок;
	
	Запрос = Новый Запрос;
	ТекстЗапроса = "ВЫБРАТЬ ПЕРВЫЕ 1
	|Ссылка,
	|Наименование,
	|Порядок
	|ИЗ Справочник.СвойстваФормата
	|ГДЕ Ссылка В (&МассивЭлементов) И Ссылка <> &ТекЭлемент";
	Если Направление > 0 Тогда
		// Вверх
		ТекстЗапроса = ТекстЗапроса + " И Порядок < &ТекПорядок
		|УПОРЯДОЧИТЬ ПО Порядок УБЫВ, Наименование УБЫВ";
	Иначе
		// Вниз
		ТекстЗапроса = ТекстЗапроса + " И Порядок > &ТекПорядок
		|УПОРЯДОЧИТЬ ПО Порядок ВОЗР, Наименование ВОЗР";
	КонецЕсли;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("МассивЭлементов", МассивЭлементов);
	Запрос.УстановитьПараметр("ТекПорядок", ТекПорядок);
	Запрос.УстановитьПараметр("ТекЭлемент", ТекЭлемент);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		// При возможности - поменяться порядком с предыдущим или последующим элементом.
		ПорядокНов = Выборка.Порядок;
		ЭлементОбъект1 = ТекЭлемент.ПолучитьОбъект();
		ЭлементОбъект1.Порядок = ПорядокНов;
		ЭлементОбъект1.Записать();
		ЭлементОбъект1 = Выборка.Ссылка.ПолучитьОбъект();
		ЭлементОбъект1.Порядок = ТекПорядок;
		ЭлементОбъект1.Записать();
	КонецЕсли;
КонецПроцедуры



#КонецОбласти


#КонецОбласти

