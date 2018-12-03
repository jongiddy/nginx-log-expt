Test NGINX logging.

Edit `install.sh` to select one of the NGINX configs:

* stderr: error_log goes to stderr which is not read
* clear: error_log goes to a Unix domain socket that is read
* block_error: error_log goes to a Unix domain socket that is not read
* block_access: access_log goes to a Unix domain socket that is not read

Run `vagant up`. This will start OpenResty NGINX.

In another terminal run `python request.py`. This will send 10,000 requests to
NGINX.

Spoiler: `stderr` blocks and NGINX stops responding. All other configs keep
responding although logs are missing from the blocked sockets.

