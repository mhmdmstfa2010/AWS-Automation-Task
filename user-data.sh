#!/bin/bash

# Update system and install essential packages
apt update
apt install -y wget git unzip

# Add Microsoft .NET 6 repositories
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt update
apt install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install

# Setup SSH
mkdir -p /home/ubuntu/.ssh
cat << EOF > /home/ubuntu/.ssh/id_ed25519
-----BEGIN OPENSSH PRIVATE KEY-----
-----END OPENSSH PRIVATE KEY-----
EOF

# Set correct ownership and permissions for SSH key
chown ubuntu:ubuntu /home/ubuntu/.ssh/id_ed25519
chmod 600 /home/ubuntu/.ssh/id_ed25519

# Add GitHub to known hosts to avoid SSH warnings
ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts
chown ubuntu:ubuntu /home/ubuntu/.ssh/known_hosts

# Clone the GitHub repository (update the URL below with your own repo)
cd /home/ubuntu
sudo -u ubuntu git clone git@github.com:your-username/your-repo-name.git srv-02
cd srv-02

# Publish the .NET application
echo 'DOTNET_CLI_HOME=/temp' >> /etc/environment
export DOTNET_CLI_HOME=/temp
dotnet publish -c Release --self-contained=false --runtime linux-x64

# Create a systemd service to run the app as a background service
cat >/etc/systemd/system/srv-02.service <<EOL
[Unit]
Description=Dotnet S3 info service

[Service]
ExecStart=/usr/bin/dotnet /home/ubuntu/srv-02/bin/Release/net6.0/linux-x64/srv02.dll
SyslogIdentifier=srv-02
Environment=DOTNET_CLI_HOME=/temp

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable srv-02
systemctl start srv-02

