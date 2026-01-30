To deploy this project in a real-world environment (On-premises or Cloud VM), the architecture should be tailored to enterprise needs:

1. Minimum Hardware Requirements
For a standard High Availability (HA) setup, a minimum of 06 Nodes running Ubuntu 22.04/24.04 LTS is recommended:

03 Control Plane Nodes: Maintains etcd quorum, ensuring cluster stability even if one master node fails.

03 Worker Nodes: Distributes application pods to ensure service continuity (Zero-downtime) during node maintenance.

External Load Balancer: Utilizing HAProxy or F5 to balance traffic across API Servers and application endpoints.

2. Runtime & Distribution Solutions
This project is adaptable to three enterprise infrastructure levels:

Native Kubernetes (Kubeadm + Containerd): For organizations requiring deep customization and full control over the stack.

Lightweight Production (K3s): Optimized for Edge Computing or medium-sized clusters with minimal resource overhead.

Enterprise Grade (Red Hat OpenShift): Highest security standard with CRI-O runtime, ideal for Finance and Telecommunications.

Project Core Focus: While production environments demand complex hardware, this repository is engineered to deploy a full Production HA system using k3d. The goal is to provide a comprehensive roadmap from core fundamentals to operational excellence, allowing users to experience Self-healing and Load Balancing capabilities within a streamlined, simulated environment.

Here is the professional English version of your installation guide, optimized for a GitHub README.md.

📋 Prerequisites
Before you begin, ensure your machine meets the following requirements:

Docker: The core engine to run containers.

Curl: Command-line tool for downloading installation scripts.

Minimum Hardware: 4GB RAM & 2 CPUs.

🛠 Step-by-Step Installation Guide
Step 1: Install Control Tools
If your machine is fresh, run the following commands (Supports Linux/Alpine/MacOS):

📋 Prerequisites
Before you begin, ensure your machine meets the following requirements:

Docker: The core engine to run containers.

Curl: Command-line tool for downloading installation scripts.

Minimum Hardware: 4GB RAM & 2 CPUs.

🛠 Step-by-Step Installation Guide
Step 1: Install Control Tools
If your machine is fresh, run the following commands (Supports Linux/Alpine/MacOS):

Bash
# 1. Install k3d (Cluster Manager)
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# 2. Install kubectl (K8s Command-line tool)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://downloads.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
Step 2: Initialize HA Cluster (3 Servers)
We use a configuration file to ensure consistency via Infrastructure as Code (IaC):

Bash
# Navigate to the project directory

git clone https://github.com/Masterhuthiu/K8s-Production-Showcase.git
cd 02-modern-k3d-ha/

# Initialize the cluster from the config file
k3d cluster create --config cluster-config.yaml
Step 3: Install Nginx Ingress Controller
Since this cluster is designed for Production, we will install Nginx Ingress to manage inbound traffic:

Bash
# Deploy Nginx Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# Wait for the Ingress Controller to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
Step 4: Deploy Sample Application
Now, deploy a web application featuring Replicas, Health Checks, and Ingress routing:

Bash
cd ../03-sample-app/
kubectl apply -f deployment.yaml
kubectl apply -f ingress.yaml
📊 Verify the Results
Once finished, run these commands to confirm the system status:

Check Nodes: kubectl get nodes (You should see 3 servers and 2 agents).

Check Pods: kubectl get pods -A (All pods should be in the Running state).

Access the App: Open your browser at http://localhost:8080 (or the IP of your PWD host).