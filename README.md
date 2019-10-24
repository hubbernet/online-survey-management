# online-survey-management
This project  show you how to deploy a survey online using flask, plumer and elasticsearch.

# Prerequisites
In this project, you need **python**, **R** and **elasticsearch** installed in your machine.
There two folders:
* Flask : this folder is used to deploy your survey with flask
* R : this folder create an API used to put data into elasticsearch using two libraries:
  - **plumber**
  - **elasticsearchr**
  
Finally you need to create an index and a document to stock your data in elasticsearch

**NB** : we can deploy a survey with python only but the idea behind this project is to show how *API* created with plumber R can interact with other framework.
*You can download elasticsearch [here](https://www.elastic.co/fr/downloads/elasticsearch)*
