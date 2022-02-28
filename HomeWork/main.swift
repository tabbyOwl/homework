//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation

//MARK: Error

enum CofeeMachineError: Error {
    
    case insufficientCapasity
    case lackOfIngredients
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

struct Container {
    
    var ingredient: Ingredients
    var volume: Int
    var capasity: Int
}

enum Ingredients {
    case cofee
    case milk
    case cream
    case water
}

//MARK: CofeeMashine

final class CofeeMashine {
    
    private var cofeeContainer = Container(ingredient: .cofee, volume: 0, capasity: 100)
    private var milkContainer = Container(ingredient: .milk, volume: 0, capasity: 1000)
    private var creamContainer = Container(ingredient: .cream, volume: 0, capasity: 1000)
    private var waterContainer = Container(ingredient: .water, volume: 0, capasity: 1000)
    
    var coinsDeposite: Int = 0

    var menu = [Cofee.Esspresso: Product(cofee: .Esspresso, price: 60),
                .Latte: Product(cofee: .Latte, price: 70),
                .Capuchino: Product(cofee: .Capuchino, price: 80),
                .Machiato: Product(cofee: .Machiato, price: 75)]
    
    // по заданию: возвращать либо значение, либо ошибку Error
    func orderCofee(cofee: Cofee) -> (Cofee?, CofeeMachineError?) {
        
        guard coinsDeposite >= menu[cofee]!.price else {
            print("Не хватает \(menu[cofee]!.price - coinsDeposite) рублей")
            return (nil, CofeeMachineError.insufficientFunds(coinsNeeded: menu[cofee]!.price - coinsDeposite))
        }
        
        do {
            try makeCofee(cofee: cofee)
        } catch CofeeMachineError.lackOfIngredients {
            print("Не хватает ингридиентов. Необходимо заполнить контейнеры")
            return (nil, CofeeMachineError.lackOfIngredients)
        } catch let error {
            print(error.localizedDescription)
        }
        coinsDeposite -= menu[cofee]!.price
        return (cofee, nil)
    }
    
    private func makeCofee(cofee: Cofee) throws {
        
        switch cofee {
            
        case .Esspresso:
            guard cofeeContainer.volume >= 7 && waterContainer.volume >= 60 else {
                throw CofeeMachineError.lackOfIngredients
            }
            cofeeContainer.volume -= 7
            waterContainer.volume -= 60
            
        case .Machiato:
            guard cofeeContainer.volume >= 7 && waterContainer.volume >= 60 && creamContainer.volume >= 60 else {
                throw CofeeMachineError.lackOfIngredients
            }
            cofeeContainer.volume -= 7
            waterContainer.volume -= 60
            creamContainer.volume -= 60
            
        case .Latte:
            guard cofeeContainer.volume >= 7 && waterContainer.volume >= 60 && milkContainer.volume >= 90 else {
                throw CofeeMachineError.lackOfIngredients
            }
            cofeeContainer.volume -= 7
            waterContainer.volume -= 60
            milkContainer.volume -= 90
            
        case .Capuchino:
            guard cofeeContainer.volume >= 7 && waterContainer.volume >= 60 && creamContainer.volume >= 60 && milkContainer.volume >= 90 else {
                throw CofeeMachineError.lackOfIngredients
            }
            cofeeContainer.volume -= 7
            waterContainer.volume -= 60
            creamContainer.volume -= 60
            milkContainer.volume -= 60
        }
    }
    
    func fill(ingredient: Ingredients, volume: Int) {
        do {
            try fillIngredients(ingredient: ingredient, volume: volume)
        } catch CofeeMachineError.insufficientCapasity {
            print("Недостаточно места")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fillIngredients(ingredient: Ingredients, volume: Int) throws {
        switch ingredient {
        case .cofee:
            guard cofeeContainer.capasity >= cofeeContainer.volume + volume else {
                throw CofeeMachineError.insufficientCapasity
            }
            cofeeContainer.volume += volume
        case .milk:
            guard milkContainer.capasity >= milkContainer.volume + volume else {
                throw CofeeMachineError.insufficientCapasity
            }
            milkContainer.volume += volume
        case .cream:
            guard creamContainer.capasity >= creamContainer.volume + volume else {
                throw CofeeMachineError.insufficientCapasity
            }
            creamContainer.volume += volume
        case .water:
            guard waterContainer.capasity >= waterContainer.volume + volume else {
                    throw CofeeMachineError.insufficientCapasity
            }
            waterContainer.volume += volume
        }
    }
    
}

