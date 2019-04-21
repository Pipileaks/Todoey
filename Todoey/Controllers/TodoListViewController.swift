//
//  ViewController.swift
//  Todoey
//
//  Created by Umut Sever on 19.04.2019.
//  Copyright © 2019 Umut Sever. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
       let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let newItem = Item()
        newItem.title = "Xcode Çalış"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Oturma"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Yeme"
        itemArray.append(newItem3)
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items //Bu kısım, string local dataya bağlama, ve if let burada eğer burada bir data var ise çalıştırılacak yok ise çalıştırmayacak.
//        }
        
    }
    
    
    //MARK - Tableview Datasource Methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    // ToDoItemCell table'da identifier olarak verdiğimiz yer.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //Ternary Operator ***
        // value = condition ? valuIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //Ternary'den önce
        //
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        //
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var inputValue = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //add item kısmına tıklaınca UIAlert ne olacağı
            let newItem = Item()
            
            newItem.title = inputValue.text!
            
            self.itemArray.append(newItem) // array yazılanı ekleme
            
            self.saveItems()
            
        }
        // adding text filed to UIAlert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            inputValue = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // Mark - Model Manupulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
            self.tableView.reloadData() // tableview datayı güncelleme
        
        
    }
    
    
    
}

