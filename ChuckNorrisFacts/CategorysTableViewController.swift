//
//  CategorysTableViewController.swift
//  ChuckNorrisFacts
//
//  Created by Lorhany Moraes on 29/06/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategorysTableViewController: UITableViewController {
    

    
    var categories: [Categorys] = []
    let urlCategories: String = "https://api.chucknorris.io/jokes/categories"
    typealias jsonStandard = [String : AnyObject]
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
        
    }()
    
    var loadingCategorys = false
    var currentPage = 0
    var total = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Buscando categorias. Aguarde..."
        label.isHidden = false
        loadCategorys()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    func loadCategorys () {
        
           
                DispatchQueue.main.async {
                    AF.request(self.urlCategories).responseJSON(completionHandler: { (response) in
                        switch response.result {
                                           case .success(let value):
                                               let json = JSON(value)
                                               json.array?.forEach({ (cat) in
                                                   let categoriasJSON = Categorys(categories: cat.stringValue)
                                                   self.categories.append(categoriasJSON)
                                                   
                                               })
                            self.tableView.reloadData()
                                           case .failure(let error):
                                               print(error.localizedDescription)
                                       }
                                   })
                               }
                           }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = categories[indexPath.row].categories.capitalized

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "seguePiada" {
               let vc: JokeViewController = segue.destination as! JokeViewController
               let indexPath = tableView.indexPathForSelectedRow!
               let currentCellValue = tableView.cellForRow(at: indexPath)! as UITableViewCell
               let textLabelText = currentCellValue.textLabel!.text?.lowercased()
               vc.selectCategory = textLabelText!
               self.tableView.deselectRow(at: indexPath, animated: true)
           }
       }
   }

