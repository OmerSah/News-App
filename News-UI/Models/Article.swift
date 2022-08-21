//
//  News.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import Foundation

struct Article: Codable, Identifiable {
    var id = UUID()
    let source: NewsSource
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    var isBookmarked = false
    
    enum CodingKeys: CodingKey {
       case source, author, title, description,
            url, urlToImage, publishedAt, content
    }
}

let dummyArticle =
Article(
    source: NewsSource(id: nil, name: "Mynet.com"),
    author: "Mynet.com",
    title: "Akaryakıt zammı öncesi flaş gelişme! Kimse bunu beklemiyordu: Fiyatlar yüzde 5 düştü… Benzin ve motorine indirim gelecek mi? - Mynet",
    description: "Petrol fiyatlarındaki yükseliş, benzin ve motorin zammı haberlerini de beraberinde getirmişti. Akaryakıt fiyatlarında hafta sonu gelen zam haberinin ardından yeni gelişme  yaşandı. Petrol fiyatları bugün Çin etkisiyle sert kayıp yaşayarak yüzde 5 geriledi. Pe…",
    url: "https://finans.mynet.com/haber/detay/ekonomi/akaryakit-zammi-oncesi-flas-gelisme-kimse-bunu-beklemiyordu-fiyatlar-yuzde-5-dustu-benzin-ve-motorine-indirim-gelecek-mi/447812/",
    urlToImage: "https://imgrosetta.mynet.com.tr/file/15171468/15171468-700x400.jpg",
    publishedAt: Date(),
    content: "Dünya petrol piyasalar Rusya-Ukrayna sava ile hareketli bir yl geçirirken geçtiimiz hafta Avrupa'nn Rusya'ya yönelik yaptrmlarna Putinden yeni bir hamle gelmi ve Rus petrol boru hatt iletmecisi Trans… [+2917 chars]"
)
