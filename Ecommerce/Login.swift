//
//  ViewController.swift
//  Ecommerce
//
//  Created by Simon Gonzalez on 2016-03-26.
//  Copyright (c) 2016 Simon Gonzalez. All rights reserved.
//

import UIKit

class Login: UIViewController {

    //Vars
    var userObj = UserClass()
    var productObj = ProductClass()
    
    //Controls
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnLogin(sender: UIButton) {
        //Check if the filds are empty
        if (txtEmail.text.isEmpty || txtPassword.text.isEmpty){
            txtEmail.backgroundColor = txtEmail.text.isEmpty ? UIColor.redColor() : UIColor.whiteColor();
            txtPassword.backgroundColor = txtPassword.text.isEmpty ? UIColor.redColor() : UIColor.whiteColor();
            errorPopUp("All fields are necessary")
        } else {
            //Check if the user exists
            var validate = userObj.login(txtEmail.text, pPassword: txtPassword.text)
            if (validate.check) {
                UserInfo.userLogin = validate.user
                userObj = validate.user
                txtEmail.text = "";
                txtPassword.text = "";
                txtEmail.backgroundColor = UIColor.whiteColor();
                txtPassword.backgroundColor = UIColor.whiteColor();
                self.performSegueWithIdentifier("go2WelcomeVC", sender: self)
            } else {
                errorPopUp("Username and Password did not Match!")
            }
            
        }
    }//end btnLogin
    
    @IBAction func btnRegister(sender: UIButton) {
        self.performSegueWithIdentifier("go2RegisterVC", sender: self)
        
    }//end btnRegister
    //-----end controls

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userObj.load()
        productObj.load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }


    func errorPopUp(var msgError: String){
        
        let alert = UIAlertController(title: "Authentication Error", message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: nil)

        
        alert.addAction(cancelAction);
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end errorPopUp
}

