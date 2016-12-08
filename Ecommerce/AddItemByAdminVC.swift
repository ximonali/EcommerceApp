//
//  ViewController.swift
//
//
//  Created by Simon Gonzalez on 2016-04-05.
//
//

import UIKit

class AddItemByAdminVC: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    //Vars
    var globalIndex: Int = 0;
    var productImage:[String] = ["dellOptiplex1","hpPavilion1","hpStarWars","imac5k1","iphone6S1","samsungS71","tvLG1"]
    
    //Controls
    @IBOutlet weak var myPKview: UIPickerView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var btnAddItemActive: UIButton!
    @IBAction func btnAddItem(sender: UIButton) {
        if (checkFields()) {
            let alertController = UIAlertController(title: "Add (\(txtName.text)) Item to:", message: "Category: \(UserInfo.categoryList[globalIndex])", preferredStyle: .Alert)
            
            let addAction = UIAlertAction(title: "Yes", style: .Cancel) { (action) in
                println(action)
                var newProduct = ProductClass(pName: self.txtName.text, pImage: self.productImage[Int(arc4random_uniform(7))], pDetail: self.txtDescription.text, pPrice: (self.txtPrice.text! as NSString).doubleValue, pTotal: self.txtQuantity.text.toInt()!, pBrand: self.txtBrand.text, pCategory: UserInfo.categoryList[self.globalIndex], pModel: self.txtModel.text)
                newProduct.addProduct(newProduct)
                
                
                //RELOAD the TABLEVIEW
                self.msgPopUp("Well Done!",msgError: "Item Added to Category: \(UserInfo.categoryList[self.globalIndex])")
                self.cleanItemFields();
                
            }
            alertController.addAction(addAction)
            
            let destroyAction = UIAlertAction(title: "Cancel", style: .Destructive) { (action) in
                println(action)
            }
            alertController.addAction(destroyAction)
            
            self.presentViewController(alertController, animated: true) {}
        }
    }
    
    func checkFields() ->Bool {
        if (self.txtName.text.isEmpty || self.txtDescription.text.isEmpty || self.txtPrice.text.isEmpty || self.txtQuantity.text.isEmpty || self.txtBrand.text.isEmpty || self.txtModel.text.isEmpty) {
            errorPopUp("You must enter all fields!!")
            return false
        } else {
            return true
        }
    }
    
    func cleanItemFields(){
        txtName.text = ""
        txtPrice.text = ""
        txtBrand.text = ""
        txtModel.text = ""
        txtDescription.text = ""
        txtQuantity.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false;
        myPKview.delegate = self;
        myPKview.dataSource = self;
        lblUserName.text = UserInfo.userLogin.name
        imgProfile.image = UIImage(named: "Default")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //1 aqui digo la cantidad de componentes en el PKview (SECCIONES o Cantidad de Componentes)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    
    //2 aqui retorno la cantidad de mi arreglo (tamano)
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return UserInfo.categoryList.count;
    }
    
    //3 Aqui muestro lo que tiene mi array
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        globalIndex = row;
        return UserInfo.categoryList[row];
    }
    
    //4 AQUI Selecciono el valor
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let value = UserInfo.categoryList[row];
        println(value);
        
    }
    
    func msgPopUp(var msgTittle: String, var msgError: String){
        let alert = UIAlertController(title: msgTittle, message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(cancelAction);
        self.presentViewController(alert, animated: true, completion: nil)
        
    }//end msgPopUp
    
    func errorPopUp(var msgError: String){
        
        let errorAlert = UIAlertController(title: "Registration Error", message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: nil)
        
        
        errorAlert.addAction(cancelAction);
        
        self.presentViewController(errorAlert, animated: true, completion: nil)
        
        
    }//end errorPopUp
}
