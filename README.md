# 🚀 AI Tutor Landing Page Setup

## 📌 Описание
Этот репозиторий содержит скрипты и инструкции для автоматического развертывания лендинга **AI Tutor** на сервере с **nginx** и привязкой к домену `aitutor.today`.

## 📜 Установка и запуск
1. **Клонируйте репозиторий:**
   ```sh
   git clone https://github.com/your-repo/ai-tutor-setup.git
   cd ai-tutor-setup
   ```
2. **Запустите установку нового пользователя:**
   ```sh
   sudo bash setup_user.sh <username>
   ```
   Замените `<username>` на имя нового пользователя.
3. **Подключитесь к серверу:**
   ```sh
   ssh -i /path/to/id_rsa <username>@your-server-ip
   ```

## 🔧 Основные команды
### Управление пользователями
- **Создать нового пользователя и настроить доступ:**
  ```sh
  sudo bash setup_user.sh <username>
  ```
- **Удалить пользователя:**
  ```sh
  sudo userdel -r <username>
  ```

### Работа с Nginx
- **Перезапустить Nginx:**
  ```sh
  sudo systemctl restart nginx
  ```
- **Проверить статус Nginx:**
  ```sh
  sudo systemctl status nginx
  ```
- **Проверить конфигурацию Nginx:**
  ```sh
  sudo nginx -t
  ```

### Работа с файлом `index.html`
- **Изменить владельца файла:**
  ```sh
  sudo chown www-data:www-data /usr/share/nginx/html/index.html
  ```
- **Изменить права доступа:**
  ```sh
  sudo chmod 664 /usr/share/nginx/html/index.html
  ```

## 🔧 Возможные проблемы
- **Нет доступа к SSH** → Проверьте, что `id_rsa` имеет правильные права (`chmod 600 id_rsa`).
- **nginx не запускается** → Убедитесь, что порт **80** не занят (`sudo netstat -tulnp | grep :80`).
- **Ошибка прав доступа к `index.html`** → Запустите `sudo chown www-data:www-data /usr/share/nginx/html/index.html`.

