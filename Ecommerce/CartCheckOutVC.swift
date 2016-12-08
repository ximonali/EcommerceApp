//
//  ViewController.swift
//  
//
//  Created by Simon Gonzalez on 2016-04-07.
//
//

import UIKit

class CartCheckOutVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Vars
    var globalIndex: Int = 0
    var cartObj = CartClass()
    
    //Controls
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var myTableCheckOut: UITableView!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBAction func btnPay(sender: UIButton) {
        let alertController = UIAlertController(title: "Payment", message: "Can we process the payment?", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "Yes", style: .Cancel) { (action) in
            println(action)
            self.performSegueWithIdentifier("go2Beginner", sender: self)
            UserInfo.myCart = []
            self.msgPopUp("Payment", msgError: "Thank you for shopping!")
        }
        alertController.addAction(OKAction)
        
        let destroyAction = UIAlertAction(title: "Cancel", style: .Destructive) { (action) in
            println(action)
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {}
        
    }
  
    func msgPopUp(var msgTittle: String, var msgError: String){
        let alert = UIAlertController(title: msgTittle, message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(cancelAction);
        self.presentViewController(alert, animated: true, completion: nil)
        
    }//end msgPopUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = UserInfo.userLogin.name
        imgProfile.image = UIImage(named: "Default")
        self.navigationController?.navigationBarHidden = false
        myTableCheckOut.delegate = self;
        myTableCheckOut.dataSource = self;
        self.cartObj.getTotal()
        lblSubTotal.text = "$" + String(format: "%.2f",self.cartObj.subTotal)
        lblTax.text = "$" + String(format: "%.2f",self.cartObj.tax)
        lblTotal.text = "$" + String(format: "%.2f",self.cartObj.total)
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
        
    }
    //3
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.myCart.count
    }
    
    //4
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell3", forIndexPath: indexPath) as! TableViewCell3
        
        cell.imgProduct.image = UserInfo.myCart[indexPath.row].image
        cell.lblName.text = UserInfo.myCart[indexPath.row].name
        cell.lblPrice.text = "$" + String(format: "%.2f",UserInfo.myCart[indexPath.row].price)
        cell.lblQty.text = String(UserInfo.myCart[indexPath.row].quantity)
        cell.lblAmount.text = "$" + String(format: "%.2f",(UserInfo.myCart[indexPath.row].price * Double(UserInfo.myCart[indexPath.row].quantity)))
        
        
        return cell
    }


}
