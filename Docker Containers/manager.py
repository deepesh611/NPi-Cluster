import time
import subprocess

# Simple configuration
MIN_THRESHOLD = 30
MAX_NODES = 3
CHECK_INTERVAL = 5  # seconds

# State
active_nodes = [1]

def get_load():
    try:
        return int(input("Enter current load (0-100): "))
    except ValueError:
        return 0

def start_node(node_num):
    subprocess.run(["docker-compose", "up", "-d", f"node{node_num}"])
    print(f"✅ Started node{node_num}")

def stop_node(node_num):
    subprocess.run(["docker-compose", "stop", f"node{node_num}"])
    print(f"🛑 Stopped node{node_num}")

def scale_cluster(load):
    global active_nodes

    if load > MIN_THRESHOLD and len(active_nodes) < MAX_NODES:
        next_node = len(active_nodes) + 1
        start_node(next_node)
        active_nodes.append(next_node)

    elif load <= MIN_THRESHOLD and len(active_nodes) > 1:
        last_node = active_nodes.pop()
        stop_node(last_node)

def main():
    print("🚀 NPi-Cluster Manager Started")
    start_node(1)  # Always keep at least one node on
    while True:
        load = get_load()
        scale_cluster(load)
        time.sleep(CHECK_INTERVAL)

if __name__ == "__main__":
    main()
