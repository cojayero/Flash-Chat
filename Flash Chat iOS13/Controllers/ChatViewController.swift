//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController {
    let db = Firestore.firestore()
    
    var messages: [Mensaje] = [
        Mensaje(sender: "1@2.com", body: "Hey!"),
        Mensaje(sender: "a@b.com", body: "Hello!"),
        Mensaje(sender: "1@2.com", body: "What's up?"),
    ]
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBAction func logOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName,
                                 bundle: nil),
                           forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        debugPrint(sender.description)
        
        if  let messageBody = messageTextfield.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName)
                .addDocument(data: [K.FStore.senderField: messageSender,
                                    K.FStore.bodyField: messageBody,
                                    K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                    if let e = error {
                        debugPrint("There was an issue saving data to firestore, " + e.localizedDescription)
                    }
                    else {
                        debugPrint("Saved data")
                    }
                }
               
           }
        
    }
    func loadMessages(){
        debugPrint(#function)
      
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error)  in
            self.messages = []
            if let e = error {
                debugPrint("There was an issue retrieving data frorm Firestrore" + e.localizedDescription)
            } else {
                if let snapshotDocuments =   querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        print(data)
                        if let messageSender  = data[K.FStore.senderField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String {
                            self.messages.append(Mensaje(sender:messageSender, body: messageBody))
                        }
                    }
                    DispatchQueue.main.async{
                    self.tableView.reloadData()
                    }
                }
            }
         }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
}
