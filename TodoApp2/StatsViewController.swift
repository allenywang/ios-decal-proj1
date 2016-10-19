//
//  StatsViewController.swift
//  TodoApp
//
//  Created by Allen Wang on 10/19/16.
//  Copyright © 2016 Allen Wang. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet var count: UILabel!
    var delegate: TodoDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let todos = (delegate?.getTodos())!
        let completed = todos.filter({$0.completed})
        count.text = "\(completed.count)"

        // Do any additional setup after loading the view.
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
