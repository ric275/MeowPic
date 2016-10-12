//
//  PicsViewController.swift
//  MeowPic
//
//  Created by Jack Taylor on 11/10/2016.
//  Copyright © 2016 Jack Taylor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pics : [Pic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("pics").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let pic = Pic()
            pic.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            pic.caption = (snapshot.value as! NSDictionary)["caption"] as! String
            pic.from = (snapshot.value as! NSDictionary)["from"] as! String
            pic.key = (snapshot.key)
            pic.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            
            self.pics.append(pic)
            
            self.tableView.reloadData()
        })
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("pics").observe(FIRDataEventType.childRemoved, with: { (snapshot) in
            print(snapshot)
            
            var index = 0
            for pic in self.pics {
                if pic.key == snapshot.key {
                    self.pics.remove(at: index)
                }
                
                index += 1
            }
            
            self.tableView.reloadData()
        })
    }
    
    @IBAction func logoutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pics.count == 0 {
            return 1
        } else {
            return pics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if pics.count == 0 {
            cell.textLabel?.text = "You have no Pics 😢"
        } else {
            
            let pic = pics[indexPath.row]
            cell.textLabel?.text = pic.from
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pic = pics[indexPath.row]
        performSegue(withIdentifier: "openPicSegue", sender: pic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "openPicSegue" {
            let nextViewController = segue.destination as! OpenPicViewController
            nextViewController.pic = sender as! Pic
        }
        
    }
    
}
