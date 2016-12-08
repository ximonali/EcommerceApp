//
//  ViewController2.swift
//
//
//  Created by Simon Gonzalez on 2016-03-27.
//
//

import UIKit

class Cart: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Vars
    var globalIndex: Int = 0
    var myCartObj = CartClass()
    
    
    //Controls
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var myCartTable: UITableView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBAction func btnCheckOut(sender: AnyObject) {
        self.performSegueWithIdentifier("go2CheckOut", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCartTable.delegate = self;
        myCartTable.dataSource = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        myCartTable.reloadData();
        btnCheck.hidden = UserInfo.myCart.count == 0
        lblUserName.text = UserInfo.userLogin.name
        imgProfile.image = UIImage(named: "Default")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //For my TableView
    //1
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //2
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        globalIndex = indexPath.row;
        //self.performSegueWithIdentifier("go2DetailsVC", sender: self)
        
    }
    //3
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.myCart.count
    }
    
    //4
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell2", forIndexPath: indexPath) as! TableViewCell2
        
        cell.imgProduct.image = UserInfo.myCart[indexPath.row].image
        cell.lblName.text = UserInfo.myCart[indexPath.row].name
        cell.lblDescription.text = UserInfo.myCart[indexPath.row].detail
        cell.lblPrice.text = "$" + String(format: "%.2f",UserInfo.myCart[indexPath.row].price)
        cell.lblCant.text = String(UserInfo.myCart[indexPath.row].quantity)
        
        return cell
    }
    
    //5 //To remore from table View
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var product = UserInfo.myCart[indexPath.row]
            myCartObj.removeProduct(UserInfo.myCart[indexPath.row].id)
            myCartTable.reloadData();
            btnCheck.hidden = UserInfo.myCart.count == 0
       }
        
    }
    
    //6 //To Enable DELETE from table View
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}//end Cart
