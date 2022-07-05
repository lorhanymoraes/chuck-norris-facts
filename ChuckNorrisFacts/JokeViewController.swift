//
//  JokeViewController.swift
//  ChuckNorrisFacts
//
//  Created by Lorhany Moraes on 29/06/22.
//

import UIKit
import WebKit
import Alamofire

class JokeViewController: UIViewController {
    
    var joke: ChuckJoke?
     let urlJokes: String = "https://api.chucknorris.io/jokes/random?category="
     let urlRandomJokes: String = "https://api.chucknorris.io/jokes/random"
     var selectCategory: String = ""
     typealias jsonStandard = [String : AnyObject]
    
    @IBOutlet weak var tfJoke: UITextView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        loadPiada(categories: selectCategory)
        navigationItem.title = selectCategory.capitalized.lowercased()
        
}
    func loadPiada(categories: String) {
            var url: String = ""
            if categories != "" {
                url = self.urlJokes+categories
            } else {
                url = self.urlRandomJokes
            }
            
            DispatchQueue.main.async {
                AF.request(url).responseJSON(completionHandler: {(response) in
                    let jsonData = response.data!
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! jsonStandard
                        let jokeJSON = ChuckJoke(categories: ((JSON["categories"] as? [String])!), id: (JSON["id"] as? String)!, url: (JSON["url"] as? String)!, value: (JSON["value"] as? String)!)
                
                        self.joke = jokeJSON
                        self.loadData()
                        
                    } catch {
                        print (error.localizedDescription)
                    }
                })
            }
        }
        
        func loadData() {
            guard let value = joke?.value  else { return }
            self.tfJoke.text = value
            self.loading.stopAnimating()
        }
   
    @IBAction func btShare(_ sender: UIButton) {
        guard let name = tfJoke.text else { return }
        let activityViewController = UIActivityViewController(activityItems: [name], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)

    }
}
    
