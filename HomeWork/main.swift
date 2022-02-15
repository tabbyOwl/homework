//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation

// MARK: структура спортивный автомобиль

struct SportCar {
    
    let name: String
    let year: Int
    let trunkCapacity: Int
    var trunkVolume: Int = 0
    var isEngineOn: Bool = false
    var isWindowsOpened: Bool = false
    
    func printCharacteristics() {
        print("Марка: \(name)")
        print("Год выпуска: \(year)")
        print("Вместительность багажника: \(trunkCapacity) кг")
    }
    
    func printEngineCondition() {
        if isEngineOn {
            print("Двигатель запущен")
        } else {
            print("Двигатель заглушен")
        }
    }
    
    func printWindowsCondition (){
        if isWindowsOpened {
            print("Окна открыты")
        } else {
            print("Окна закрыты")
        }
    }
    
    mutating func action(action: Action) {
        
        switch action {
            
        case .loadTrunk(let kg) where (kg + trunkVolume) > trunkCapacity:
            print("Недостаточно места в багажнике.")
        case .loadTrunk(let kg):
            trunkVolume = kg + trunkVolume
            print("Загрузка \(kg) килограмм")
            
        case .unloadTrunk(let kg) where kg > trunkVolume:
            print("Невозможно выгрузить  \(kg) кг.")
        case .unloadTrunk(let kg):
            trunkVolume = trunkVolume - kg
            print("Выгрузка \(kg) кг")
            
        case .startEngine:
            isEngineOn = true
            print("Идет запуск двигателя")
            
        case .stopEngine:
            isEngineOn = false
            print("идет глушение двигателя")
            
        case .closeWindows:
            isWindowsOpened = false
            print("Окна закрываются")
            
        case .openWindows:
            isWindowsOpened = true
            print("Окна открываются")
        }
        
    }
}

// MARK: структура грузовой автомобиль

struct TruckCar {
    
    var name: String
    var year: Int
    var trunkCapacity: Int
    var trunkVolume: Int = 0
    var isEngineOn: Bool = false
    var isWindowsOpened: Bool = false
    
    func printCharacteristics() {
        print("Марка: \(name)")
        print("Год выпуска: \(year)")
        print("Вместительность кузова: \(trunkCapacity) кг")
    }
    
    func engineCondition() {
        if isEngineOn {
            print("Двигатель запущен")
        } else {
            print("Двигатель заглушен")
        }
    }
    
    func windowsCondition (){
        if isWindowsOpened {
            print("Окна открыты")
        } else {
            print("Окна закрыты")
        }
    }
    
    mutating func action(action: Action) {
        
        switch action {
            
        case .loadTrunk(let kg) where (kg + trunkVolume) > trunkCapacity:
            print("Недостаточно места в кузове.")
        case .loadTrunk(let kg):
            trunkVolume = kg + trunkVolume
            print("Загрузка \(kg) килограмм")
            
        case .unloadTrunk(let kg) where kg > trunkVolume:
            print("Невозможно выгрузить  \(kg) кг.")
        case .unloadTrunk(let kg):
            trunkVolume = trunkVolume - kg
            print("Выгрузка \(kg) кг")
            
        case .startEngine:
            isEngineOn = true
            print("Идет запуск двигателя")
            
        case .stopEngine:
            isEngineOn = false
            print("Идет глушение двигателя")
            
        case .closeWindows:
            isWindowsOpened = false
            print("Окна закрываются")
            
        case .openWindows:
            isWindowsOpened = true
            print("Окна открываются")
        }
        
    }
}

// MARK: Энум

enum Action {
    
    case loadTrunk(kg: Int)
    case unloadTrunk(kg: Int)
    case startEngine
    case stopEngine
    case closeWindows
    case openWindows
}


//MARK: Инициализация и использование функций

var carNumberOne = SportCar(name: "Aston Martin", year: 2002, trunkCapacity: 50)
var carNumberTwo = SportCar(name: "Lamborghini", year: 2010, trunkCapacity: 100)
var carNumberThree = TruckCar(name: "Mercedes", year: 2018, trunkCapacity: 7000)

carNumberOne.printCharacteristics()
carNumberOne.printEngineCondition()
carNumberOne.printWindowsCondition()
carNumberOne.action(action: .startEngine)
carNumberOne.action(action: .openWindows)
carNumberOne.printEngineCondition()
carNumberOne.printWindowsCondition()

print()

carNumberThree.printCharacteristics()
carNumberThree.action(action: .startEngine)
carNumberThree.action(action: .stopEngine)
carNumberThree.action(action: .loadTrunk(kg: 6000))
carNumberThree.action(action: .loadTrunk(kg: 2000))
carNumberThree.action(action: .startEngine)
carNumberThree.action(action: .stopEngine)
carNumberThree.action(action: .unloadTrunk(kg: 5000))
print("В кузове \(carNumberThree.trunkVolume) кг")

print()

// вывести все свойства в консоль
var garage: [Any] = [carNumberOne, carNumberTwo, carNumberThree]
for car in garage {
    print(car)
}



