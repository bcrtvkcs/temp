import socket
import time
import os

# Temporary file to prevent signal interference
LOCK_FILE = "/tmp/trigger_timeout"
COOLDOWN = 1.0 # wait 1 second

def send_switch_signal():
    # If a signal was sent within the last second, it will work
    if os.path.exists(LOCK_FILE):
        last_run = os.path.getmtime(LOCK_FILE)
        if time.time() - last_run < COOLDOWN:
            return

    # Create (or update) a timestamp
    with open(LOCK_FILE, "w") as f:
        f.write("running")

    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.sendto(b"SWITCH", ("255.255.255.255", 8888))
        sock.close()
    except:
        pass

if __name__ == "__main__":
    send_switch_signal()
