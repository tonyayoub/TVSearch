//
//  Samples.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

extension Show {
    static func sampleData(count: Int) -> [Show] {
        let hardcodedShows = [
            Show(
                id: 139,
                name: "Girls",
                genres: ["Drama", "Romance"],
                runtime: 30,
                image: ImageInfo(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
                ),
                summary: "This Emmy-winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s."
            ),
            Show(
                id: 41734,
                name: "GIRLS",
                genres: ["Comedy"],
                runtime: 41,
                image: ImageInfo(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/191/478539.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/191/478539.jpg"
                ),
                summary: nil
            ),
            Show(
                id: 525,
                name: "Gilmore Girls",
                genres: ["Drama", "Comedy", "Romance"],
                runtime: 60,
                image: ImageInfo(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/4/11308.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/4/11308.jpg"
                ),
                summary: "Gilmore Girls is a drama centering around the relationship between a thirty-something single mother and her teen daughter living in Stars Hollow, Connecticut."
            ),
            Show(
                id: 23542,
                name: "Good Girls",
                genres: ["Drama", "Comedy", "Crime"],
                runtime: 60,
                image: ImageInfo(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/297/744253.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/297/744253.jpg"
                ),
                summary: "Good Girls follows three suburban wives and mothers who decide to stop playing it safe and risk everything to take their power back."
            ),
            Show(
                id: 33320,
                name: "Derry Girls",
                genres: ["Comedy"],
                runtime: 33,
                image: ImageInfo(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/402/1007479.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/402/1007479.jpg"
                ),
                summary: "A comic look at the lives of a group of teenagers growing up in Derry during the 1990s."
            )
        ]

        var result: [Show] = []
        for i in 0..<count {
            result.append(hardcodedShows[i % hardcodedShows.count])
        }
        return result
    }
}

