//
//  ElegirUsuarioViewController.swift
//  Snapchat
//
//  Created by victor saico justo on 24/05/18.
//  Copyright © 2018 victor saico justo. All rights reserved.
//
import Foundation
import UIKit
import Firebase
class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var usuarios : [Usuario] = []
    var imagenURL = ""
    var descrip = ""
    var imagenID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(DataSnapshot) in
            let usuario = Usuario()
            usuario.email = (DataSnapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = DataSnapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email!, "descripcion":descrip, "imagenURL":imagenURL, "imagenID":imagenID]
        Database.database().reference().child("usuarios").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
}
