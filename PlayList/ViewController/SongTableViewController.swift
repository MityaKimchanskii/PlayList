//
//  SongTableViewController.swift
//  PlayList
//
//  Created by Mitya Kim on 1/14/22.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    // MARK: - Properties
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = titleTextField.text else { return }
        guard let artistName = artistTextField.text else { return }
        guard !songTitle.isEmpty else { return }
        guard !artistName.isEmpty else { return }
        guard let playlist = playlist else { return }
        SongController.createSong(title: songTitle, artistName: artistName, playlist: playlist)
        titleTextField.text = ""
        artistTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let playlist = playlist else { return cell }
        let song = playlist.songs[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artistName

        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let songToDelete = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
