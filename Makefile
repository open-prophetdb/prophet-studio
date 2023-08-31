.PHONY: clean

clean:
	rm -rf data/biomedgps/*
	rm -rf data/paper-downloader/* data/paper-downloader/.minio.sys
	rm -rf data/postgresql/*
	rm -rf data/prophet-studio/*