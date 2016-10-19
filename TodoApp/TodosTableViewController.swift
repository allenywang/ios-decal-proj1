//
//  TodosTableViewController.swift
//  TodoApp
//
//  Created by Allen Wang on 10/18/16.
//  Copyright © 2016 Allen Wang. All rights reserved.
//
import Foundation
import UIKit

protocol TodoDelegate {
    func addTodo(_ name:String, desc:String)
    func getTodos() -> [Todo]
}

class TodosTableViewController: UITableViewController, TodoDelegate {
    
    var todoList: [Todo] = [Todo]()
    
    func addTodo(_ name: String, desc: String) {
        todoList.append(Todo(name: name, desc: desc))
        self.tableView.reloadData();
        NSKeyedArchiver.archiveRootObject(todoList, toFile: Todo.ArchiveURL.path)
    }
    
    func getTodos() -> [Todo] {
        return todoList
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTodo" {
            let vc = segue.destination as! AddTodoViewController
            vc.delegate = self
        }
        if segue.identifier == "Stats" {
            let sc = segue.destination as! StatsViewController
            sc.delegate = self
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            todoList.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func loadTodos() -> [Todo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURL.path) as? [Todo]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedTodos = loadTodos() {
            todoList += loadedTodos
        }
        todoList = todoList.filter({!$0.hasExpired()})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoList.count
    }

    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todoList[(indexPath as NSIndexPath).row]
        
        var attributes = [String: AnyObject]()
        attributes[NSStrikethroughStyleAttributeName] = 1 as AnyObject?
        attributes[NSForegroundColorAttributeName] = UIColor.gray

        if todo.completed {
            cell.textLabel?.attributedText = NSAttributedString(string: todo.name, attributes: attributes)
            cell.backgroundColor = UIColorFromRGB(0xeeeeee)
            cell.contentView.backgroundColor = UIColorFromRGB(0xeeeeee)
        } else {
            cell.textLabel?.attributedText = NSAttributedString(string: todo.name)
            cell.backgroundColor = UIColor.white
            cell.contentView.backgroundColor = UIColor.white
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = todoList[(indexPath as NSIndexPath).row]
        item.completed = !item.completed
        if item.completed {
            item.timestamp = Date()
        }
        tableView.reloadData()
        NSKeyedArchiver.archiveRootObject(todoList, toFile: Todo.ArchiveURL.path)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
