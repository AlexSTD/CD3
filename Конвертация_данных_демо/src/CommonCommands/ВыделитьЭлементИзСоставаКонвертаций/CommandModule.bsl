#Область ОбработчикиСобытий
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Если НЕ ЗначениеЗаполнено(ПараметрКоманды) Тогда
		Возврат;
	КонецЕсли;

	ПараметрыФормы = Новый Структура("ЭлементКонвертации, СписокКонвертаций", ПараметрКоманды, ПараметрыВыполненияКоманды.Источник.СписокКонвертаций);
	ОткрытьФорму("ОбщаяФорма.ВопросВхождениеВСоставКонвертаций", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник);
КонецПроцедуры
#КонецОбласти