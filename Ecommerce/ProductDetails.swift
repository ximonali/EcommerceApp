	//
//  ProductDetails.swift
//  
//
//  Created by Simon Gonzalez on 2016-03-27.
//
//

import UIKit

class ProductDetails: UIViewController {

    //Var
    var cartObj = CartClass()
    
    //Controls
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgItemSelected: UIImageView!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var lblOutOfStock: UILabel!
    @IBAction func btnAdd2Cart(sender: UIButton) {
        
        
        var loginTextField: UITextField?
        let alertController = UIAlertController(title: "Add Item to your Cart:", message: "Details: (\(UserInfo.selectProduct.name))", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
            //println("Cancel Button Pressed")
            
        })
        let ok = UIAlertAction(title: "Add", style: .Cancel) { (action) -> Void in
            //println("Ok Button Pressed")
            var Qty: String = "";
            Qty = loginTextField!.text;
            if !(Qty.isEmpty) {
                var produto = UserInfo.selectProduct
                if (Qty.toInt() > UserInfo.selectProduct.total) {
                    self.msgPopUp("Error:",msgError: "Sorry, we have not enough product in stock")
                } else {
                    UserInfo.selectProduct.quantity = Qty.toInt()!
                    self.cartObj.addProduct(UserInfo.selectProduct)
                    self.btnBuy.hidden = UserInfo.selectProduct.total < 1
                    self.lblOutOfStock.hidden = UserInfo.selectProduct.total > 0
                }
                
                self.msgPopUp("Well Done!",msgError: "Added to your Cart!")
            }else{
                self.msgPopUp("Error:",msgError: "--Enter Quantity--")
            }
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // Enter the textfiled customization code here.
            loginTextField = textField
            loginTextField?.placeholder = "Quantity:"
            
        }
        presentViewController(alertController, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false;
        imgItemSelected.image = UserInfo.selectProduct.image
        lblName.text = "Name: \(UserInfo.selectProduct.name)"
        lblBrand.text = "Brand:\(UserInfo.selectProduct.brand)"
        lblDescription.text = "Description: \(UserInfo.selectProduct.detail)"
        lblPrice.text = "Price: $" + String(format: "%.2f",UserInfo.selectProduct.price)
        lblModel.text = "Model: \(UserInfo.selectProduct.model)"
        btnBuy.hidden = UserInfo.selectProduct.total < 1
        lblOutOfStock.hidden = UserInfo.selectProduct.total > 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func msgPopUp(var msgTittle: String, var msgError: String){
        let alert = UIAlertController(title: msgTittle, message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(cancelAction);
        self.presentViewController(alert, animated: true, completion: nil)
        
    }//end msgPopUp


}
