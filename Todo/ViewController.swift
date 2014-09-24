//
//  ViewController.swift
//  Todo
//
//  Created by Jake Lin on 16/09/2014.
//  Copyright (c) 2014 Jake Lin. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todos = [TodoModel(id: "1", image: "child-selected", title: "去游乐场", date: dateFromString("2014-10-20")!),
                TodoModel(id: "2", image: "shopping-cart-selected", title: "购物", date: dateFromString("2014-10-28")!),
                TodoModel(id: "3", image: "phone-selected", title: "打电话", date: dateFromString("2014-10-30")!)]
        
        navigationItem.leftBarButtonItem = editButtonItem()
        // tableView.allowsSelectionDuringEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // Display the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath) as UITableViewCell
        let todo = todos[indexPath.row] as TodoModel
        var image = cell.viewWithTag(101) as UIImageView
        var title = cell.viewWithTag(102) as UILabel
        var date = cell.viewWithTag(103) as UILabel
            
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options:0, locale:locale)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        date.text = dateFormatter.stringFromDate(todo.date)
        return cell
    }

    // MARK - UITableViewDelegate
    // Delete the cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // Edit mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    // func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    //    return UITableViewCellEditingStyle.Delete
    // }
    
    // Move the cell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Unwind
    @IBAction func close(segue: UIStoryboardSegue) {
        println("closed!")
        tableView.reloadData()
    }
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo" {
            var vc = segue.destinationViewController as DetailViewController
            // var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }
}

