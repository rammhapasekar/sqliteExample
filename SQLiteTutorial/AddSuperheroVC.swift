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
    
    //MARK: 
    //MARK: ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(AddSuperheroVC.isEdit)
        {
            txtName.text = AddSuperheroVC.superheroData.NAME
            txtPower.text = AddSuperheroVC.superheroData.POWER
            
            lblHeader.text = "UPDATE SUPERHERO"
            
            btnInsert.setTitle("UPDATE", for: UIControlState.normal)
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
                superheroInfo.NAME = txtName.text!
                superheroInfo.POWER = txtPower.text!
                let isUpdated = ModelManager.getInstance().updateSuperheroData(superheroInfo: superheroInfo)
                if isUpdated {
                    //                Util.invokeAlertMethod(strTitle: "", strBody: "Record updated successfully.", delegate: nil)
                    dismiss(animated: true, completion: nil)
                } else {
                    self.invokeAlertMethod(title: "", message: "Error in updating record.")
                }
            }
            else{
                
                let superheroInfo: SUPERHERO_INFO = SUPERHERO_INFO()
                superheroInfo.NAME = txtName.text!
                superheroInfo.POWER = txtPower.text!
                let isInserted = ModelManager.getInstance().addSuperheroData(superheroInfo: superheroInfo)
                if isInserted {
                    //            Util.invokeAlertMethod(strTitle: "", strBody: "Record Inserted successfully.", delegate: nil)
                    
                    dismiss(animated: true, completion: nil)
                } else {
                    self.invokeAlertMethod(title: "", message: "Error in inserting record.")
                }
            }
        }
    }
}
