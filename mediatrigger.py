import socket
import sys

COMMANDS = {"play_pause", "vol_up", "vol_down", "mute", "next", "prev"}

def send_media_signal(command):
    command = command.upper()
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.sendto(command.encode(), ("255.255.255.255", 8889))
        sock.close()
    except:
        pass

if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1].lower() not in COMMANDS:
        print(f"Usage: python3 trigger_media.py <{'|'.join(COMMANDS)}>")
        sys.exit(1)
    send_media_signal(sys.argv[1])