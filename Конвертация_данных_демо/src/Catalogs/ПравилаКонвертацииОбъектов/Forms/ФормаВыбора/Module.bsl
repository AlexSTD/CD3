#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	ЭтаФорма.Закрыть(ВыбранноеЗначение);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если ЭтаФорма.Параметры.Отбор.Количество() > 0 Тогда
		
		ЭтаФорма.Список.Отбор.Элементы.Очистить();
		Список.Параметры.УстановитьЗначениеПараметра("ОтборОтключен", Истина);
		Для Каждого ТекОтбор Из ЭтаФорма.Параметры.Отбор Цикл
			ИмяОтбора = ТекОтбор.Ключ;
			ЗначениеОтбора = ТекОтбор.Значение;
			Если ИмяОтбора = "Конвертация" Тогда
				Список.Параметры.УстановитьЗначениеПараметра("Конвертация", ЗначениеОтбора);
				Список.Параметры.УстановитьЗначениеПараметра("ОтборОтключен", Ложь);
				Продолжить;
			КонецЕсли;
			
			ЭлементОтбора = ЭтаФорма.Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));  
			ЭлементОтбора.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных(ИмяОтбора);
			ЭлементОтбора.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
			ЭлементОтбора.Использование  = Истина;
			ЭлементОтбора.ПравоеЗначение = ЗначениеОтбора;
			ЭлементОтбора.Представление = ""+ИмяОтбора+" = "+ЗначениеОтбора;
			ЭлементОтбора.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ;
		КонецЦикла;
	Иначе
		Список.Параметры.УстановитьЗначениеПараметра("Конвертация", Неопределено);
		Список.Параметры.УстановитьЗначениеПараметра("ОтборОтключен", Истина);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти