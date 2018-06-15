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
import AVFoundation
class VerSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
     var audioPlayer : AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text? = snap.descrip
        imageView.sd_setImage(with: URL(string : snap.imagenURL))
        print("Imagen"+snap.imagenURL)
        print("Audio URL"+snap.audioURL)
    }
    @IBAction func reproducirTapped(_ sender: Any) {
        do {
            let audioURL: URL = NSURL(string: snap.audioURL)! as URL
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL)
            audioPlayer!.play()
        } catch {}
    }
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child(
            Auth.auth().currentUser!.uid).child("snaps").child(snap.id).removeValue()
        
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete(completion:{(error) in print("se elimino la imagen correctamente")})
    }
}
