//
//  PostListTableViewController.swift
//  Galleree
//
//  Created by Natalie Lim on 7/28/16.
//  Copyright © 2016 Dianatalie. All rights reserved.
//

import UIKit
import CoreData

class PostListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchedResultsController: NSFetchedResultsController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpFetchedResultsController()
        
        requestFullSync()
    }
    
    @IBAction func refreshControlActivated(sender: UIRefreshControl) {
        
        requestFullSync { 
            self.refreshControl?.endRefreshing()
        }
    }
    
    func requestFullSync(completion: (() -> Void)? = nil) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        PostController.sharedController.performFullSync {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        guard let sections = fetchedResultsController?.sections else { return 1 }
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchedResultsController?.sections else {return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as? PostTableViewCell,
            let post = fetchedResultsController?.objectAtIndexPath(indexPath) as? Post else { return PostTableViewCell() }
        
        cell.updateWithPost(post)
        
        return cell
    }
    
    
    // MARK: - Fetched Results Controller
    
    func setUpFetchedResultsController() {
        
        let request = NSFetchRequest(entityName: "Post")
        let dateSortDescription = NSSortDescriptor(key: "timestamp", ascending: false)
        
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [dateSortDescription]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request: \(error.localizedDescription)")
        }
        
        fetchedResultsController?.delegate = self
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toPostDetail" {
            
            if let detailViewController = segue.destinationViewController as? PostDetailTableViewController,
                let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                let post = fetchedResultsController?.objectAtIndexPath(selectedIndexPath) as? Post {
            
                detailViewController.post = post
            }
        }
        
    }
}

