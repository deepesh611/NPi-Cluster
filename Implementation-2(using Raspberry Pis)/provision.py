import time
import subprocess
from relay_control import power_on, power_off

NODES = {
    "node1": "192.168.154.189",  # always-on
    "node2": "192.168.154.139"   # dynamically managed
}

STATE = {
    "node1": True,
    "node2": False
}

THIGH = 160     # ms – turn ON node2
TLOW = 100      # ms – turn OFF node2


def get_delay(ip):
    try:
        out = subprocess.check_output([
            "curl", "-o", "/dev/null", "-s", "-w", "%{time_total}", f"http://{ip}"
        ], timeout=5)
        return float(out.strip()) * 1000
    except:
        return 9999


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")


while True:
    delay = get_delay(NODES["node1"])
    log(f"Node1 delay: {delay:.2f} ms")

    if delay > THIGH and not STATE["node2"]:
        log("High load → Turning ON node2")
        power_on("node2")
        STATE["node2"] = True
        time.sleep(10)

    elif delay < TLOW and STATE["node2"]:
        log("Low load → Turning OFF node2")
        power_off("node2")
        STATE["node2"] = False
        time.sleep(5)

    time.sleep(5)