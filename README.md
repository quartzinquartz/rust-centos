# rust-centos

A rust development container with vim and fish on centos.

### SAMPLE RUN COMMAND:
~> docker run -it -d --hostname="rust-centos" --name="rust-centos" -v ~/code/rust/:/root/code -w /root/code derekjenkins/rust-centos:latest

### SAMPLE EXEC COMMAND:
~> docker exec -it rust-centos /usr/bin/fish
