## Knowledge Graph Data

If you want to make your own knowledge graph, please follow the [biomedgps-data](https://github.com/yjcyxky/biomedgps-data) repository.

If not, you can download the predefined knowledge graph from our [xxx]() and put them in this folder.

After that, you can run the following command to import the knowledge graph into the database. We assume you have placed all dataset files in `/data/prophet-studio/datasets` folder and you have mounted the `/data/prophet-studio/datasets` folder to the `/data/prophet-studio/datasets` folder in the container. If not, please change the path in the docker-compose.yml file first and then relaunch all containers.

Because the csv importer of postgresql need to access the file in the container, but we run the biomedgps-cli command in another container, so we need to keep all of them accessing the same file path. That's why we need to mount the `/data/prophet-studio/datasets` folder to the `/data/prophet-studio/datasets` folder in the container.

```bash
# Find the container id of the biomedgps container
docker ps -a

# Import the knowledge graph
docker exec --rm -it <container_id> biomedgps-cli -v importdb -D -f /data/prophet-studio/datasets/<your-file> -t <your-file-type>
```