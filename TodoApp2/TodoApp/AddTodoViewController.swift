//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by Allen Wang on 10/18/16.
//  Copyright © 2016 Allen Wang. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {
    var delegate: TodoDelegate?
    @IBOutlet var desc: UITextField!
    @IBOutlet var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createNewTodo(_ sender: AnyObject) {
        delegate?.addTodo(name.text!, desc: desc.text!)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
