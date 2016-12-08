//
//  Products.swift
//  
//
//  Created by Simon, Laercio and Kaio on 2016-03-27.
//
//

import UIKit

class Products: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //Vars
    var myComputers: [ProductClass] = []
    var mySmartphones: [ProductClass] = []
    var myLaptops: [ProductClass] = []
    var filteredProduct: [ProductClass] = []
    var searchActive = false
    
    //Controls
    @IBOutlet weak var myItemTable: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        loadSessions()
        myItemTable.reloadData();
        lblUserName.text =  UserInfo.userLogin.name
        imgProfile.image = UIImage(named: "default")
    }
        
    func btnAddItem(sender: UIButton!) {
        self.performSegueWithIdentifier("go2AddItemByAdmin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        myItemTable.delegate = self;
        myItemTable.dataSource = self;
        searchBar.delegate = self;

        btnAdd.addTarget(self, action:Selector("btnAddItem:"), forControlEvents: UIControlEvents.TouchUpInside)
        //show the add button
        if UserInfo.userLogin.type == "Admin" {
            btnAdd.hidden = false
        } else {
            btnAdd.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadSessions() {
        myComputers = []
        mySmartphones = []
        myLaptops = []
        if searchActive {
            for product in filteredProduct {
                switch product.category {
                case "Computer":
                    myComputers.append(product)
                case "Smartphone":
                    mySmartphones.append(product)
                default:
                    myLaptops.append(product)
                }
            }
        } else {
            for product in UserInfo.productList {
                switch product.category {
                case "Computer":
                    myComputers.append(product)
                case "Smartphone":
                    mySmartphones.append(product)
                default:
                    myLaptops.append(product)
                }
            }
        }
    }
    
    // for my TABLE VIEW
    //1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
                return myComputers.count
        case 1:
                return mySmartphones.count
        default:
                return myLaptops.count
        }
    }
    
    //2
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return UserInfo.categoryList.count
    }
    
    //3
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! TableViewCell

        switch indexPath.section {
        case 0:
            cell.imgItem.image = myComputers[indexPath.row].image
            cell.lblName.text = myComputers[indexPath.row].name
            cell.lblDescription.text = myComputers[indexPath.row].detail
            cell.lblPrice.text = "$" + String(format: "%.2f",myComputers[indexPath.row].price)
            cell.lblCant.text = String(myComputers[indexPath.row].total)
        case 1:
            cell.imgItem.image = mySmartphones[indexPath.row].image
            cell.lblName.text = mySmartphones[indexPath.row].name
            cell.lblDescription.text = mySmartphones[indexPath.row].detail
            cell.lblPrice.text = "$" + String(format: "%.2f",mySmartphones[indexPath.row].price)
            cell.lblCant.text = String(mySmartphones[indexPath.row].total)
        default:
            cell.imgItem.image = myLaptops[indexPath.row].image
            cell.lblName.text = myLaptops[indexPath.row].name
            cell.lblDescription.text = myLaptops[indexPath.row].detail
            cell.lblPrice.text = "$" + String(format: "%.2f",myLaptops[indexPath.row].price)
            cell.lblCant.text = String(myLaptops[indexPath.row].total)
        }
        
        return cell
        
    }
    
    //4
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
        switch indexPath.section {
        case 0:
            UserInfo.selectProduct = myComputers[indexPath.row]
        case 1:
            UserInfo.selectProduct = mySmartphones[indexPath.row]
        default:
            UserInfo.selectProduct = myLaptops[indexPath.row]
        }
        self.performSegueWithIdentifier("go2ProductDetails", sender: self)
        
    }
    
    //5
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UserInfo.categoryList[section]
        
    }
    
    
    //Search Bar Code Start
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            self.searchActive = false
        } else {
            filteredProduct.removeAll(keepCapacity: false)
            for (var index=0;index < UserInfo.productList.count;index++) {
                let product = UserInfo.productList[index]
                if (product.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil) {
                    filteredProduct.append(product)
                    self.searchActive = true
                }
            }
        }
        loadSessions()
        self.myItemTable.reloadData()
    }
    

}
