//
//  notesTableViewController.swift
//  notes
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class notesTableViewController: UITableViewController {

   // var notes: [String]?
    var curIndex = -1
    var  dele : taskTableViewController?
    @IBOutlet weak var NotesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
      //  notes = []
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
          return datastore.returndatastore[(dele?.index)!].notes.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "noteName") {
 cell.textLabel?.text = datastore.returndatastore[(dele?.index)!].notes[indexPath.row]
//            print(dele?.index)

        // Configure the cell...
          return cell
    }
    return UITableViewCell()
}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
if let detailViewnote = segue.destination as? notesdetailViewController {
        detailViewnote.NotesTable = self
            
            if let tableviewCell = sender as? UITableViewCell{
        if let indexnotes = tableView.indexPath(for: tableviewCell)?.row {
                   // detailView.textString = [index]
                    detailViewnote.textString = datastore.returndatastore[(dele?.index)!].notes[indexnotes]
                   curIndex = indexnotes
                }
            }
        }
    }
    
   func updateText(text:String) {
    
    tableView.reloadData()
    dele?.reloadtable()
    
    guard datastore.returndatastore[(dele?.index)!].notes != [] &&
    
        curIndex != -1 else{
            
            datastore.returndatastore[(dele?.index)!].notes.append(text)
            tableView.reloadData()
            dele?.reloadtable()
            return
            
    }
     datastore.returndatastore[(dele?.index)!].notes[curIndex] = text
    
    let indexpath = IndexPath(item: curIndex, section: 0)
    tableView.reloadRows(at: [indexpath], with: .middle)

    }
}

