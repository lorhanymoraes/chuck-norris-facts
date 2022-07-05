//
//  PrimeiraViewController.swift
//  ChuckNorrisFacts
//
//  Created by Lorhany Moraes on 30/06/22.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var btContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = UIAlertController(title: "+18", message: "Are you older than 18?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "YES", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "NO", style: .destructive, handler: {(action) in
        exit(0)
        })
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        btContinue.resignFirstResponder()
        let vc = segue.destination as! CategorysTableViewController
        vc.title = nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
