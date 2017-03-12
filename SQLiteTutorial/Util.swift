//
//  Util.swift
//  SQLiteTutorial
//
//  Created by Ram Mhapasekar on 12/03/17.
//  Copyright © 2017 Ram Mhapasekar. All rights reserved.
//

import Foundation

import UIKit

class Util: NSObject {
    
    class func getPath(fileName: String) -> String {
        
        _ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        return fileURL!.path
    }
    
    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName: fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            _ = Bundle.main.resourceURL

            let fromPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItem(atPath: fromPath!.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            let alert: UIAlertView = UIAlertView()
            if (error != nil) {
                alert.title = "Error Occured"
                alert.message = error?.localizedDescription
            } else {
                alert.title = "Successfully Copy"
                alert.message = "Your database copy successfully"
            }
            alert.delegate = nil
            alert.addButton(withTitle: "Ok")
            alert.show()
        }
        else{
            
            let superheroDB = FMDatabase(path: dbPath)
            
            if (superheroDB?.open())! {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS SUPERHERO_INFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, POWER TEXT)"
                if !(superheroDB?.executeStatements(sql_stmt))! {
                    print("Error: \(superheroDB?.lastErrorMessage())")
                }
                superheroDB?.close()
            } else {
                print("Error: \(superheroDB?.lastErrorMessage())")
            }
        }
    }
}

extension UIViewController {
    func invokeAlertMethod(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
