﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _001_ReversedPrintOfArray
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] array = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 };

            for (int i = array.Length - 1; i >= 0; i--)
            {
                Console.Write("{0} ", array[i]);
            }
            Console.ReadKey();
        }
    }
}
