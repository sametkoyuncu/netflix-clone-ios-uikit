# Netflix Clone App
Uygulama programmatic ui ile geliştirildi. Büyük kısmını [iOS Development Course - Use Swift 5 and UIKit to Build a Netflix Clone](https://youtu.be/KCgYDCKqato) videosunu izleyerek yaptım. Eksik kısımları kendim ekledim. Örneğin `download` butonu her zaman aynı işlemi yapıyordu. Şimdi önce CoreData'da veri var mı kontrolü yapılıyor ve ona göre buton şekli ve işlevi değişiklik gösteriyor.

## Özellikler
- Anasayfada [TMDB API](https://www.themoviedb.org)'den gelen veriler gösteriliyor.
- Kullanıcı isterse detay sayfasına gidip, filmin detaylarını görüntülüyor.
- Detay sayfası için [Youtube Data API](https://developers.google.com/youtube/v3)'dan ilgili içeriğin fragmanı çekilip, sayfada gösteriliyor.
- Anasayfada filmin üstüne basılı tutunca veya detay sayfasındaki buton ile seçili filme bilgileri `CoreData`\`ya kaydedilliyor.
- Search sayfasında anahtar kelime ile arama yapılabiliyor.

## Kullanılanlar
- UIKit
  - TableView
  - CollectionView
  - WebKit
  - SearchController
- CoreData
- URLSession
- SDWebImage
- Notification Center
- Delegation Pattern
- Closures for notification and data transfer

## Ekran Görüntüleri

![ss1](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/netflixClone1.png)

![ss2](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/netflixClone2.png)

![ss3](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/netflixClone3.png)

## Ekran Kaydı

[![youtube-video](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/youtube.png)](https://www.youtube.com/embed/rLWiDc0GMEo)

## Kurulum
- Projeyi indirin veya clone'layın.
- `spm` ile `SdWebImage` paketini yükleyin.
- TMDB ve Google Developer Console'dan alacağınız API key'i `Managers > APICaller.swift` dosyasındaki ilgili yerlere ekleyin.
```swift
struct Constants {
    static let API_KEY = K.API_KEY // your TMDB api key here
    static let baseURL = "https://api.themoviedb.org"
    static let YOUTUBE_API_KEY = K.GOOGLE_API_KEY // your GOOGLE api key here
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}
```
- Proje kullanıma hazır, keyfini sürün 🎉😊
