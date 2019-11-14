//
//  moveViewController.swift
//  notes
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class moveViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    var delegate : notesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
        return datastore.returndatastore.count
        }

        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "id") {
                cell.textLabel?.text = datastore.returndatastore[indexPath.row].Folders
                

            // Configure the cell...
              return cell
        }
             return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let alertcontroller = UIAlertController(title: "move to \(datastore.returndatastore[indexPath.row].Folders)", message: "Are You Sure", preferredStyle: .alert)
         
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (act) in
             self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
         let MoveAction  = UIAlertAction(title: "Move", style: .default){ (action) in
            datastore.returndatastore[indexPath.row].notes += self.delegate!.notes_of_move
            self.dismiss(animated: true, completion: nil)
             }
         
         alertcontroller.addAction(CancelAction)
         alertcontroller.addAction(MoveAction)
         self.present(alertcontroller,animated: true,completion: nil)
       
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
