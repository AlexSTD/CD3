#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	СоздатьПроектныеРешенияСервер(ПараметрКоманды);
	Сообщение = Новый СообщениеПользователю();
	Сообщение.Текст = НСтр("ru = 'Проектные решения созданы.'");
	Сообщение.Сообщить();
	
КонецПроцедуры
#КонецОбласти
#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура СоздатьПроектныеРешенияСервер(ПараметрКоманды);
	
	Для Каждого СтрокаСостава Из ПараметрКоманды.ГруппировкаОбъектовФормата.Состав Цикл
		
		ОбъектСтрокой = СтрокаСостава.ОбъектФормата;
		
		ПроектноеРешениеОбъект = Справочники.ПроектныеРешения.СоздатьЭлемент();
		ПроектноеРешениеОбъект.Заполнить(ПараметрКоманды);
		ПроектноеРешениеОбъект.ОбъектФормата = ОбъектСтрокой;
		ПроектноеРешениеОбъект.Операция = Перечисления.ОперацииСОбъектамиСвойствамиФормата.Изменен;
		ПроектноеРешениеОбъект.ОбменДанными.Загрузка = Истина;
		ПроектноеРешениеОбъект.Записать();
		
	КонецЦикла;
	
КонецПроцедуры
#КонецОбласти