//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation

//MARK: Error

enum CofeeMachineError: Error {

    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
}


//MARK: Cofee

struct Product {
    
    var cofee: Cofee
    var price: Int
}

enum Cofee {
    
    case Esspresso
    case Machiato
    case Latte
    case Capuchino
    
}

//MARK: containers

struct CofeeContainer {
    
    var weight: Int
    
}

struct MilkContainer {
    
    var volume: Int
}

struct CreamContainer {
    
    var volume: Int
}

struct WaterContainer {
    
    var volume: Int
}

//MARK: CofeeMashine

class CofeeMashine {
    
    var cofeeContainer = CofeeContainer(weight: 15)
    var milkContainer = MilkContainer(volume: 120)
    var creamContainer = CreamContainer(volume:120)
    var waterContainer = WaterContainer(volume: 120)
    
    var coinsDeposite: Int = 0

    var menu = [Cofee.Esspresso: Product(cofee: .Esspresso, price: 60),
                .Latte: Product(cofee: .Latte, price: 70),
                .Capuchino: Product(cofee: .Capuchino, price: 80),
                .Machiato: Product(cofee: .Machiato, price: 75)]
    
    func orderCofee(cofee: Cofee) -> (Cofee?, CofeeMachineError?) {
        
        guard coinsDeposite >= menu[cofee]!.price else {
            print("Не хватает \(menu[cofee]!.price - coinsDeposite) рублей")
            return (nil, CofeeMachineError.insufficientFunds(coinsNeeded: menu[cofee]!.price - coinsDeposite))
        }
        
        do {
            try makeCofee(cofee: cofee)
        } catch CofeeMachineError.invalidSelection {
            print("Не хватает ингридиентов. Необходимо заполнить контейнеры")
            return (nil, CofeeMachineError.invalidSelection)
        } catch let error {
            print(error.localizedDescription)
        }
        coinsDeposite -= menu[cofee]!.price
        return (cofee, nil)
    }
    
    private func makeCofee(cofee: Cofee) throws -> Cofee? {
        
        switch cofee {
            
        case .Esspresso:
            guard cofeeContainer.weight >= 7 && waterContainer.volume >= 60 else {
                throw CofeeMachineError.invalidSelection
            }
            cofeeContainer.weight -= 7
            waterContainer.volume -= 60
            
        case .Machiato:
            guard cofeeContainer.weight >= 7 && waterContainer.volume >= 60 && creamContainer.volume >= 60 else {
                throw CofeeMachineError.invalidSelection
            }
            cofeeContainer.weight -= 7
            waterContainer.volume -= 60
            creamContainer.volume -= 60
            
        case .Latte:
            guard cofeeContainer.weight >= 7 && waterContainer.volume >= 60 && milkContainer.volume >= 90 else {
                throw CofeeMachineError.invalidSelection
            }
            cofeeContainer.weight -= 7
            waterContainer.volume -= 60
            milkContainer.volume -= 90
            
        case .Capuchino:
            guard cofeeContainer.weight >= 7 && waterContainer.volume >= 60 && creamContainer.volume >= 60 && milkContainer.volume >= 90 else {
                throw CofeeMachineError.invalidSelection
            }
            cofeeContainer.weight -= 7
            waterContainer.volume -= 60
            creamContainer.volume -= 60
            milkContainer.volume -= 60
        }
        return cofee
    }
}


var cofee = CofeeMashine()
cofee.coinsDeposite = 80
cofee.orderCofee(cofee: .Capuchino)
cofee.orderCofee(cofee: .Esspresso)

