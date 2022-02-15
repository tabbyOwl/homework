//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation
//1. Написать функцию, которая определяет, четное число или нет

func isEven(_ number: Int) -> Bool {
    return number % 2 == 0
}

//2. Написать функцию, которая определяет, делится ли число без остатка на 3

func isMultipleOfThree(_ number: Int) -> Bool {
    return number % 3 == 0
}

//3. Создать возрастающий массив из 100 чисел

var numbers = [Int]()

for number in 1...100 {
    numbers.append(number)
}

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3

for number in numbers {
    if isEven(number) || !isMultipleOfThree(number) {
        numbers = numbers.filter() {$0 != number}
    }
}


//5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов

var fibonacciNumbers = [0, 1]

for _ in 1...50 {
    
    fibonacciNumbers.append (fibonacciNumbers[fibonacciNumbers.count - 2] + fibonacciNumbers[fibonacciNumbers.count - 1])
}


//6. Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу.
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.

var simpleNumbers = [Int]()

for i in 2...542 {
    simpleNumbers.append(i)
}

var step = simpleNumbers[0]
var index = 0

while simpleNumbers.count > 100 {
    for number in simpleNumbers {
        if number % step == 0 && number != step {
            simpleNumbers = simpleNumbers.filter() {$0 != number}
        }
    }
    if simpleNumbers.count > step - 1 {
        index = index + 1
        step = simpleNumbers[index]
    } else {
        break
    }
}


