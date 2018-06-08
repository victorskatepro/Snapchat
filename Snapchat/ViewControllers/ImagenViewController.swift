//
//  ImagenViewController.swift
//  Snapchat
//
//  Created by victor saico justo on 24/05/18.
//  Copyright © 2018 victor saico justo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SVProgressHUD

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = UIImagePNGRepresentation(imageView.image!)
        var url = "\(imagenID).jpg"
        SVProgressHUD.show(withStatus: "Cargando 🤪")
        imagenesFolder.child(url).putData(imagenData!, metadata : nil, completion :{(metadata, error) in print("Intentando subir la imagen")
            SVProgressHUD.dismiss()
            if error != nil {
                print("Ocurrio un error\(error)")
            }
            else {
               imagenesFolder.child(url).downloadURL(completion: {(url, error) in
                    print(url)
                            if error != nil {
                            print(error!)
                            return
                            }
                    if url != nil{
                        print(url!.absoluteString)
                        self.performSegue(withIdentifier: "seleccionarcontactosegue", sender: url!.absoluteString)
                    }
                })
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.imagenURL = sender as! String
        siguienteVC.descrip = descripcionTextField.text!
        siguienteVC.imagenID = imagenID
    }
}
