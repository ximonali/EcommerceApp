//
//  UserClass.swift
//  Assignment_Ecommerce
//
//  Created by Laercio Moura on 2016-04-02.
//  Copyright (c) 2016 SAmerica. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class UserClass {
    var id: Int
    var email: String
    var password: String
    var name: String
    var type: String
    
    
    init() {
        self.id = UserInfo.userList.count
        self.email  = ""
        self.password = ""
        self.name = ""
        self.type = "User"
    }
    
    init(pEmail:String, pPassword:String,pName:String,pType:String = "User") {
        self.id = UserInfo.userList.count
        self.email = pEmail
        self.password = pPassword
        self.name = pName
        self.type = pType
    }
    
    
    
    func addUser(pUser: UserClass) {
        pUser.id = UserInfo.userList.count
        UserInfo.userList.append(pUser)
        save()
    }

    func editUser(pUser: UserClass) {
        UserInfo.userList[pUser.id] = pUser
        save()
    }
    
    func login(pEmail: String, pPassword:String) ->(user: UserClass, check: Bool) {
        for user in UserInfo.userList {
            if (user.email==pEmail && user.password==pPassword) {
                return (user, true)
            }
        }
        
        return (UserClass(), false)
    }
    
    func userExist(pUser: UserClass) ->Bool {
        for user in UserInfo.userList {
            if (user.email==pUser.email) {
                return true
            }
        }
        return false
    }
    
    //Function to load default user
    func load() {
        UserInfo.userList = []
        var context = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "User")
        var error: NSError? = nil
        
        let objects = context?.executeFetchRequest(request, error: &error)
        if let objectList = objects {
            for user in objectList {
                var loadUser = UserClass()
                loadUser.id = user.valueForKey("id")!.integerValue
                loadUser.email = user.valueForKey("email") as! String
                loadUser.password = user.valueForKey("password") as! String
                loadUser.name = user.valueForKey("name") as! String
                loadUser.type = user.valueForKey("type") as! String
                UserInfo.userList.append(loadUser)
            }
        }
        
        if UserInfo.userList.count == 0 {
            var defaultUser = UserClass(pEmail: "admin@admin", pPassword: "123456", pName: "Admin", pType: "Admin")
            UserInfo.userList.append(defaultUser)
            save()
        }
    }
    
    func save() {
        var context = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "User")
        var error: NSError? = nil
        for var i = 0; i < UserInfo.userList.count; i++ {
            let getUser = UserInfo.userList[i]
            
            let request = NSFetchRequest(entityName: "User")
            let pred = NSPredicate(format: "%K = %d", "id", i)
            request.predicate = pred
            
            let objects = context?.executeFetchRequest(request, error: &error)
            if let objectList = objects {
                var theLine:NSManagedObject! = nil
                if objectList.count > 0 {
                    theLine = objectList[0] as! NSManagedObject
                } else {
                    theLine = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context!) as! NSManagedObject
                }
                theLine.setValue(getUser.id,forKey:"id")
                theLine.setValue(getUser.email, forKey: "email")
                theLine.setValue(getUser.password, forKey: "password")
                theLine.setValue(getUser.name, forKey: "name")
                theLine.setValue(getUser.type, forKey: "type")
            }
            
        }
        context?.save(&error)
    }
    
}
