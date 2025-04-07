
# Math Game for Kids - Flutter Uygulaması

Bu Flutter projesi, çocuklara matematiği sevdirmek ve dört işlem becerilerini oyun yoluyla geliştirmek 
amacıyla tasarlanmıştır. Kullanıcılar toplama, çıkarma, çarpma ve bölme oyunlarıyla kendilerini 
geliştirirken, skorlarını takip edebilirler. Uygulama, sade ve soft pastel renklerle çocuklara 
uygun şekilde dizayn edilmiştir.

---

## 📁 Proje Yapısı

```
lib/ 
├── main.dart
├── pages/
│   ├── login_page.dart
│   ├── home_page.dart
│   ├── home_page_addition.dart
│   ├── home_page_substraction.dart
│   ├── home_page_multipication.dart
│   ├── home_page_division.dart
├── util/
│   ├── my_button.dart
│   ├── result_message.dart
|   ├── const.dart
├── preferences_service.dart
├── custom_drawer.dart
```

---

## 🔄 Proje Sayfaları ve Görevleri

- **login_page.dart**: Kullanıcı adı ve şifreyle giriş yapılmasını ve yeni hesap oluşturulmasını sağlar.
- **home_page.dart**: Oyun seçim menüsünü barındırır. Kullanıcı buradan işlem türünü seçerek oyuna geçer.
- **home_page_addition.dart**: Toplama oyununun oynandığı sayfa.
- **home_page_substraction.dart**: Çıkarma oyununun oynandığı sayfa.
- **home_page_multipication.dart**: Çarpma oyununun oynandığı sayfa.
- **home_page_division.dart**: Bölme oyununun oynandığı sayfa.
- **custom_drawer.dart**: Sayfalar arası geçişi sağlayan menü.
- **my_button.dart**: Sayı tuşlarını içeren özel buton widget'ı.
- **result_message.dart**: Sonuç mesajlarını gösteren özel popup.
- **preferences_service.dart**: Kullanıcı verilerini kaydetme ve yükleme işlemlerini yönetir.

---

## 🎨 Drawer Menüdeki Logo ve API Bilgisi

Drawer menüsünde uygulamamız içi tasarladığımız 3 logoyu rastgele seçilerekrek görüntülenir. Bu logolar,
'https://67f44b66cbef97f40d2decaa.mockapi.io/logos' API'si kullanılarak dinamik olarak yüklenmektedir.

API adresi örneği:
```
'https://67f44b66cbef97f40d2decaa.mockapi.io/logos'
```
Bu sayede her uygulama açılışında farklı bir logo görüntülenir.

---

## 🔐 Login Bilgileri Nasıl Saklanıyor?

Kullanıcı adı, şifre ve skor verileri `shared_preferences` paketi ile **cihazda lokal olarak** saklanır.
Ayrıca her kullanıcıya özel skor takibi yapılması için veriler anahtar-değer çiftleri şeklinde 
kaydedilir.

Kullanılan paket:
```yaml
shared_preferences: ^2.2.2
```

---

## 💼 Grup Üye Katkıları

| Grup Üyesi        | Katkılar                                                                          |
|      Erva Eski        | Projenin toplama,çıkarma,bölme,çarma sayfalarını ve home sayfasını yapan kişi |
|Sümeyye Berfin Korkmaz | Projenin UI tasarımını,drawerını yapan, skor sistemi ve login mantığını kuran |
                         |ve hata ayıklama, test süreçlerini yapan kişi                                 |
> Tüm proje aslında birlikte geliştirilmiştir. Birçok yerde birbirimize yardım ettik ve fikir
alışverişinde bulunduk.

---

## 🌟 Öne Çıkan Özellikler

- ✨ **Kullanıcıya özel skor kaydı** (her kullanıcının doğru/yanlış verileri ayrı tutulur)
- 💪 Çocuk dostu **soft pastel tema** ve sade arayüz
- ⇄ Drawer menü ile kolay sayfa geçişi
- 🌐 Logo için dış kaynaklı dinamik API kullanımı
- 🛠️ Shared Preferences ile login ve skor verisi saklama

---

## 🧠 Yaratıcı ve Özgün Yaklaşım

- Uygulama sıradan bir matematik oyunundan ziyade, **kullanıcıya özel veri saklayan** ve 
**her işleme özgü tasarımlar sunan** bir yapıya sahiptir.
- Renklerin soft ve dikkat dağıtmayan şekilde kullanılması çocuk psikolojisi gözetilerek planlanmıştır.
- Rastgele logo özelliği ile her açılışta farklı bir görsel sunularak ilgi çekicilik artırılmıştır.

---
