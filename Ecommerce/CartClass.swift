//
//  CartClass.swift
//  Assignment_Ecommerce
//
//  Created by Laercio Moura on 2016-04-02.
//  Copyright (c) 2016 SAmerica. All rights reserved.
//

import Foundation

public class CartClass {
    
    var subTotal: Double
    var tax: Double
    var total: Double
    var productObj = ProductClass()
    init() {
        self.subTotal = 0.0
        self.tax = 0.0
        self.total = 0.0
    }
    
    func addProduct(pProduct: ProductClass) {
        var produtos = UserInfo.productList
        UserInfo.productList[pProduct.id].total -= pProduct.quantity
        productObj.save()
        var getIndex: Int = checkProduct(pProduct.id)
            
        if getIndex >= 0 {
            UserInfo.myCart[getIndex].quantity += pProduct.quantity
        } else {
            UserInfo.myCart.append(pProduct)
        }
    }
    
    func removeProduct(pIndex: Int) {
        var getProduct = UserInfo.productList[pIndex]
        UserInfo.productList[getProduct.id].total += getProduct.quantity
        productObj.save()
        var cartIndex = checkProduct(getProduct.id)
        UserInfo.myCart.removeAtIndex(cartIndex)
    }
    
    func checkProduct(pProductId: Int) -> Int {
        for (var i=0;i<UserInfo.myCart.count; i++) {
            if UserInfo.myCart[i].id == pProductId {
                return i
            }
        }
        return -1
    }
    
    func getTotal() {
        for product in UserInfo.myCart {
            var price = product.price * Double(product.quantity)
            self.subTotal += price
        }
        self.tax = self.subTotal * 0.13
        self.total = self.subTotal + self.tax
    }
    
}