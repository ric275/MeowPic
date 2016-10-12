//
//  OpenPicViewController.swift
//  MeowPic
//
//  Created by Jack Taylor on 12/10/2016.
//  Copyright © 2016 Jack Taylor. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class OpenPicViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var pic = Pic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = pic.caption
        imageView.sd_setImage(with: URL(string: pic.imageURL))
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("pics").child(pic.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(pic.uuid).jpg").delete { (error) in
            print("yolo")
        }
    }
    
    

}
