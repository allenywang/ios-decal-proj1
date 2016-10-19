//
//  Todo.swift
//  TodoApp
//
//  Created by Allen Wang on 10/18/16.
//  Copyright © 2016 Allen Wang. All rights reserved.
//

import UIKit

class Todo: NSObject, NSCoding {
    var name: String
    var desc: String
    var completed: Bool
    var timestamp: Date
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    init(name: String, desc: String, completed: Bool = false, timestamp:Date = Date()) {
        self.name = name
        self.desc = desc
        self.completed = completed
        self.timestamp = timestamp
    }
    
    func hasExpired() -> Bool{
        return completed && (timestamp.timeIntervalSinceNow < -(60 * 60 * 24))
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(completed, forKey: "c")
        aCoder.encode(timestamp, forKey: "t")
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        let completed = aDecoder.decodeBool(forKey: "c")
        let timestamp = aDecoder.decodeObject(forKey: "t") as! Date
        self.init(name:name, desc:desc, completed:completed, timestamp:timestamp)
    }

}
