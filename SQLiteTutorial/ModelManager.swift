//
//  ModelManager.swift
//  SQLiteTutorial
//
//  Created by Ram Mhapasekar on 12/03/17.
//  Copyright © 2017 Ram Mhapasekar. All rights reserved.
//

import Foundation

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath(fileName: "SuperheroDB.sqlite"))
        }
        return sharedInstance
    }
    
    func addSuperheroData(superheroInfo: SUPERHERO_INFO) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO SUPERHERO_INFO (NAME, POWER) VALUES (?, ?)", withArgumentsIn: [superheroInfo.NAME, superheroInfo.POWER])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateSuperheroData(superheroInfo: SUPERHERO_INFO) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE SUPERHERO_INFO SET NAME=?, POWER=? WHERE ID=?", withArgumentsIn: [superheroInfo.NAME, superheroInfo.POWER, superheroInfo.ID])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteSuperheroData(superheroInfo: SUPERHERO_INFO) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM SUPERHERO_INFO WHERE ID=?", withArgumentsIn: [superheroInfo.ID])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllSuperheroData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM SUPERHERO_INFO", withArgumentsIn: nil)
        let marrSuperheroInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let superheroInfo : SUPERHERO_INFO = SUPERHERO_INFO()
                superheroInfo.ID = Int(resultSet.int(forColumn: "ID"))
                superheroInfo.NAME = resultSet.string(forColumn: "NAME")
                superheroInfo.POWER = resultSet.string(forColumn: "POWER")
                marrSuperheroInfo.add(superheroInfo)
            }
        }
        sharedInstance.database!.close()
        return marrSuperheroInfo
    }
}
