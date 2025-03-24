import pytest
import os
import signal
import time
import subprocess

@pytest.fixture
def test_file_output():
    """Test if the file is being written to."""
    with open("/tmp/currentCount.out", "r") as f:
        lines = f.readlines()
        assert len(lines) > 1  # Ensure some output was written

def test_sigterm_handler():
    """Test if the script handles SIGTERM and writes the expected exit message."""
    with open("/tmp/currentCount.out", "r") as f:
        lines = f.readlines()
        assert "Received SIGTERM, exiting" in lines[-1]  # Check if exit message is in last line

