//
//  Profile.swift
//  
//
//  Created by Simon, Laercio and Kaio on 2016-03-27.
//
//

import UIKit

class Profile: UIViewController {

    //Vars
    
    
    //Controls
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword1: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword1: UILabel!
    @IBOutlet weak var lblPassword2: UILabel!
    
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBAction func btnLogout(sender: AnyObject) {
        UserInfo.userLogin = UserClass()
        self.performSegueWithIdentifier("go2logout", sender: self)
    }
    
    @IBAction func btnEdit(sender: UIButton) {
        
        if (btnEditProfile.currentTitle == "Edit") {
            btnEditProfile.setTitle("Save", forState: UIControlState.Normal)
            //Loading Info
            showText()
            btnEditProfile.backgroundColor = UIColor.blackColor();
        }else
        {
            
            UserInfo.userLogin.name = txtName.text
            UserInfo.userLogin.password = txtPassword1.text
            
            //CHECK & UPDATE HERE!
                if  (txtPassword1.text != txtPassword2.text){
                    errorPopUp("Error",msgError: "Password Did Not Match!");
                    
                }else {
                    //ALL FINE
                    //Update
                    btnEditProfile.setTitle("Edit", forState: UIControlState.Normal)
                    btnEditProfile.backgroundColor = UIColor.redColor();
                    UserInfo.userLogin.editUser(UserInfo.userLogin)
                    errorPopUp("Well Done!",msgError: "Updated!")
                    hideText()
                }

        
        }
        
        
    }//end btnEdit
    
    func errorPopUp(var msgTittle: String, var msgError: String){
        let alert = UIAlertController(title: msgTittle, message: msgError, preferredStyle: UIAlertControllerStyle.Alert)
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(cancelAction);
        self.presentViewController(alert, animated: true, completion: nil)

    }//end errorPopUp
    
    func hideText(){
        txtName.hidden = true
        txtPassword1.hidden = true
        txtPassword2.hidden = true
 
        lblName.text = "\(UserInfo.userLogin.name)"
        lblEmail.text = "\(UserInfo.userLogin.email)"
        lblPassword1.text = "******"
        lblPassword2.text = "******"
    }
    
    func showText(){
        txtName.hidden = false
        txtPassword1.hidden = false
        txtPassword2.hidden = false

        txtName.text = UserInfo.userLogin.name;
        txtPassword1.text = UserInfo.userLogin.password;
        txtPassword2.text = UserInfo.userLogin.password;
        
        lblName.text = "";
        lblPassword1.text = "";
        lblPassword2.text = "";
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        lblUserName.text =  UserInfo.userLogin.name
        imgProfile.image = UIImage(named: "default")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
