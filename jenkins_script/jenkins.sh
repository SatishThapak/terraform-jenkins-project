#!/bin/bash
set -e  # Exit on error

# Update and install Java
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk-headless

# Wait before Jenkins installation
echo "Waiting for 30 seconds before installing the Jenkins package..."
sleep 30

# Add Jenkins key and repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Wait before Terraform installation
echo "Waiting for 30 seconds before installing Terraform..."
sleep 30

# Install unzip if not installed
sudo apt-get install -y unzip

# Download and install Terraform
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_amd64.zip
unzip terraform_1.6.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
cd -
rm -rf "$TMP_DIR"

echo "Installation complete."
