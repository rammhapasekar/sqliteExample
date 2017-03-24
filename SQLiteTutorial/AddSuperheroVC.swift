//
//  AddSuperheroVC.swift
//  SQLiteTutorial
//
//  Created by Ram Mhapasekar on 11/03/17.
//  Copyright © 2017 Ram Mhapasekar. All rights reserved.
//

import UIKit

class AddSuperheroVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPower: UITextField!

    @IBOutlet weak var lblHeader: UILabel!
    
    weak var btnInsert: UIButton!
    
    static var isEdit : Bool = false
    
    static var superheroData : SUPERHERO_INFO!
    
    var originalCenter: CGPoint!
    
    //MARK:
    //MARK: ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(AddSuperheroVC.isEdit)
        {
            
            txtName.text = try! AddSuperheroVC.superheroData.NAME.aesDecrypt(key: ApplicationConstants.KEY, iv: ApplicationConstants.IV)
            txtPower.text = try! AddSuperheroVC.superheroData.POWER.aesDecrypt(key: ApplicationConstants.KEY, iv: ApplicationConstants.IV)
            
            lblHeader.text = "UPDATE SUPERHERO"
            
            btnInsert.setTitle("UPDATE", for: UIControlState.normal)
            
            viewWillAppear(true)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        originalCenter = self.view.center
        
//    self.view.transform = CGAffineTransform(scaleX: 0.3, y: 2)
        
        self.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.view.center.y = self.view.center.y - (self.view.frame.height / 2)
        self.view.transform = CGAffineTransform(rotationAngle: 1.8)

        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction,.curveEaseOut], animations: {
            self.view.transform = .identity
            
        }) { (success) in
            
            self.view.center = self.originalCenter
            self.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AddSuperheroVC.isEdit = false
    }
    
    
    //MARK:
    //MARK: dismissVC
    
    /*
        This method helps you to dismiss current viewController from the window
    */
    
    @IBAction func dismissVC(_ sender: Any) {
     
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:
    //MARK: insertBtnClicked
    /*
        In this method we will first validate our textField if the data is proper then according to the condition we will perform update or insert action on given data
    */
    
    @IBAction func insertBtnClick(_ sender: Any) {
        
        if((txtName.text == "") && (txtPower.text == ""))
        {
            txtName.layer.borderWidth = 1.0
            txtName.layer.borderColor = UIColor.red.cgColor
            txtPower.layer.borderWidth = 1.0
            txtPower.layer.borderColor = UIColor.red.cgColor
            self.invokeAlertMethod(title: "Oppss..", message: "Please enter your superhero name and his super power.")
        }
        else if(txtName.text == "")
        {
            txtPower.layer.borderWidth = 0.0
            txtName.layer.borderWidth = 1.0
            txtName.layer.borderColor = UIColor.red.cgColor
            
            self.invokeAlertMethod(title: "Oppss..", message: "Oppss..! Enter superhero name.")
        }
        else if(txtPower.text == "")
        {
            txtName.layer.borderWidth = 0.0
            txtPower.layer.borderWidth = 1.0
            txtPower.layer.borderColor = UIColor.red.cgColor
            self.invokeAlertMethod(title: "Oppss..", message: "Hey, how can you forgot your SUPERHERO'S power .")
        }
        else{
         
            txtName.layer.borderWidth = 0.0
            txtPower.layer.borderWidth = 0.0

            if AddSuperheroVC.isEdit{
            
                let superheroInfo: SUPERHERO_INFO = SUPERHERO_INFO()
                superheroInfo.ID = AddSuperheroVC.superheroData.ID
                superheroInfo.NAME = try! txtName.text!.aesEncrypt(key: ApplicationConstants.KEY , iv: ApplicationConstants.IV)
                superheroInfo.POWER = try! txtPower.text!.aesEncrypt(key: ApplicationConstants.KEY , iv: ApplicationConstants.IV)
                let isUpdated = ModelManager.getInstance().updateSuperheroData(superheroInfo: superheroInfo)
                if isUpdated {
//                    self.invokeAlertMethod(title: "", message: "Record updated successfully.")
                    dismiss(animated: true, completion: nil)
                } else {
                    self.invokeAlertMethod(title: "", message: "Error in updating record.")
                }
            }
            else{
                
                let superheroInfo: SUPERHERO_INFO = SUPERHERO_INFO()
                superheroInfo.NAME = try! txtName.text!.aesEncrypt(key: ApplicationConstants.KEY , iv: ApplicationConstants.IV)
                superheroInfo.POWER = try! txtPower.text!.aesEncrypt(key: ApplicationConstants.KEY , iv: ApplicationConstants.IV)
                let isInserted = ModelManager.getInstance().addSuperheroData(superheroInfo: superheroInfo)
                if isInserted {
//                     self.invokeAlertMethod(title: "", message: "Record Inserted successfully.")
                    dismiss(animated: true, completion: nil)
                } else {
                    self.invokeAlertMethod(title: "", message: "Error in inserting record.")
                }
            }
        }
    }
}
