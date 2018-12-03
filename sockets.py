import socket
import os


def _safe_decode(output_bytes):
    """
    Decode a bytestring to Unicode with a safe fallback.
    """
    try:
        return output_bytes.decode(
            encoding='utf-8',
            errors='strict',
        )
    except UnicodeDecodeError:
        return output_bytes.decode(
            encoding='ascii',
            errors='backslashreplace',
        )


block_name = '/tmp/block.sock'
clear_name = '/tmp/clear.sock'

try:
    os.remove(block_name)
except OSError as e:
    if e.errno != 2:
        raise
try:
    os.remove(clear_name)
except OSError as e:
    if e.errno != 2:
        raise

with socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM) as block:
    block.bind(block_name)
    os.chmod(block_name, 0o666)  # allow anyone to write to socket

    with socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM) as clear:
        clear.bind(clear_name)
        os.chmod(clear_name, 0o666)  # allow anyone to write to socket

        print('Reading clear socket...')
        with open('/vagrant/log.txt', 'w') as f:
            while True:
                datagram = clear.recv(2048)
                f.write('>' + _safe_decode(datagram) + '\n')
                f.flush()

os.remove(clear_name)
os.remove(block_name)
