//
//  IniciarSesionViewController.swift
//  Snapchat
//
//  Created by victor saico justo on 23/05/18.
//  Copyright © 2018 victor saico justo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func iniciarSesionTapped(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion : { (user,error) in print("Intentamos Iniciar sesion")
            if error != nil{
                print("Tenemos el siguiente error:\(error)")
                self.createUser()
            }else {
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
    }
    
    func createUser() {
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
            print("Intentamos crear un usuario")
            if error != nil{
                print("Tenemo el suguiente error:\(error)")
            }else {
                print("El usuario fue creado exitosamente")
                Database.database().reference().child("usuarios").child((user?.user.uid)!).child("email").setValue(user?.user.email)
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

