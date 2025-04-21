# NPi-Cluster

A lightweight, dynamic web server cluster that simulates the behavior of a Raspberry Pi-based energy-efficient system using Docker containers.

---

## 📦 Features

- Dynamic provisioning of web server nodes based on simulated load
- Docker-based implementation for easy deployment and testing
- Python manager script to control node scaling
- Optional Raspberry Pi hardware implementation

---

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Python 3.x installed

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/deepesh611/NPi-Cluster.git
   cd NPi-Cluster
    ```
2. Run the setup script:

    ```bash
    chmod +x setup.sh
    ./setup.sh
   ```
This script will:
- Update and upgrade system packages
- Create a Python virtual environment
- Install Python packages from requirements.txt
- Build Docker images
- Start the initial Docker container (node1)

---

## 📄 License
This project is licensed under the Apache-2.0 License. See the [LICENSE](./LICENSE) file for details.

---

## 🤝 Contributing
Contributions are welcome! Please fork the repository and submit a pull request.
