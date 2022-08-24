//
//  UsersDetailsTableViewController.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import UIKit
import MapKit

class UsersDetailsTableViewController: UITableViewController {
    
    var viewModel: UserDetailsViewModel?
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.noOfItemsToDisplay ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsTableViewCell.identifier, for: indexPath) as? UserDetailsTableViewCell else { fatalError("Cell not found.") }
        
        cell.cellViewModel = viewModel?.getCellViewModel(at: indexPath.row)
        
        return cell
    }
    
    @IBAction func openMap(_ sender: UIBarButtonItem) {
        guard let viewModel = viewModel else { return }
        
        let latitude: CLLocationDegrees = viewModel.latitude
        let longitude: CLLocationDegrees = viewModel.longitude
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = viewModel.name
        mapItem.openInMaps(launchOptions: options)
    }
}
