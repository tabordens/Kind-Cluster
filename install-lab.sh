sudo dnf update -y
sudo dnf install -y curl wget git vim tar bash-completion bash-completion-extras
sudo dnf install -y bind-utils
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv kind /usr/local/bin
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin
sudo dnf install -y git
echo 'source /etc/profile.d/bash_completion.sh' >> ~/.bashrc
echo 'source <(kubectl completion bash)' >> ~/.bashrc
git clone https://github.com/tabordens/Kind-Cluster.git
