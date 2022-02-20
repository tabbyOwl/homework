//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation

//MARK: энум

enum Action {
    
    case loadTrunk(kg: Int)
    case unloadTrunk(kg: Int)
    case startEngine
    case stopEngine
    case closeWindows
    case openWindows
}

// MARK: протокол

protocol CarImpl {
    
    var name: String { get }
    var year: Int { get }
    var trunkCapacity: Int { get }
    var trunkVolume: Int { get set }
    var isEngineOn: Bool { get set }
    var isWindowsOpened: Bool { get set }
    
    func action ()
}

//MARK: Расширение для протокола

extension CarImpl {
    
    mutating func action (action: Action) {
        
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
        }
    }
}


//MARK: class sportCar

class SportCar: CarImpl {
    
    let name: String
    let year: Int
    let trunkCapacity: Int
    var trunkVolume: Int = 0
    var isEngineOn: Bool = false
    var isWindowsOpened: Bool = false
    let nameForGames: String
    
    init(name: String,
         year: Int,
         trunkCapacity: Int,
         nameForGames: String)
    {
        self.name = name
        self.year = year
        self.trunkCapacity = trunkCapacity
        self.nameForGames = nameForGames
    }
    
    func action() {}
    
    func checkHeight() {}
}

// MARK: Расширение для класса SportCar

extension SportCar: CustomStringConvertible {
    
    var description: String {
        return  """
        \n
        тип: Спорткар
        марка: \(name)
        год выпуска: \(year)
        имя в соревнованиях: \(nameForGames)
        """
    }
}

//MARK: class TruckCar

class TruckCar: CarImpl {
   
    let name: String
    let year: Int
    let trunkCapacity: Int
    var trunkVolume: Int = 0
    var isEngineOn: Bool = false
    var isWindowsOpened: Bool = false
    let height: Double
    
    init(name: String,
         year: Int,
         trunkCapacity: Int,
         height: Double)
    {
        self.name = name
        self.year = year
        self.trunkCapacity = trunkCapacity
        self.height = height
    }
    
    func action() {}
    
    func checkHeight(allowedHeight: Double) {
        if height < allowedHeight {
            print("Проезд разрешен")
        } else {
            print("Проезд запрещен")
        }
    }
}
// MARK: Расширение для класса TruckCar

extension TruckCar: CustomStringConvertible {
    
    var description: String {
        return  """
    \n
    тип: Грузовой
    марка: \(name)
    год выпуска: \(year)
    вместительность: \(trunkCapacity) кг
    """
    }
}

var sportCar = SportCar(name: "Lamborgini",
                        year: 2018,
                        trunkCapacity: 50,
                        nameForGames: "Arrow")

var truck = TruckCar(name: "Mercedes",
                     year: 2020,
                     trunkCapacity: 9000,
                     height: 1.9)

sportCar.action(action: .startEngine)
sportCar.action(action: .loadTrunk(kg: 80))
truck.action(action: .loadTrunk(kg: 8000))
truck.checkHeight(allowedHeight: 2)

print(sportCar, truck)
