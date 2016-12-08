//
//  Register.swift
//  
//
//  Created by Simon Gonzalez on 2016-03-27.
//
//

import UIKit
import CoreData

class Register: UIViewController {
    
    //Vars
    var userObj = UserClass()
    
    //Controls
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword1: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!
    @IBAction func btnRegister(sender: UIButton) {
        if (checkFields()) {
            var newUserObj = UserClass(pEmail: txtEmail.text, pPassword: txtPassword1.text, pName: txtName.text, pType: "User")
            
            if (userObj.userExist(newUserObj)) {
                errorPopUp("User already exist")
            } else {
                userObj.addUser(newUserObj)
                AddedUserPopUp("User Registered: \(txtEmail.text)")
                txtEmail.text = ""
                txtName.text = ""
                txtPassword1.text = ""
                txtPassword2.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkFields() ->Bool {
        //check if all fields are empty
        if (txtName.text.isEmpty || txtEmail.text.isEmpty || txtPassword1.text.isEmpty || txtPassword2.text.isEmpty){
            txtEmail.backgroundColor = txtEmail.text.isEmpty ? UIColor.redColor() : UIColor.whiteColor()
            txtName.backgroundColor = txtName.text.isEmpty ? UIColor.redColor() : UIColor.whiteColor()
            txtPassword1.backgroundColor = txtPassword1.text.isEmpty ? UIColor.redColor() : UIColor.whiteColor()
            txtPassword2.backgroundColor = txtPassword2.text.isEmpty ? UIColor.redColor() : UIColor.whiteColor()
            errorPopUp("You must enter all fields!!")
            return false
        } else {
            //check if password is matching
            if (txtPassword1.text != txtPassword2.text){
                txtPassword1.backgroundColor = UIColor.redColor()
                txtPassword2.backgroundColor = UIColor.redColor()
                errorPopUp("Password does not Match!")
                return false
            } else {
                if (!validate(txtEmail.text)) {
                    txtEmail.backgroundColor = UIColor.redColor()
                    errorPopUp("E-mail wrong format!")
                    return false
                }
            }
        }
        return true
    }

    
    func errorPopUp(var msgError: String){
        
        let errorAlert = UIAlertController(title: "Registration Error", message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: nil)
        
        
        errorAlert.addAction(cancelAction);
        
        self.presentViewController(errorAlert, animated: true, completion: nil)
        
        
    }//end errorPopUp
    
    func AddedUserPopUp(var msgDone: String){
        
        let messageAlert = UIAlertController(title: "Well Done!", message: msgDone, preferredStyle: UIAlertControllerStyle.Alert)
        
        var addAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        messageAlert.addAction(addAction);
        
        self.presentViewController(messageAlert, animated: true, completion: nil)
        
        
    }//end errorPopUp
    
    func validate(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluateWithObject(YourEMailAddress)
    }//end validateEmail
    
    
}//end Register
