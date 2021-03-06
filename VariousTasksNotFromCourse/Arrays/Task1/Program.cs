﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;		//https://infourok.ru/sbornik-zadach-po-teme-massivi-2705799.html

namespace Task1						//Задан упорядоченный по возрастанию целочисленный массив. Сформировать второй массив из случайных целых чисел, которые не встречаются в первом 
{
	class Program
	{
		static void Main(string[] args)
		{
			Random rand = new Random();
			int element, insertPosition;

			int[] array = new int[rand.Next(100)];
			Console.WriteLine("Массив имеет: {0} элементов", array.Length);

			for (int i = 0; i < array.Length; i++)							//комментирую, чтоб не читать потом долго код... Заполняем массив случайными числами так, чтобы при добавлении каждого нового элемента, он уже был отсортирован.
			{
				element = rand.Next(100);

				if (i == 0)													//при первой итерации нечего сортировать, поэтому просто вносим элемент, а затем пропускаем всю остальную итерацию.
				{
					array[i] = element;
					continue;
				}

				insertPosition = i - 1;


				if (element < array[insertPosition])
				{
					while (element < array[insertPosition] && insertPosition > 0)	//находим позицию для текущего элемента, при которой весь массив будет упорядочен по возрастанию.
					{
						insertPosition--;
					}

					for (int j = i; j > insertPosition; j--)						//сдвигаем элементы вправо, начиная с элемента на последней позиции до элемента, который находится на необходимой позицией, для освобождения этой позиции для нового элемента.
					{
						array[j] = array[j - 1];
					}

					array[insertPosition] = element;								//добавляем элемент на необходимую позицию. 
				}
				else
				{
					array[i] = element;
				}
			}

			for (int i = 0; i < array.Length; i++)							//выводим массив
			{
				Console.WriteLine(array[i]);
			}



		}
	}
}
