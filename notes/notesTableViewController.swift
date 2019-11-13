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
    @IBOutlet weak var delete: UIBarButtonItem!
    @IBOutlet weak var move: UIBarButtonItem!
    @IBOutlet var TableViews: UITableView!
    var  dele : taskTableViewController?
    @IBOutlet weak var NotesTable: UITableView!
    var notes_of_move : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        TableViews.allowsMultipleSelection = true
        delete.isEnabled = false
        move.isEnabled = false
        self.view.backgroundColor = .gray
        self.navigationItem.backBarButtonItem?.tintColor = .black
        
        
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
    
    @IBAction func shadow(_ sender: UIBarButtonItem) {
        
        if !delete.isEnabled {
        move.isEnabled = true
        delete.isEnabled = true
        }
        else{
            delete.isEnabled = false
            move.isEnabled = false
        }
    }
    @IBAction func Delete(_ sender: UIBarButtonItem) {
        
        let alertcontroller = UIAlertController(title: "Delete", message: "Are You Sure", preferredStyle: .alert)
        
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let DeleteAction  = UIAlertAction(title: "Delete", style: .default){ (action) in
            self.deleteRows()
            }
        
        alertcontroller.addAction(CancelAction)
        alertcontroller.addAction(DeleteAction)
        self.present(alertcontroller,animated: true,completion: nil)
    }
    
    
  
    
    
    
    func deleteRows()
    {
       if  var  selectedrows = tableView.indexPathsForSelectedRows {
            
            var item = [String]()
            for indexPath in selectedrows{
    item.append(datastore.returndatastore[(dele?.index)!].notes[indexPath.row])
            }
            
            notes_of_move = item
        
    for i in item {
      if let index = datastore.returndatastore[(dele?.index)!].notes.index(of: i){
            datastore.returndatastore[(dele?.index)!].notes.remove(at: index)
                    
                }
            }
           
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedrows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableViews.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    TableViews.cellForRow(at: indexPath)?.accessoryType = .detailButton
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
      
        
if let detailViewnote = segue.destination as? notesdetailViewController {
        detailViewnote.NotesTable = self
            
            if let tableviewCell = sender as? UITableViewCell{
        if let indexnotes = tableView.indexPath(for: tableviewCell)?.row {
                   // detailView.textString = [index]
                    detailViewnote.textString = datastore.returndatastore[(dele?.index)!].notes[indexnotes]
                   curIndex = indexnotes
                }
            }
}else if var data = segue.destination as? moveViewController{
    data.delegate = self
    deleteRows()
    
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

