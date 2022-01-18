//
//  SongController.swift
//  PlayList
//
//  Created by Mitya Kim on 1/14/22.
//

import Foundation

class SongController {
    
    static func createSong(title: String, artistName: String, playlist: Playlist) {
        let newSong = Song(title: title, artistName: artistName)
        playlist.songs.append(newSong)
        PlaylistController.shared.save()
    }
    
    static func deleteSong(song: Song, playlist: Playlist) {
        guard let index = playlist.songs.firstIndex(of: song) else { return }
        playlist.songs.remove(at: index)
        PlaylistController.shared.save()
    }
}
