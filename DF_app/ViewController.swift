//
//  ViewController.swift
//  DF_app
//
//  Created by Prang on 11/18/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
                   
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Logout",style: .plain, target: self,action: #selector(handleLogout)) }
    
    
    func handleLogout(){
        let loginController=LoginController()
        present(loginController,animated:true,completion:nil)
    
    }
    
    
    
    
}

