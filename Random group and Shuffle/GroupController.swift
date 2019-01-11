//
//  GroupController.swift
//  Six Week Technical Challenge
//
//  Created by Greg Hughes on 1/11/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import Foundation

class GroupController{
    
    static let shared = GroupController()
    
    private init(){
        
        self.personList = loadFromPersistentStorage()
    }
    
    
    var indexOfPerson = 0
    var personList : [String] = []
    var groups : [Group] = []
    
    
    
    func createPerson(person: String){
        
        personList.append(person)
        createGroups()
        saveToPersistentStorage()
    }
    
    func delete(person: String){
        guard let index = personList.index(of: person) else { return }
        
        personList.remove(at: index)
        
        saveToPersistentStorage()
        
    }
    
    func prepareGroups(){
        
       
        
        if personList.count == 0 {
            // if there are no new people, return
            return
        }
            
        else if personList.count - indexOfPerson == 1{
            // if theres one person in the array and index = 0, that means theres one person in the list, so add them
            let group = Group(person1: personList[indexOfPerson])
            //take the string in the person list at position 0 and make a group out of them
            groups.append(group)
            return
            
        }
            
        else if personList.count - indexOfPerson >= 2{
            // if index is 0 and theres now 2 people in the person List array, create a group out of them and append it
            
            let group = Group(person1: personList[indexOfPerson], person2: personList[indexOfPerson + 1])
            
//            create a group out of person in position 0 and 1
                indexOfPerson += 2
  //            we do this so we can create a group again out of position until         we run out of people in the list

                groups.append(group)
                prepareGroups()
        }
        indexOfPerson = 0
        //make groups zero so we can append them when we shuffle
    }
    
    
    func prepareForshuffleList(personList: [String]){
        //plug in our previous personList into this spot
        
        let personCount = personList.count
        
        if personCount == 0 {
            return
        }
        else if personCount - indexOfPerson == 1 {
            
            let group = Group(person1: personList[indexOfPerson])
            
            groups.append(group)
            return
        }
        else if personCount - indexOfPerson >= 2{
            let group = Group(person1: personList[indexOfPerson], person2: personList[indexOfPerson + 1])
            
            
            indexOfPerson += 2
            groups.append(group)
            prepareForshuffleList(personList: personList)
//            add two and run through the function again until we reach the end of our array
            
        }
        indexOfPerson = 0
    }
    
    func shuffle(){
        groups = []
        //make groups 0 so when we append more groups it doesnt add to our existing groups
        let shuffledPeople = personList.shuffleButAllowed()
        
        prepareForshuffleList(personList: shuffledPeople)

    }
    func createGroups(){
        groups = []
        prepareGroups()
        
    }
    
//    func shuffledPeople(){
//    var items = ["A", "B", "C", "D", "E", "F", "G", "H"]
//    var shuffled = [String]();
//
//    for i in 0..<personList.count
//    {
//    let rand = Int(arc4random_uniform(UInt32(personList.count)))
//      // rand = a random number ind
//    shuffled.append(personList[rand])
//
//    personList.remove(at: rand)
//    }
//// not enough time
//
//    }
    
    
    
    func fileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
//        let fileName = "personList2.json"
        let fileName = "personList2.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        // this adds a word to the file URL
        print(fullURL)
        
        return fullURL
        
    }
    
    
    
    func saveToPersistentStorage(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(personList)
            try data.write(to: fileURL())
        } catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
    }
    
    
    func loadFromPersistentStorage() -> [String] {
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            let personList = try decoder.decode([String].self, from: data)
            return personList
        }catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
        return []
    }
    
    //crud
}
