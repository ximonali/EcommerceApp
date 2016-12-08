//
//  ProductClass.swift
//  Assignment_Ecommerce
//
//  Created by Laercio Moura on 2016-04-02.
//  Copyright (c) 2016 SAmerica. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class ProductClass {
    var id:Int
    var name: String
    var imageD: String
    var image: UIImage
    var detail: String
    var price: Double
    var total: Int
    var quantity: Int = 0
    var brand: String
    var model: String
    var category: String
    
    init() {
        self.id = UserInfo.productList.count
        self.name = ""
        self.imageD = ""
        self.image = UIImage()
        self.detail = ""
        self.price = 0.0
        self.total = 0
        self.brand = ""
        self.category = ""
        self.model = ""
    }
    
    init(pName:String, pImage:String, pDetail: String, pPrice: Double, pTotal:Int,pBrand:String,pCategory:String,pModel:String) {
        self.id = UserInfo.productList.count
        self.name = pName
        self.imageD = pImage
        self.image = UIImage(named: self.imageD)!
        self.detail = pDetail
        self.price = pPrice
        self.total = pTotal
        self.brand = pBrand
        self.category = pCategory
        self.model = pModel
    }
    
    func addProduct(pProduct: ProductClass) {
        pProduct.id = UserInfo.productList.count
        UserInfo.productList.append(pProduct)
        save()
    }
    
    func editProduct(pProduct: ProductClass) {
        UserInfo.productList[pProduct.id] = pProduct
        save()
    }
    
    func deleteProduct(pIndex: Int) {
        UserInfo.productList.removeAtIndex(pIndex)
        save()
    }
    
    func getProduct(pIndex: Int) -> ProductClass {
        return UserInfo.productList[pIndex]
    }
    
    //Function to Load the default Products
    func load() {
        UserInfo.productList = []
        var context = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "Product")
        var error: NSError? = nil
       
        let objects = context?.executeFetchRequest(request, error: &error)
        if let objectList = objects {
            for product in objectList {
                var loadProduct = ProductClass()
                loadProduct.id = product.valueForKey("id")!.integerValue
                loadProduct.name = product.valueForKey("name") as! String
                loadProduct.imageD = product.valueForKey("image") as! String
                loadProduct.image = UIImage(named: loadProduct.imageD)!
                loadProduct.detail = product.valueForKey("detail") as! String
                loadProduct.price = product.valueForKey("price")!.doubleValue
                loadProduct.total = product.valueForKey("total")!.integerValue
                loadProduct.brand = product.valueForKey("brand") as! String
                loadProduct.category = product.valueForKey("category") as! String
                loadProduct.model = product.valueForKey("model") as! String
                UserInfo.productList.append(loadProduct)
            }
        }
      
        if UserInfo.productList.count == 0 {
            var item01 = ProductClass(pName: "HP Pavilion 13.3-Inch", pImage: "hpPavilion1", pDetail: "AMD A8-6410, 6GB, 500GB, AMD Radeon R5 Graphics, Windows 8.1", pPrice: 723.00, pTotal: 20, pBrand: "Hewlett Packard", pCategory: "Laptop", pModel: "HP Pavilion Z")
            self.addProduct(item01)
            
            var item02 = ProductClass(pName: "Apple iPhone 6S", pImage: "iphone6S1", pDetail: "Gold, 16 GB, 4.7Inch, (Unlocked)", pPrice: 800.00, pTotal: 30, pBrand: "Apple", pCategory: "Smartphone", pModel: "iPhone 6S")
            self.addProduct(item02)
            
            var item03 = ProductClass(pName: "Samsung Galaxy S7", pImage: "samsungS71", pDetail: "S7 G930F 32GB Factory Unlocked GSM", pPrice: 943.00, pTotal: 20, pBrand: "Samsung", pCategory: "Smartphone", pModel: "Samsung Galaxy S7")
            self.addProduct(item03)
            
            var item04 = ProductClass(pName: "HP Star Wars Special Edition", pImage: "hpStarWars", pDetail: "Intel Core i5, 8 GB RAM, 1 TB HDD, Windows 10", pPrice: 882.00, pTotal: 08, pBrand: "Hewlett Packard", pCategory: "Laptop", pModel: "HP Star Wars SE")
            self.addProduct(item04)
            
            var item05 = ProductClass(pName: "Apple iMac with Retina 5K display", pImage: "imac5k1", pDetail: "3.5GHz quad-core Intel Core i5 processor,8GB (two 4GB) of 1600MHz DDR3", pPrice: 5017.00, pTotal: 05, pBrand: "Apple", pCategory: "Computer", pModel: "iMac Retina 5K")
            self.addProduct(item05)
            
            var item06 = ProductClass(pName: "Dell Optiplex", pImage: "dellOptiplex1", pDetail: "1.8GHz Dual Core Processor,2GB DDR2 Memory,80GB HDD", pPrice: 200.00, pTotal: 10, pBrand: "Dell", pCategory: "Computer", pModel: "Dell Optiplex Desktop")            
            self.addProduct(item06)
        }
        
    }
    
    func save() {
        var context = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "Product")
        var error: NSError? = nil
        for var i = 0; i < UserInfo.productList.count; i++ {
            let getProduct = UserInfo.productList[i]
            
            let request = NSFetchRequest(entityName: "Product")
            let pred = NSPredicate(format: "%K = %d", "id", i)
            request.predicate = pred
            
            let objects = context?.executeFetchRequest(request, error: &error)
            if let objectList = objects {
                var theLine:NSManagedObject! = nil
                if objectList.count > 0 {
                    theLine = objectList[0] as! NSManagedObject
                } else {
                    theLine = NSEntityDescription.insertNewObjectForEntityForName("Product", inManagedObjectContext: context!) as! NSManagedObject
                }
                theLine.setValue(getProduct.id, forKey:"id")
                theLine.setValue(getProduct.name, forKey: "name")
                theLine.setValue(getProduct.imageD, forKey: "image")
                theLine.setValue(getProduct.detail, forKey: "detail")
                theLine.setValue(getProduct.price, forKey: "price")
                theLine.setValue(getProduct.total, forKey: "total")
                theLine.setValue(getProduct.brand, forKey: "brand")
                theLine.setValue(getProduct.category, forKey: "category")
                theLine.setValue(getProduct.model, forKey: "model")
            }
        }
        context?.save(&error)
    }
    
}