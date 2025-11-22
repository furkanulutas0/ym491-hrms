# ym-491 Projesi

Bu proje, mikroservis tabanlı bir arka uç ve modern bir Next.js ön uç içeren tam yığın bir uygulamadır.

## 🏗 Mimari

### Arka Uç (Mikroservisler)
Arka uç, Docker Compose kullanılarak düzenlenen birkaç servisten oluşmaktadır:

*   **Ağ Geçidi (Nginx):** Tüm arka uç istekleri için giriş noktasıdır. `80` numaralı bağlantı noktasında çalışır.
    *   `/ai/*` isteklerini Yapay Zeka Servisine yönlendirir
    *   `/base/*` isteklerini Temel Servise yönlendirir
    *   `/io/*` isteklerini Girdi/Çıktı Servisine yönlendirir
*   **Temel Servis:** Çekirdek işlevselliği, kimlik doğrulama ve kullanıcı yönetimini ele alır.
    *   Teknoloji: Python, FastAPI, SQLAlchemy
    *   Bağlantı Noktası: `8002` (dışa açık), `8000` (dahili)
*   **Yapay Zeka Servisi:** Yapay Zeka işlemleri için özelleşmiş servis.
    *   Teknoloji: Python, FastAPI
    *   Bağlantı Noktası: `8001` (dışa açık), `8000` (dahili)
*   **Girdi/Çıktı Servisi:** Harici G/Ç işlemlerini (örn. Firebase entegrasyonu) ele alır.
    *   Teknoloji: Python, FastAPI
    *   Bağlantı Noktası: `8003` (dışa açık), `8000` (dahili)
*   **Veritabanı:** PostgreSQL
    *   Bağlantı Noktası: `5432`

### Ön Uç
*   **İstemci:** Bir Next.js 16 uygulaması.
    *   Teknoloji: React 19, Tailwind CSS 4, React Query, Bun.

## 🚀 Başlangıç

### Ön Koşullar
*   [Docker Desktop](https://www.docker.com/products/docker-desktop)
*   [Bun](https://bun.sh/) (ön uç için önerilir) veya Node.js

### 1. Arka Uç Kurulumu (Docker)

Arka ucu çalıştırmanın en kolay yolu Docker Compose kullanmaktır.

1.  Arka uç dizinine gidin:
    ```bash
    cd backend
    ```

2.  Servisleri başlatın:
    ```bash
    docker-compose up -d --build
    ```

Bu işlem tüm servisleri ve PostgreSQL veritabanını başlatacaktır.
*   Ağ Geçidi: `http://localhost`
*   Temel Servis: `http://localhost:8002`
*   Yapay Zeka Servisi: `http://localhost:8001`
*   Girdi/Çıktı Servisi: `http://localhost:8003`

### 2. Ön Uç Kurulumu

1.  İstemci dizinine gidin:
    ```bash
    cd client
    ```

2.  Bağımlılıkları yükleyin:
    ```bash
    bun install
    # veya
    npm install
    ```

3.  Geliştirme sunucusunu çalıştırın:
    ```bash
    bun dev
    # veya
    npm run dev
    ```

Ön uç `http://localhost:3000` adresinde erişilebilir olacaktır.

## 🛠 Geliştirme Notları

### Ortam Değişkenleri
*   **Arka Uç:** Varsayılan ortam değişkenleri için `backend/docker-compose.yml` dosyasını kontrol edin.
*   **İstemci:** Varsayılan API uç noktalarını geçersiz kılmanız gerekiyorsa `client/` dizininde bir `.env.local` dosyası oluşturun.

### API Dokümantasyonu
Arka uç çalışırken, birleşik API dokümantasyonuna veya bireysel servis dokümanlarına erişebilirsiniz:
*   Ağ Geçidi/Birleşik: `http://localhost/docs` (yapılandırıldıysa)
*   Temel Servis Swagger: `http://localhost:8002/docs`
*   Yapay Zeka Servisi Swagger: `http://localhost:8001/docs`
*   Girdi/Çıktı Servisi Swagger: `http://localhost:8003/docs`

## 📂 Proje Yapısı

```
ym-491/
├── backend/              # Arka uç mikroservisleri
│   ├── ai-service/       # Yapay Zeka özel mantığı
│   ├── base-service/     # Kimlik Doğrulama ve Çekirdek mantık (Postgres)
│   ├── io-service/       # Firebase/G/Ç mantığı
│   ├── gateway/          # Nginx Ters Proxy
│   └── docker-compose.yml
└── client/               # Next.js Ön uç
    ├── src/
    │   ├── app/          # Uygulama Yönlendirici sayfaları
    │   ├── features/     # Özellik tabanlı modüller
    │   ├── components/   # Paylaşılan UI bileşenleri
    │   └── lib/          # Yardımcı programlar ve API istemcileri
```

## 🤝 Katkıda Bulunma

Projeye katkıda bulunmak için **Fork & Pull Request** stratejisini kullanıyoruz. Lütfen aşağıdaki adımları izleyin:

1.  **Projeyi Fork Edin**
    *   Bu repository'nin sağ üst köşesindeki **Fork** butonuna tıklayarak projeyi kendi GitHub hesabınıza kopyalayın.

2.  **Fork'u Yerel Makinenize Klonlayın**
    *   Kendi hesabınızdaki kopyayı bilgisayarınıza indirin:
        ```bash
        git clone https://github.com/KULLANICI_ADINIZ/ym-491.git
        cd ym-491
        ```

3.  **Upstream Remote Ekleyin**
    *   Orijinal projeyi (ana depo) `upstream` olarak ekleyerek güncel kalmasını sağlayın:
        ```bash
        git remote add upstream https://github.com/ORIJINAL_REPO_SAHIBI/ym-491.git
        ```

4.  **Güncel Olduğunuzdan Emin Olun**
    *   Çalışmaya başlamadan önce ana daldan güncellemeleri alın:
        ```bash
        git checkout main
        git pull upstream main
        ```

5.  **Yeni Bir Branch Oluşturun**
    *   Yapacağınız değişiklik için açıklayıcı bir isme sahip yeni bir dal açın:
        ```bash
        git checkout -b feature/yeni-ozellik-adi
        # veya
        git checkout -b fix/hata-duzeltme
        ```

6.  **Geliştirmelerinizi Yapın ve Commit Edin**
    *   Kodunuzu yazın ve açıklayıcı mesajlarla kaydedin:
        ```bash
        git add .
        git commit -m "feat: Yeni özellik eklendi"
        ```

7.  **Değişiklikleri Kendi Forkunuza Gönderin (Push)**
    *   ```bash
        git push origin feature/yeni-ozellik-adi
        ```

8.  **Pull Request (PR) Oluşturun**
    *   GitHub'da kendi fork sayfanıza gidin.
    *   Yeşil renkli **Compare & pull request** butonuna tıklayın.
    *   Yaptığınız değişiklikleri özetleyen bir başlık ve açıklama yazarak PR'ı gönderin.
