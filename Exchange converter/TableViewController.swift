//
//  TableViewController.swift
//  Exchange converter
//
//  Created by Ярослав Акулов on 24.10.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var navigationTittleLabel: UINavigationItem!
    
    private let jsonUrl = "https://www.cbr-xml-daily.ru/daily_json.js"
    
    var courses: WebsiteDescription!
    private var valutes: [String: ValuteDescription] = [:]
    var keys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        fetchData()
        print(valutes)
        navigationTittleLabel.titleView?.sizeToFit()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return valutes.count
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "course", for: indexPath) as! TableViewCell
        cell.configure(with: valutes, keys, indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    func fetchData() {
        print(#function)
            guard let url = URL(string:jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
            }
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let dateForrmatter = DateFormatter()
                dateForrmatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateForrmatter)
                self.courses = try decoder.decode(WebsiteDescription.self, from: data)
                DispatchQueue.main.async {
                    self.valutes = self.courses.Valute
                    self.keys = self.getKeys(from: self.courses.Valute)
                    self.navigationTittleLabel.title = self.createStringfromDate()
                    self.tableView.reloadData()
//                    print(self.valutes[self.keys[0]]?.Name)
                }
                } catch let error {
                print(error)
                }
        }.resume()
    }
    
    func getKeys(from dictionary: [String: ValuteDescription]) -> [String] {
        var keys: [String] = []
        for key in dictionary.keys {
            keys.append(key)
        }
        keys = keys.sorted()
        
        return keys
    }
    func createStringfromDate() -> String {
        let stringDate = courses.Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return "Курс ЦБ на \(dateFormatter.string(from: stringDate))"
    }
}
