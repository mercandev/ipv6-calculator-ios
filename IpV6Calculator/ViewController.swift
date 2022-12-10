//
//  ViewController.swift
//  IpV6Calculator
//
//  Created by Kaan Mercan on 8.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ipaddress: UITextField!
    @IBOutlet weak var prefix: UITextField!
    var itemsResult:ResponseV6Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func calculate(_ sender: Any) {
        Ipv6Request {(item) in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                let otherController = storyboard.instantiateViewController(withIdentifier: "ResultBoard")
                as! ResultViewController

                otherController.items = item

                //self.present(otherController, animated: true , completion: nil)
                self.navigationController?.pushViewController(otherController, animated: true)
            }
        }
     
    }
    
    func Ipv6Request(completionHandler: @escaping (ResponseV6Model) -> Void) {
        
        let params = ["IpAddress":ipaddress.text!, "Subnet":prefix.text!] as Dictionary<String, String>
      
        var request = URLRequest(url: URL(string: "http://127.0.0.1:3000/api/GetIpv6Calculator")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching result: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

          if let data = data,
            let v6Result = try? JSONDecoder().decode(ResponseV6Model.self, from: data) {
              completionHandler(v6Result)
          }
        })
        task.resume()
      }
    

}

