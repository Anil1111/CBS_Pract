﻿using System;                                   //Комментарии по поводу задачи (включая текст задания): Создать класс MyMatrix, обеспечивающий представление матрицы произвольного размера с возможностью изменения числа строк и столбцов. Написать программу, которая выводит на экран матрицу и производные от нее матрицы разных порядков.    //--мне чего-то кажется, что производные от неё матрицы разных порядков - это не математические вычисления, а возможность при запуске прогарммы указывать любое количество строк и столбцов. - ...правильная мысль была, т.к. в видео по решению задачи - так и оказалось, там гораздо меньше нужно сделать, чем можно подумать сначала. Формулировка задачи была "усложнённой" и пожалуй неправильной.   //--там не надо в интернете искать информацию о том, что такое "производная", что такое "производная матрица", про порядки матриц и т.д. В задаче - это не математические вычисления, а возможность при запуске прогарммы указывать любое количество строк и столбцов. На самом деле требуется сделать матрицу с возможностью изменять количество строк и столбцов. Т.о. всё, что необходимо сделать (в т.ч. и для дополнения - так сказать для полноты и чтоб попрактиковаться больше (в видео так же сделали)):
using System.Collections.Generic;               //(для разных действий можно заводить отдельные методы) Создать матрицу с 
using System.Linq;                              //возможностью задания числа строк и столбцов; выводить на экран всю матрицу; 
using System.Text;                              //выводить на экран отдельные элементы по индексу; возможность заменить значение 
using System.Threading.Tasks;                   //какого-либо элемента; сделать функцию изменения размеров матрицы 
                                                //(как по столбцам, так и по строкам конечно), причём неважно становится она 
namespace Task3                                 //при этом больше или меньше в каком-то измерении, с проверками, естественно, 
{                                               //и с заполнением "излишков" после изменения размеров матрицы - можно рандомно; 
    class Program                               //разработать метод для показа "частичной" матрицы (задавая, конечно, эти размеры)
    {                                           //Автор в видео "выполнение домашнего задания" ещё советовал, если есть время,
        static void Main(string[] args)         //сделать нахождение определителя матрицы (вообще там много чего можно понаде-
        {                                       //лать - сложение, умножение и т.п....)
            MyMatrix matrix = new MyMatrix(10, 5);
            matrix.Show();

            Console.WriteLine(new string('-', 30));

            Console.WriteLine("элемент с индексом (1,4) = {0}", matrix[1,4]);
            Console.WriteLine("элемент с индексом (5,3) = {0}", matrix[5, 3]);
            matrix[2, 2] = 100;
            Console.WriteLine("элемент с индексом (2,2) = {0}", matrix[2, 2]);

            Console.WriteLine(new string('-', 30));

            matrix.ChangeSize(5, 11);
            matrix.Show();

            Console.WriteLine(new string('-', 30));

            matrix.ShowPart(2, 3, 4, 10);
        }                                       
    }
}