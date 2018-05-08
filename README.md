# dev_machine_dockerfile
dockerfile and supporting files for basic dev machine set up; not complete yet
if you are behind a proxy you need to read this https://docs.docker.com/config/daemon/systemd/#httphttps-proxy and set it up, if you are using a linux box, otherwise a mac client uses the preferences

# build the image
docker build -t dev_machine .

# build the container
docker run -i -t --name devmachine --hostname devmachine dev_machine
# or if you want to share a drive on the host and the docker machine
docker run -i -t --name devmachine --hostname devmachine -v /u00/workspace:/root/workspace dev_machine

# access machine
docker exec -i -t devmachine zsh
