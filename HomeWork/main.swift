//
//  main.swift
//  HomeWork
//
//  Created by jane on 15.02.2022.
//

import Foundation

struct Queue<T> {
    
    private var array: [T] = []
    
    var size: Int {
        
        return array.count
    }
    
    mutating func add (element: T) {
        
        array.append(element)
    }
    
    mutating func remove () {
        
        array.removeFirst()
    }
    
    func filter (element: (T) -> Bool) -> Queue<T> {
        
        var newQueue = Queue<T>()
        for i in array {
            if element(i) {
                newQueue.array.append(i)
            }
        }
        return newQueue
    }
    
    subscript(index: Int) -> (T?) {
        
        if index > array.count || index < 1 {
            return nil
        } else {
            let newIndex = index - 1
            return array[newIndex]
        }
    }
}

var queue = Queue<String>()


for number in 1...16 {
    queue.add(element: String(number))
}

var filteredQueue = queue.filter{ $0.contains("5")}

print(filteredQueue)
print(queue[9])
print(queue[20])
print(queue.size)

