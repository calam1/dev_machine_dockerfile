# dev_machine_dockerfile
dockerfile and supporting files for basic dev machine set up; not complete yet

# build the image
docker build -t dev_machine .

# build the container
docker run -i -t --name devmachine --hostname devmachine dev_machine

# access machine
docker exec -i -t devmachine zsh
