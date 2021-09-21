//
//  CityTableViewController.swift
//  ScheduleTwo
//
//  Created by MacBook on 19.09.2021.
//

import UIKit
import CoreData

class CityTableViewController: UITableViewController {
    
    var array = [Item]()
    
    // 1 Reference to managed context object
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to get access to persistent container file
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = array[indexPath.row]
        
        cell.textLabel?.text = item.city
        
        return cell
    }
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = tableView.cellForRow(at: indexPath) else { return }
        
        guard let text = item.textLabel?.text else { return }
        
        print(text)
        
        
        
    }
    
    // MARK: - Add Items
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add a new city", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "type here"
            textField = alertTextField
        }
        
        let addButton = UIAlertAction(title: "add", style: .default) { (action) in
            
            guard let text = textField.text else { return }
            
            // 2
            let item = Item(context: self.context)
            
            item.city = text
            
            self.array.append(item)
            // 3
            self.saveData()
            
        }
        let cancelButton = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    // MARK: - Core Data
    // 4
    func saveData() {
        
        do {
            try context.save()
        } catch { print("saving error \(error)") }
        
        tableView.reloadData()
    }
    
    // 5
    func loadData() {
        
        let request: NSFetchRequest <Item> = Item.fetchRequest()
        
        do {
            array = try context.fetch(request)
        } catch { print("loading error \(error)") }
        
    }
    
}


