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

## Ekran Görüntüleri

![ss1](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/netflixClone1.png)

![ss2](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/netflixClone2.png)

![ss3](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/netflixClone3.png)

## Ekran Kaydı

[![youtube-video](https://github.com/sametkoyuncu/netflix-clone-ios-uikit/blob/main/screenshots/youtube.png)](https://www.youtube.com/embed/rLWiDc0GMEo)
