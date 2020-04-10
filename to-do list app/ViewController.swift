//
//  ViewController.swift
//  to-do list app
//
//  Created by 농협 on 02/04/2020.
//  Copyright © 2020 nonghyup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendalBackgroundView: UIView!
    
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    
    let todo = ["Buy a milk", "Buy a shampoo", "Buy a toothbrush"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toDoListHeaderView = ToDoListHeaderView(frame: calendalBackgroundView.frame)
        toDoListHeaderView.updateInit()
        calendalBackgroundView.addSubview(toDoListHeaderView)
        
        calendalBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        calendalBackgroundView.layer.cornerRadius = 40.0
        calendalBackgroundView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoListTableViewCell
        cell.todoLabel.text = todo[indexPath.row]
        cell.contentView.alpha = (cell.checked) ? 0.4 : 1.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ToDoListTableViewCell
        
        if cell.checked == false {
            
            cell.checked = true
            
            animator.addAnimations {
                
                cell.todoLabel.sizeToFit()
                
                cell.lineViewLeading.constant = cell.todoLabel.frame.origin.x - 5.0
                cell.lineViewWidth.constant = cell.todoLabel.frame.width + 5.0 * 2
                
                self.view.layoutIfNeeded()
            }
            
            animator.addAnimations({
                
                cell.contentView.alpha = 0.4
                self.view.layoutIfNeeded()
                
            }, delayFactor: 0.5)
            
            animator.startAnimation()
            
        } else {
            
            cell.checked = false
            
            animator.addAnimations {
                
                cell.todoLabel.sizeToFit()
                
                cell.lineViewLeading.constant = 50.0
                cell.lineViewWidth.constant = 25.0
                
                self.view.layoutIfNeeded()
            }
            
            animator.addAnimations({
                
                cell.contentView.alpha = 1.0
                self.view.layoutIfNeeded()
                
            }, delayFactor: 0.5)
            
            animator.startAnimation()
            
        }
    }
    
}
