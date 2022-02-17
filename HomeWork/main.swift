//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation

//MARK: enum Action

enum Action {
    
    case loadTrunk(kg: Int)
    case unloadTrunk(kg: Int)
    case startEngine
    case stopEngine
    case closeWindows
    case openWindows
    case checkHeight(allowedHeight: Double)
    
    }

// MARK: parrent class Car

class Car {
    
    var garage : Garage?
    
    let name: String
    let year: Int
    let trunkCapacity: Int
    var trunkVolume: Int = 0
    var isEngineOn: Bool = false
    var isWindowsOpened: Bool = false
    
    init(name: String,
         year: Int,
         trunkCapacity: Int)
    {
        self.name = name
        self.year = year
        self.trunkCapacity = trunkCapacity
    }
    
    deinit {
        print("\(name) удален из памяти")
    }
    func printCharacteristics() {
        print("""
            Марка:\(name)
            Год выпуска: \(year)
            Вместительность багажника: \(trunkCapacity) кг
            """
            )
    }
    
    func action(action: Action) {
        
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
            print("Идет глушение двигателя")
            
        case .closeWindows:
            isWindowsOpened = false
            print("Окна закрываются")
            
        case .openWindows:
            isWindowsOpened = true
            print("Окна открываются")
            
        case .checkHeight:
            print("Нет ограничений по высоте")
            
        }
        
    }
    
}

//MARK: sportCar

final class SportCar: Car {
    
    let nameForGames: String
    
    init(name: String, year: Int, trunkCapacity: Int, nameForGames: String) {
        self.nameForGames = nameForGames
        super.init(name: name, year: year, trunkCapacity: trunkCapacity)
    }
    
    override func action(action: Action) {
        super.action(action: action)
    }
    
    override func printCharacteristics() {
        super.printCharacteristics()
        print("Имя для соревнования: \(nameForGames)")
    }
}


//MARK: truckCar

final class TruckCar : Car {
    
    let height: Double
    
    init(name: String,
                  year: Int,
                  trunkCapacity: Int,
                  height: Double)
    {
        self.height = height
        super.init(name: name,
                   year: year,
                   trunkCapacity: trunkCapacity)
    }
    
    override func printCharacteristics() {
        super.printCharacteristics()
        print("Высота  кузова: \(height)")
    }
    
    override func action(action: Action) {
        switch action {
            //изменила багажник на кузов
        case .loadTrunk(let kg) where (kg + trunkVolume) > trunkCapacity:
            print("Недостаточно места в кузове грузовика.")
            
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
            
        case .checkHeight(let allowedHeight):
            if allowedHeight <= height {
               print("Проезд разрешен")
            } else {
                print("Проезд запрещен")
            }
        }
    }
}

final class Garage {
    
    var boxNumber: Int
    weak var car: Car?
    
    init(boxNumber: Int) {
        self.boxNumber = boxNumber
    }
    
    deinit {
        print("Бокс номер \(boxNumber) удален")
    }
    
}

//MARK: actions

var truck = TruckCar(name: "Mercedes",
                     year: 2015,
                     trunkCapacity: 7000,
                     height: 1.8)

var sportCar = SportCar(name: "Aston Martin",
                        year: 2009,
                        trunkCapacity: 50,
                        nameForGames: "Nightmare")


truck.action(action: .loadTrunk(kg: 9000))

sportCar.action(action: .loadTrunk(kg: 90))

truck.action(action: .checkHeight(allowedHeight: 2))

truck.printCharacteristics()

sportCar.printCharacteristics()

// ARC проверка deinit

var garage: Garage?

var car: Car?

garage = Garage(boxNumber: 2)
car = Car(name: "audi", year: 2018, trunkCapacity: 40)

garage?.car = car
car?.garage = garage

car = nil


