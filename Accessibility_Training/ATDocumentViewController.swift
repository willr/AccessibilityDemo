//
//  ViewController.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/26/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class ATDocumentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let trainingContent = ATDocument.documentFromBundle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        if trainingContent.title.characters.count > 0 {
            self.title = trainingContent.title
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) {
            [weak self] _ in self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ArtistDetailViewController,
//            let indexPath = tableView.indexPathForSelectedRow {
//            destination.selectedArtist = artists[indexPath.row]
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ATDocumentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // return trainingContent.rowList.count
        return trainingContent.rowListBySection[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = trainingContent.rowListBySection[indexPath.section]![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath) as! BaseTableViewCell
        
        cell.configure(rowModel: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headingArray = trainingContent.headings[section]
        return headingArray.toAttribString().string
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trainingContent.headings.count
    }
    
}

//extension ATDocumentViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
//}


