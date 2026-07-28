
![image](https://github.com/Tunahan-Uysal/RoGen/assets/36801721/5dfbabea-894f-4f0a-83a9-7358712ac292)

# RoGen

Create large colorful and expanseful worlds with ease and speed using **RoGen**

---

ENGLISH GUIDE:

## Quick Start (EASIEST METHOD!)

**Just double-click `run.bat`** - it will automatically:
- Check if Python is installed
- Verify Python version compatibility
- Install dependencies if needed
- Launch the program!

## Installing Python

### Recommended Python Version

**Python 3.11 is highly recommended** for best compatibility with RoGen.

Supported versions: Python 3.9, 3.10, 3.11, or 3.12

**Avoid Python 3.13+** as it may have compatibility issues with some dependencies.

### Installation Steps

1. Download Python 3.11 from https://www.python.org/downloads/
2. During installation, **CHECK THE BOX** that says "Add Python to PATH" (very important!)
3. Once installed, run `run.bat` to launch RoGen

## Manual Installation (if needed)

If you prefer manual control or `run.bat` doesn't work:

1. Install Python 3.11 from https://www.python.org/downloads/
2. Make sure to check "Add Python to PATH" during installation
3. Run `install.bat` to install dependencies
4. Run `start.bat` to launch the program

## Troubleshooting

### Common Issues and Solutions

**Problem: "Python is not installed or not found"**
- Solution: Install Python from https://www.python.org/downloads/
- Make sure to check "Add Python to PATH" during installation

**Problem: Installation fails with NumPy errors**
- Solution: You're likely using Python 3.13 which isn't fully supported yet
- Download and install Python 3.11 from https://www.python.org/downloads/
- Uninstall your current Python version first if needed

**Problem: "Can't find requirements.txt" or System32 errors**
- Solution: Use `run.bat` instead of manually running commands
- The batch files now automatically navigate to the correct folder

**Problem: Folder is in OneDrive**
- Solution: Move the RoGen folder outside of OneDrive to prevent sync issues

**Problem: Program won't start**
- Solution: Make sure the folder is extracted/unarchived (not still in a ZIP file)
- Try running `install.bat` first, then `start.bat`

### Where are my maps exported to?

Maps are exported to: `~/RoGen/main/.lune/generatedMaps`

---

TÜRKÇE REHBER: 

## Hızlı Başlangıç (EN KOLAY YÖNTEM!)

**Sadece `run.bat` dosyasına çift tıklayın** - otomatik olarak:
- Python'un kurulu olup olmadığını kontrol eder
- Python sürümü uyumluluğunu doğrular
- Gerekirse bağımlılıkları yükler
- Programı başlatır!

## Python Kurulumu

### Önerilen Python Sürümü

**Python 3.11**, RoGen ile en iyi uyumluluk için şiddetle tavsiye edilir.

Desteklenen sürümler: Python 3.9, 3.10, 3.11 veya 3.12

**Python 3.13+ kullanmaktan kaçının** çünkü bazı bağımlılıklarla uyumluluk sorunları olabilir.

### Kurulum Adımları

1. Python 3.11'i https://www.python.org/downloads/ adresinden indirin
2. Kurulum sırasında "Add Python to PATH" kutusunu **İŞARETLEYİN** (çok önemli!)
3. Kurulduktan sonra RoGen'i başlatmak için `run.bat` dosyasını çalıştırın

## Manuel Kurulum (gerekirse)

Elle kontrol tercih ediyorsanız veya `run.bat` çalışmazsa:

1. Python 3.11'i https://www.python.org/downloads/ adresinden yükleyin
2. Kurulum sırasında "Add Python to PATH" seçeneğini işaretlediğinizden emin olun
3. Bağımlılıkları yüklemek için `install.bat` dosyasını çalıştırın
4. Programı başlatmak için `start.bat` dosyasını çalıştırın

## Sorun Giderme

### Yaygın Sorunlar ve Çözümleri

**Sorun: "Python yüklü değil veya bulunamadı"**
- Çözüm: Python'u https://www.python.org/downloads/ adresinden yükleyin
- Kurulum sırasında "Add Python to PATH" seçeneğini işaretlediğinizden emin olun

**Sorun: NumPy hatalarıyla kurulum başarısız oluyor**
- Çözüm: Muhtemelen henüz tam desteklenmeyen Python 3.13 kullanıyorsunuz
- https://www.python.org/downloads/ adresinden Python 3.11 indirip kurun
- Gerekirse mevcut Python sürümünüzü önce kaldırın

**Sorun: "requirements.txt bulunamıyor" veya System32 hataları**
- Çözüm: Komutları manuel çalıştırmak yerine `run.bat` kullanın
- Batch dosyaları artık doğru klasöre otomatik olarak gider

**Sorun: Klasör OneDrive'da**
- Çözüm: Senkronizasyon sorunlarını önlemek için RoGen klasörünü OneDrive dışına taşıyın

**Sorun: Program başlamıyor**
- Çözüm: Klasörün çıkarılmış/archivden çıkmış olduğundan emin olun (hala ZIP dosyasında değil)
- Önce `install.bat`, ardından `start.bat` dosyasını çalıştırmayı deneyin

### Haritalarım nereye aktarılıyor?

Haritalar şuraya aktarılır: `~/RoGen/main/.lune/generatedMaps`
