#!/usr/bin/env python3

import time
import signal
import sys
from datetime import datetime

# open file
file = open("/tmp/currentCount.out", "w")

counter = 0

# SIGTERM handler
def handle_sigterm(signum, frame):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    exit_message = f"Danitz: {timestamp} Received SIGTERM, exiting\n"

    file.write(exit_message)
    file.flush()  # Ensure it gets written before exit

    print(exit_message, flush=True)  # Print to terminal as well
    file.close()
    sys.exit(0)

# Register SIGTERM handler
signal.signal(signal.SIGTERM, handle_sigterm)

# Main loop
while True:
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Terminal output
    print(f"Danitz: {timestamp} #{counter}\n", flush=True)

    # File output
    file.write(f"{timestamp} #{counter}\n")
    file.flush()  # Ensure each write is saved immediately

    time.sleep(1)
    counter += 1

