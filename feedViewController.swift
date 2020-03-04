//
//  feedViewController.swift
//  Parstagram
//
//  Created by Subomi Popoola on 3/3/20.
//  Copyright © 2020 Subomi Popoola. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [PFObject] = [PFObject]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let query = PFQuery(className: "Postss")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
         
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text =  post["caption"] as! String
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.photoView.af_setImage(withURL: url)
        return cell
    }
    

}
