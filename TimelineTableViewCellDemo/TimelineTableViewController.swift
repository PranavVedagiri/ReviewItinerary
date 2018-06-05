//
//  TimelineTableViewController.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit
import TimelineTableViewCell

class TimelineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // TimelinePoint, Timeline back color, title, description, lineInfo, thumbnail, illustration
    @IBOutlet var myView: UIView!
    @IBOutlet var tableView: UITableView?
    
    @IBOutlet var startTime: UILabel!
    
    @IBOutlet var startingPoint: UILabel!
    
    @IBOutlet var confirmButton: UIButton!
    let data:[Int: [(TimelinePoint, UIColor, String, String, String?, String?, String?)]] = [0:[
        (TimelinePoint(), UIColor.black, "Space Needle", "10:30 a.m.", nil, nil, "seattle"),
        (TimelinePoint(), UIColor.black, "Pike Place", "11:30 a.m.", nil, nil, "Sun"),
        (TimelinePoint(), UIColor.black, "Paseo", "12:30 p.m.", nil, "Apple", "seattle"),
        (TimelinePoint(), UIColor.clear, "UW", "1:30 p.m.", nil, nil, "Apple")
        ], 1:[
            (TimelinePoint(), UIColor.black, "Seattle University", "2:30 p.m.", nil, nil, "seattle"),
            (TimelinePoint(), UIColor.black, "Mount Rainier", "3:30 p.m.", nil, nil, "Apple"),
            (TimelinePoint(), UIColor.clear, "Chihuly Garden and Glass", "4:30 p.m.", nil, nil, "seattle"),
        ]]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        confirmButton.isHidden = true
        tableView?.isEditing = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        tableView?.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        //let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
       // tableView?.addGestureRecognizer(longpress)
    }
    
    @IBAction func doEdit(sender: AnyObject) {
        tableView?.setEditing(true, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sectionData = data[section] else {
            return 0
        }
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day " + String(describing: section + 1)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell

        // Configure the cell...
        guard let sectionData = data[indexPath.section] else {
            return cell
        }
        
        var (timelinePoint, timelineBackColor, title, startTime, lineInfo, thumbnail, illustration) = sectionData[indexPath.row]
        var timelineFrontColor = UIColor.clear
        if (indexPath.row > 0) {
            timelineFrontColor = sectionData[indexPath.row - 1].1
        }
        cell.timelinePoint = timelinePoint
        cell.timeline.frontColor = timelineFrontColor
        cell.timeline.backColor = timelineBackColor
        cell.placeButton.setTitle(title, for: UIControlState.normal)
        cell.placeArrivalTime.setTitle(startTime, for: UIControlState.normal)
        //startTime.text = "Start Time: " + startTime
        //cell.titleLabel.text = title
        //cell.descriptionLabel.text = description
        cell.lineInfoLabel.text = lineInfo
        if let thumbnail = thumbnail {
           // cell.thumbnailImageView.image = UIImage(named: thumbnail)
        }
        else {
            //cell.thumbnailImageView.image = nil
        }
        if let illustration = illustration {
            cell.placeImage.image = UIImage(named: illustration)
            //cell.illustrationImageView.image = UIImage(named: illustration)
        }
        else {
            cell.placeImage.image = nil
            //cell.illustrationImageView.image = nil
        }
   
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionData = data[indexPath.section] else {
            return
        }
        
        print(sectionData[indexPath.row])
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    
    }
    

    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
