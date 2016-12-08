//
//  UserInfo.swift
//  Ecommerce
//
//  Created by macadmin on 2016-04-04.
//  Copyright (c) 2016 Simon Gonzalez. All rights reserved.
//

import Foundation

struct UserInfo {
    //Login session
    static var userLogin = UserClass()
    static var myCart:[ProductClass] = []

    //User, Product and category list
    static var userList:[UserClass] = []
    static var productList:[ProductClass] = []
    static var categoryList: [String] = ["Computer","Smartphone","Laptop"]

    //Selected product
    static var selectProduct = ProductClass()
}