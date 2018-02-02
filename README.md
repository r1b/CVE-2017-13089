# CVE-2017-13089

wget v1.19.1 for exploit dev.

## NOTE

This is not a working exploit - under development.

## Usage

```bash
# Build the container
docker build -t cve201713089 .
# OR ...
docker pull robertcolejensen/cve201713089

# Play around in the container, `src` will be mounted at `/opt/CVE-2017-13089/src`
./run.sh

# Develop an exploit, runs `gdb` with external debugging symbols loaded
./run.sh dev

# Run the included DoS PoC
./run.sh dos

# Run the included exploit PoC (wip)
./run.sh exploit
```

## Notes

For maximum **FUN** I have done the following:

* Enabled executable stack flag in wget: `execstack -s /usr/local/bin/wget`
* Disabled stack canaries in wget: `CFLAGS="-fno-stack-protector $CFLAGS"`
* Disabled ASLR on the docker host: `docker-machine ssh security-vm 'sudo sysctl -w kernel.randomize_va_space=0'`
* Generated external debug symbols for exploit dev

You should duplicate the ASLR change on your own Docker host - the other changes
are in the Dockerfile.
