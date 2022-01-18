//
//  PlaylistController.swift
//  PlayList
//
//  Created by Mitya Kim on 1/15/22.
//

import Foundation

class PlaylistController {
    
    static let shared = PlaylistController()
    
    var playlists: [Playlist] = []
    
    func createPlaylist(name: String) {
        let newPlaylist = Playlist(name: name)
        playlists.append(newPlaylist)
        save()
    }
    
    func deletePlaylist(playlist: Playlist) {
        guard let index = playlists.firstIndex(of: playlist) else { return }
        playlists.remove(at: index)
        save()
    }
    
    func persistentStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("PlayList.json")
        return fileURL
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: persistentStore())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: persistentStore())
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
