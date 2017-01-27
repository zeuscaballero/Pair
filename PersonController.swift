//
//  PersonController.swift
//  Pair
//
//  Created by zeus on 1/27/17.
//  Copyright © 2017 justzeus. All rights reserved.
//

import Foundation

class PersonController {
    fileprivate static let kPersons = "Persons"
    
    static let sharedController = PersonController()
    
    var persons: [Person] = []
    
        var pairs: [[Person]] {
            return addPairsFromPeople(arraysOfPeople: persons)
        }
    
    
    init(){
        loadFromPersistentStore()
        
    }
    
    
    func addPairsFromPeople(arraysOfPeople: [Person]) -> [[Person]] {
        
        let splitSize = 2
        let sectionsOfPeople = stride(from: 0, to: arraysOfPeople.count, by: splitSize).map { Array(arraysOfPeople[$0..<min($0 + splitSize, arraysOfPeople.count)]) }
        return sectionsOfPeople
    }
        
    
    func addName(name: String) {
        let newName = Person(name: name)
        persons.append(newName)
    saveToPersistentStore()
    }
    
    func randomize() {
        persons.random()
        saveToPersistentStore()
    }
    
//    func removeName(name: Person) {
//        guard let index = persons.index(of: name) else { return }
//        persons.remove(at: index)
//        saveToPersistentStore()
//        }
    
    func saveToPersistentStore() {
       let userDefaults = UserDefaults.standard
       let personDictionary = persons.map({$0.dictionaryRep})
        userDefaults.set(personDictionary, forKey: PersonController.kPersons)
    }
    
    func loadFromPersistentStore() {
        let userDefaults = UserDefaults.standard
        guard let personDictionary = userDefaults.object(forKey: PersonController.kPersons) as? [[String:Any]] else { return }
        persons = personDictionary.flatMap({Person(dictionary: $0)})
    }
    
}

extension Array {
    mutating func random() {
        for _ in 0..<10 { sort { (_,_) in arc4random() < arc4random() } }
    }
}


