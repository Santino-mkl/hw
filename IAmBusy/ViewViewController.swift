//
//  ViewViewController.swift
//  IAmBusy
//
//  Created by إيلاف on 09/11/2020.
//
import RealmSwift
import UIKit

class ViewViewController: UIViewController {
    
    public var item:  ToDOListItem?
    public var deletionHandler: (() -> Void)?

    @IBOutlet var itemlabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //can you open the browser and go to your github account
        //ill log off and come back later when u finished log in
        itemlabel.text = item?.item
        dateLabel.text = ViewViewController.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
   }

}
