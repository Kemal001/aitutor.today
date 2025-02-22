#!/bin/bash

if [ -z "$1" ]; then
    echo "❌ Ошибка: укажите имя пользователя!"
    exit 1
fi

USERNAME=$1
USER_HOME="/home/$USERNAME"
WEB_DIR="/usr/share/nginx/html"
INDEX_FILE="$WEB_DIR/index.html"

# 1️⃣ Установка Nginx (если он не установлен)
if ! command -v nginx &>/dev/null; then
    echo "📦 Устанавливаем Nginx..."
    sudo yum install -y nginx
else
    echo "✅ Nginx уже установлен."
fi

# 2️⃣ Создание пользователя
if id "$USERNAME" &>/dev/null; then
    echo "✅ Пользователь $USERNAME уже существует."
else
    sudo useradd -m -s /bin/bash $USERNAME
    echo "✅ Пользователь $USERNAME создан."
fi

# 3️⃣ Добавление в группу nginx
sudo usermod -aG nginx $USERNAME

# 4️⃣ Настройка прав доступа к index.html
if [ -f "$INDEX_FILE" ]; then
    sudo chown nginx:nginx "$INDEX_FILE"
    sudo chmod 664 "$INDEX_FILE"
    echo "✅ Доступ к $INDEX_FILE настроен."
else
    echo "⚠️ Файл $INDEX_FILE не найден! Возможно, его нужно создать."
fi

# 5️⃣ Создание SSH-ключей
sudo -u $USERNAME mkdir -p $USER_HOME/.ssh
KEY_FILE="$USER_HOME/.ssh/id_rsa"
if [ ! -f "$KEY_FILE" ]; then
    sudo -u $USERNAME ssh-keygen -t rsa -b 4096 -f $KEY_FILE -N ""
    sudo -u $USERNAME cat "$KEY_FILE.pub" >> "$USER_HOME/.ssh/authorized_keys"
    echo "✅ SSH-ключи созданы."
else
    echo "⚠️ SSH-ключи уже существуют."
fi

# 6️⃣ Настройка SSH-прав
sudo chmod 700 $USER_HOME/.ssh
sudo chmod 600 $USER_HOME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME $USER_HOME/.ssh

# 7️⃣ Отключение входа по паролю в SSH
sudo sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "✅ Setup complete!"
echo "📥 Download the private key: $KEY_FILE"
echo "🔑 Use the private key to connect: ssh -i $KEY_FILE $USERNAME@your-server-ip"
