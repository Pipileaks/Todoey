//
//  ViewController.swift
//  Todoey
//
//  Created by Umut Sever on 19.04.2019.
//  Copyright © 2019 Umut Sever. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Xcode Çalış", "Alp'i döv", "Rejim Yap"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
     
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
                itemArray = items //Bu kısım, string local dataya bağlama, ve if let burada eğer burada bir data var ise çalıştırılacak yok ise çalıştırmayacak.
        }
        
    }

    
    //MARK - Tableview Datasource Methods
    
 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    // ToDoItemCell table'da identifier olarak verdiğimiz yer.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var inputValue = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //add item kısmına tıklaınca UIAlert ne olacağı
            
            self.itemArray.append(inputValue.text!) // array yazılanı ekleme
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") // Item local storage için tanımlama
            
            self.tableView.reloadData() // tableview datayı güncelleme
            
            print("Succes")
        }
            // adding text filed to UIAlert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            inputValue = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
  

}

