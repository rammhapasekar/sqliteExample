//
//  ViewController.swift
//  SQLiteTutorial
//
//  Created by Ram Mhapasekar on 11/03/17.
//  Copyright © 2017 Ram Mhapasekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var marrSuperherotData : NSMutableArray!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellSpacingHeight:CGFloat = 8
    
    //MARK:
    //MARK: ViewController Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getSuperheroData()
        tableView.separatorColor = UIColor.clear
    }
    
    
    //MARK:
    //MARK: getSuperheroData
    /*
     This method will help you to get all the data from the specified table ie. SUPERHERO_INFO tbl in this case
     */
    func getSuperheroData()
    {
        marrSuperherotData = NSMutableArray()
        marrSuperherotData = ModelManager.getInstance().getAllSuperheroData()
        self.tableView?.reloadData()
    }
    
    //MARK:
    //MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return marrSuperherotData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SuperheroTableCell = self.tableView.dequeueReusableCell(withIdentifier: "superheroCell") as! SuperheroTableCell
        
        let superhero: SUPERHERO_INFO = marrSuperherotData.object(at: indexPath.section) as! SUPERHERO_INFO
        
        cell.lblName.text = superhero.NAME
        cell.lblPower.text = superhero.POWER
        cell.btnEdit.tag = indexPath.section
        cell.btnDelete.tag = indexPath.section
        
        cell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.6)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK:
    //MARK: Edit btn Click Method
    
    @IBAction func btnEditClicked(_ sender: Any) {
        
//        self.performSegue(withIdentifier: "editSegue", sender: sender)
        
        self.prepareForSegue(segue: UIStoryboardSegue.init(identifier: "editSegue", source: self, destination: AddSuperheroVC()) , sender: sender as AnyObject?)

    }
    
    
    //MARK:  Delete btn Click Method
    
    @IBAction func btnDeleteClicked(_ sender: Any) {
        
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        let superheroInfo: SUPERHERO_INFO = marrSuperherotData.object(at: selectedIndex) as! SUPERHERO_INFO
        let isDeleted = ModelManager.getInstance().deleteSuperheroData(superheroInfo: superheroInfo)
        if isDeleted {
            self.invokeAlertMethod(title: "", message: "Record deleted successfully.")
        } else {
            self.invokeAlertMethod(title: "", message: "Error in deleting record.")
        }
        self.getSuperheroData()
    }
    
    
    //MARK:
    //MARK: prepareForSegue

    /*
     This method will check the segue identifier & in case of edit btn press transfer the selected row's data to the secondVC ie. AddSuperheroVC in this case
     */
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("inside prepareForSegue")
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            AddSuperheroVC.isEdit = true
            AddSuperheroVC.superheroData = marrSuperherotData.object(at: selectedIndex) as! SUPERHERO_INFO
        }
    }
}
