#!/bin/bash

# Update system packages
sudo apt update && upgrade -y

# Install OpenJDK 17 JRE and fontconfig
sudo apt install openjdk-17-jre -y

# Verify Java installation
java -version

# Add Jenkins repository key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to sources list
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again with Jenkins repo
sudo apt-get update

# Install Jenkins
sudo apt-get install -y jenkins

# Print Jenkins status
sudo systemctl status jenkins

# Wait to ensure Jenkins service gets installed properly
sleep 10

# Start Jenkins service and enable it
sudo systemctl reset-failed jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Optional: Print Jenkins status
sudo systemctl status jenkins

# Install unzip for Terraform
sudo apt-get install -y unzip

# Download and install Terraform (for 64-bit systems)
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_amd64.zip
unzip terraform_1.6.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Clean up
rm terraform_1.6.5_linux_amd64.zip

echo "✅ Setup completed. Jenkins should be running on port 8080 and Terraform is installed."
