# docker-kafka
This project helps to deploy kafka using dockerfile

## pre requisite
docker desktop must be installed on your local system


## Docker command to setup

### Build image
docker build -t my-kafka .

### start container
docker run -d -p 9092:9092 -p 2181:2181 my-kafka


## tools to connect kfka locally 
https://www.kafkatool.com/download.html
