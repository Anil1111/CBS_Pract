﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _003_Task3
{
    public class MyClass
    {
        public string change;
        public MyClass(string change)
        {
            this.change = change;
        }
        public string Change
        {
            set { change = value; }
            get { return change; }
        }
    }
}
