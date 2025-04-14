# 🚀 AWS DevOps Automation Script

> 🧠 **From: [AWS DevOps 90% Course](https://cloudnativebasecamp.com/)** by Eng. **Ahmed Metwally**  
> 💡 Script adapted for automating .NET 6 deployments on Ubuntu EC2 instances using AWS Launch Templates.

---

## 📌 Overview

This project provides a Bash script to automate the deployment of a .NET 6 application on an Ubuntu EC2 instance.  
It sets up the environment, installs dependencies, pulls your code from GitHub via SSH, publishes the app, and runs it as a background service using **systemd**.

---

## 🧱 Infrastructure Setup (AWS)

This automation assumes you are provisioning your EC2 instance using an **Instance Launch Template** – a reusable configuration for quickly launching consistent environments.

### ✅ Steps to Set Up with Launch Template:

1. **Create a Launch Template**
   - Navigate to **EC2 > Launch Templates > Create launch template**
   - Recommended settings:
     - AMI: **Ubuntu Server 22.04 LTS**
     - Instance Type: **t2.micro** or higher
     - Key pair: Choose your SSH key (for EC2 access)
     - Security Groups:
       - Allow **SSH (22)** for remote access
       - Allow any ports needed by your app (e.g., 5000, 80, 443)
     - Storage: Minimum 8 GB
     - User data: *(bash script file: user-data.sh )*

2. **Launch EC2 Instance from Template**
   - Go to **Launch Instances** > **Launch from template**
   - Select your template and launch the instance.

3. **Connect to Your Instance**
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
4. **Transfer SSH Private Key for GitHub**

    Upload your GitHub id_ed25519 key securely

    Place it in /home/ubuntu/.ssh/ with correct permissions


   Script Features

    🔄 System update & essential packages installation

    🧱 .NET 6 SDK & Runtime setup

    ☁️ AWS CLI installation

    🔐 SSH key setup for GitHub access

    🧬 Cloning private GitHub repository

    🏗️ Publishing .NET app for Linux x64

    📡 Running app as a systemd service


   
