//
//  taskTableViewController.swift
//  notes
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class taskTableViewController: UITableViewController {
    
    //var Folders: [String]?
    var index : Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .black
       // Folders = []
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .lightGray
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datastore.returndatastore.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard Folders != nil else {
//            return UITableViewCell()
//        }
    let cell = tableView.dequeueReusableCell(withIdentifier: "foldericon", for: indexPath)
    cell.textLabel?.text = datastore.returndatastore[indexPath.row].Folders
   cell.imageView?.image = UIImage(named: "folder")
  cell.detailTextLabel?.text = "\(datastore.returndatastore[indexPath.row].notes.count)"
        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
       return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "delete") { (action, view, _) in
            datastore.returndatastore.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    func reloadtable(){
        tableView.reloadData()
    }
    
    
    /*
   // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle {
        return
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

//    In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
if let details = segue.destination as? notesTableViewController {
        details.dele  = self
        
    if let tableviewCell = sender as? UITableViewCell{
        if let indexvalue = tableView.indexPath(for: tableviewCell)?.row{
            index = indexvalue
       }
   }
    }}
 
    
    
    
    @IBAction func newfolder(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "NewFolder", message: "Enter a Name for this Folder ", preferredStyle: .alert)
        
        alert.addTextField { (text) in
            text.placeholder = "Name"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        cancel.setValue(UIColor.brown, forKey: "titleTextColor")
        
        alert.addAction(cancel)
        alert.addAction(UIAlertAction(title: "AddItem", style: .default, handler: { (action) in
            let store = alert.textFields?.first?.text
            let storedata = datastore(Folders: store!, notes: [])
            
            
            var flag = false
            for i in datastore.returndatastore{
                let store = storedata.Folders
                if store == i.Folders {
                    flag = true
                    break
                }}
            if flag{
                let alert = UIAlertController(title: "Name Taken", message: "Please choose another name", preferredStyle: .alert)
                let OkAction = UIAlertAction(title: "ok", style: .destructive, handler: nil)
                alert.addAction(OkAction)
                self.present(alert,animated: true,completion: nil)
            }
            else {
            datastore.returndatastore.append(storedata)
                self.tableView.reloadData()
                }
            
        }))
        self.present(alert, animated: true,completion: nil)
              alert.view.tintColor = .black

        
    }
    
   
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       
      
    }
   
    

