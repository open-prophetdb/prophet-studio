# Prophet Studio

A labeling tool for biomedical publications. It is composed of the following systems:

- [Label Studio](https://github.com/yjcyxky/label-studio) - A labeling tool for data scientists and machine learning researchers.

- [Paper Downloader](https://github.com/yjcyxky/paper-downloader) - A tool for downloading the papers from the pubmed.

- [Knowledge Graph Editor](https://github.com/yjcyxky/knowledge-graph-editor) - This extension is designed for synchronizing findings/knowledges into a biomedgps instance. The findings/knowledges are annotated from literature and other sources using Label Studio.

- [BioMedGPS](https://github.com/yjcyxky/biomedgps) - A knowledge graph system with graph neural network for drug discovery, disease mechanism and biomarker screening.

- [NER & RE Models](./models/) - A set of models for biomedical named entity recognition and relation extraction.

## Launch the prophet studio

Advantage: You can make the paper-downloader as a service and it will listen the events of the bucket. When you upload a file to the bucket, the paper-downloader will download the file automatically.

```
git clone https://github.com/yjcyxky/prophet-studio.git

# Before you launch the prophet studio, you need to modify the `.env.example` file according to your situation, such as <MINIO_ACCESS_KEY>, <MINIO_SECRET_KEY>, <DINGTALK_ACCESS_KEY> etc. and rename it to `.env` file.

cd prophet-studio
docker compose up -d
```

After that, you can access the label studio by `http://<your-ip>:8080` with the related access key and secret key.

## FAQs

1. If you create a new organization, you need to relaunch the prophet studio. Otherwise, the paper-downloader will not work.

```bash
cd prophet-studio
docker compose down && docker compose up -d
```

## [Advanced] Setup the label studio

More details on the `Label Studio`, please refer to the [customized label studio](https://github.com/yjcyxky/label-studio), which is a labeling system for biomedical paper.

### Create a service account on the miniocloud

1. Login to the miniocloud (http://<your-ip>:9000)
2. Click on the `Service Accounts` tab
3. Click on `Create Service Account`
4. Fill in the form and click on `Create` [Don't enable `Restrict with policy`]

### Enable https on the miniocloud

### Setup the label studio
1. Create a project on the label studio
2. Go to the `Settings` tab
3. Click on `Cloud Storage` tab
4. Click on `Add Source Storage` and fill in the form 

> NOTE: 
> 1. You must use the https url of the miniocloud
> 2. You must enable the `Use pre-signed URLs` option, so the label studio can generate the pre-signed url for the html files automatically.

### Prepare the data for the label studio
1. Each task in the label studio is a single HTML file
2. The HTML files must be stored in the miniocloud
3. You must create a `tasks.json` file that contains the list of the HTML files
4. Each task in the `tasks.json` file must have the following format:
```
# `html` is a variable that contains the path to the html file, you need to keep it same with your labeling interface settings.
# Label studio will automatically fetch the html file from the miniocloud
[
    {
        "html": "s3://<bucket_name>/<path_to_the_html_file>",
        "pdf": "<embed src='https://<bucket_name>.minio.<region>.miniocloud.com/<path_to_the_pdf_file>' width='100%' height='100%' type='application/pdf'>"
    }
]

# NOTE:
# If you want to show the pdf file on Chrome, it may complain about the sandboxing. I've no idea how to fix it. But it works on Firefox.
```

### How to prepare your data
1. To choose a query string that can be used to query pubmed for the papers you want to label
2. To Prepare a yaml file which contains two fields: `query_str`, `author` and `download_pdf`. You need to use plain text editor or code editor to create the yaml file. The yaml file must have the following format:

    ```yaml
    query_str: "your query string"
    author: "your name"
    download_pdf: true
    ```

    > NOTE:
    > 1. The `query_str` field is used to query pubmed for the papers you want to label
    > 2. The `author` field is used to identify who is labeling the papers
    > 3. The `download_pdf` field is used to indicate whether the pipeline should download the pdf files of the papers automatically. If you set it to `true`, the pipeline will download the pdf files of the papers automatically. If you set it to `false`, the pipeline will not download the pdf files of the papers automatically. You can download the pdf files manually by `paper-downloader` tool. After downloading all pdfs of the papers, you need to reimport the metadata file to the label studio. The metadata file will be stored in the `metadata/<project_name>` folder. The pdf files will be stored in the `pdf` folder. [NOTE: Not all the papers have pdf files, if you see a paper that doesn't have a pdf file on label studio, it means the pipeline couldn't download the pdf file of the paper automatically. You can download the pdf file manually and upload it to the pdf folder]
    > 4. The `download_pdf` field is optional. If you don't set it, the pipeline will not download the pdf files of the papers automatically.

3. To upload the yaml file to the `config/<project_name>` folder
4. Wait a few minutes for the pipeline to fetch the papers and generate the metadata file for the papers. The metadata file will be stored in the `metadata/<project_name>` folder. If you want to check the progress of the pipeline, you can check the dingtalk group. But if you enable the `download_pdf` field, the pipeline will take a long time to download the pdf files of the papers. So you can check the progress of the pipeline by checking the `pdf/<project_name>` folder. The pipeline will download the pdf files of the papers one by one. If you see a pdf file in the `pdf/<project_name>` folder, it means the pipeline has finished downloading the pdf file of the paper.
5. If you see a notification in the dingtalk group, it means the pipeline has finished fetching the metadata of papers. After that, the system administrator will also get the notification and upload the metadata file to the label studio and download all the pdf files of the papers. The pdf files will be stored in the `pdf/<project_name>` folder. [**NOTE: Not all the papers have pdf files, if you see a paper that doesn't have a pdf file on label studio, it means the pipeline couldn't download the pdf file of the paper automatically. You can download the pdf file manually and upload it to the pdf folder**]
6. To start labeling the papers;

### Templates

#### For Abstract Labeling

```
<View>
  <View>
    <Style>
        .rating div { margin-top: 0px !important; margin-bottom: 0px !important; }
        .rating h4 { font-size: 14px; font-weight: 400; }
        .htx-richtext { text-align: justify; }
        .text-area { width: 100%; }
        .title { display: inline-flex; margin-right: 10px; }
        .lsf-labels { margin: 0px !important; }
        .lsf-main-view { background-color: #ffffff; }
        .lsf-richtext__iframe { max-height: 400px; }
    </Style>
    <View style="display:flex;align-items:start;flex-direction:column;">
      <View style="margin-bottom: 5px;">
        <Filter toName="label" minlength="0" name="filter"/>
      </View>
      <Labels name="label" toName="text" showInline="true">
        <Label value="gene" background="red"/>
        <Label value="protein" background="orange"/>
        <Label value="disease" background="olive"/>
        <Label value="symptom" background="indigo"/>
        <Label value="metabolite" background="green"/>
        <Label value="pathway" background="violet"/>        
        <Label value="anatomy" background="grey"/>
        <label value="microbe" background="yellow"/>
        <label value="chemical" background="black"/>
        <label value="biological_process" background="purple"/>
        <label value="cellular_component" background="pink"/>
        <label value="molecular_function" background="olive"/>
        <Label value="key_sentence" background="blue"/>
      </Labels>
      <View className="title">
        <Header value="$title" underline="true"/>
      </View>
      <View className="rating" style="display: flex; flex-direction: row; align-items: center;">
        <Header value="$journal | IF: $impact_factor | PMID: $pmid" underline="false" />
        <Choices name="valid" showInline="true" toName="text" choice="single-radio">
          <Choice alias="YES" value="YES"/>
          <Choice alias="NO" value="NO"/>
          <Choice alias="UNKNOWN" value="Unknown"/>
        </Choices>
        <Rating name="rating" toName="text" maxRating="5" icon="star" size="medium"/>
      </View>
      <View style="width:100%;">
        <Text name="text" valueType="text" value="$abstract"/>
      </View>
      <View className="text-area">
        <Choices name="full_text_required" showInline="true" toName="text" choice="single-radio">
          <Choice alias="YES" value="YES (Full Paper Required)" hint="Need to label full paper."/>
          <Choice alias="NO" value="NO" selected="true" />
        </Choices>
        <TextArea name="notes" toName="text" required="false" maxSubmissions="1" rows="5" placeholder="Input your notes."/>
      </View>
      <View>
        <Relations>
          <Relation value="biomarker"/>
          <Relation value="treats"/>
          <Relation value="associated_with"/>
          <Relation value="upregulated_in"/>
          <Relation value="downregulated_in"/>
          <Relation value="activated_by"/>
          <Relation value="inhibited_by"/>
          <Relation value="reduced_by"/>
          <Relation value="increased_by"/>
          <Relation value="alleviated_by"/>
          <Relation value="induced_by"/>
        </Relations>
      </View>
    </View>
  </View>
</View>
```

#### For Full Text Labeling


```
<View>
  <View>
    <Style>
        .rating div { margin-top: 0px !important; margin-bottom: 0px !important; }
        .htx-richtext { text-align: justify; }
        .text-area { width: 100%; }
        .title { display: inline-flex; margin-right: 10px; }
        .lsf-labels { margin: 0px !important; }
        .lsf-main-view { background-color: #ffffff; }
        .lsf-richtext__iframe { max-height: 400px !important; }
        .html .lsf-richtext__iframe { min-height: 600px !important; }
    </Style>
    <View style="display:flex;align-items:start;flex-direction:column;">
      <View style="margin-bottom: 5px;">
        <Filter toName="label" minlength="0" name="filter"/>
      </View>
      <Labels name="label" toName="html" showInline="true">
        <Label value="gene" background="red"/>
        <Label value="protein" background="orange"/>
        <Label value="disease" background="olive"/>
        <Label value="metabolite" background="green"/>
        <Label value="pathway" background="violet"/>        
        <Label value="anatomy" background="grey"/>
        <label value="microbe" background="yellow"/>
        <label value="chemical" background="black"/>
        <label value="biological_process" background="purple"/>
        <label value="cellular_component" background="pink"/>
        <label value="molecular_function" background="olive"/>
        <Label value="key_sentence" background="blue"/>
      </Labels>
      <View className="title">
        <Header value="$title" underline="true"/>
      </View>
      <View className="rating" style="display: flex; flex-direction: row; align-items: center;">
        <Header value="$journal | IF: $impact_factor | PMID: $pmid" underline="false" />
        <Choices name="valid" showInline="true" toName="html" choice="single-radio">
          <Choice alias="YES" value="YES"/>
          <Choice alias="NO" value="NO"/>
          <Choice alias="UNKNOWN" value="Unknown"/>
        </Choices>
        <Rating name="rating" toName="html" maxRating="5" icon="star" size="medium"/>
      </View>
      <View style="width:100%;" className="html">
       	<HyperText name="html" value="$html" valueType="url" />
      </View>
      <View className="text-area">
        <TextArea name="notes" toName="html" required="false" maxSubmissions="1" rows="5" placeholder="Input your notes."/>
      </View>
      <View>
        <Relations>
          <Relation value="associated_with"/>
          <Relation value="upregulated_in"/>
          <Relation value="downregulated_in"/>
          <Relation value="activated_by"/>
          <Relation value="inhibited_by"/>
          <Relation value="reduced_by"/>
          <Relation value="increased_by"/>
          <Relation value="alleviated_by"/>
          <Relation value="induced_by"/>
        </Relations>
      </View>
    </View>
  </View>
</View>
```

## Quickstart with an ML backend

### Launch the ML backend

Label Studio supports integration with machine learning backends. You can use a machine learning backend to pre-label your data, or to automatically label your data as it is uploaded to Label Studio. For more information, see the [Label Studio documentation](https://labelstud.io/guide/ml).

To start an example machine learning backend with Docker Compose, do the following:

- Make sure port 9090 is available (or override it with –port parameter).

- Clone the current git repository. From the command line, run the following:

```
git clone https://github.com/heartexlabs/label-studio-ml-backend
```

- Change to the directory with the Docker Compose configuration file. From the command line, run the following:
bash

```
cd models/ner
```

- Start Docker Compose. From the command line, run the following:

```
docker-compose up
```

The machine learning backend server starts becomes available at http://localhost:9090. You can now add the machine learning backend to Label Studio and set up your project.

> NOTICES:
>
> 1. Current model only support one to_name field in the configuration of the label studio. Otherwise, it will complain about the `assert len(self.parsed_label_config) == 1` error. One solution is that you define one to_name field first and then add other to_name fields after the model added to the label studio.
> 2. The model will only label the text field. Don't use HyperText field in the configuration of the label studio. Otherwise, it will complain about the `Cannot convert string to int` error.

### Add an ML backend using the Label Studio UI

In the Label Studio UI, open the project that you want to use with your ML backend.

- Click Settings > Machine Learning.

- Click Add Model.

- Type a Title for the model and provide the URL for the ML backend. For example, http://localhost:9090.

  > NOTE: If you run the ML backend and Label Studio in docker containers or on different machines, you must use the IP address or url of the machine that runs the ML backend. For example, http://example.com:9090.

  - (Optional) Type a description.

  - (Optional) Select Use for interactive preannotation. [NOTE: Don't use this option, if your model is not accurate enough, it will mess up your data.]
  
- Click Validate and Save.

If you see any errors, see [Troubleshoot](https://labelstud.io/guide/ml_troubleshooting) machine learning.