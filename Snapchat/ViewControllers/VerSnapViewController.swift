//
//  VerSnapViewController.swift
//  Snapchat
//
//  Created by victor saico justo on 5/06/18.
//  Copyright © 2018 victor saico justo. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class VerSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text? = snap.descrip
        imageView.sd_setImage(with: URL(string : snap.imagenURL))
        print("Imagen"+snap.imagenURL)
    }
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child(
            Auth.auth().currentUser!.uid).child("snaps").child(snap.id).removeValue()
        
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete(completion:{(error) in print("se elimino la imagen correctamente")})
    }
}
