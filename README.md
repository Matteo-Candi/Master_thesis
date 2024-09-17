# Master Thesis

The content of this repository present the material used for the development of my master thesis in Data Science.

## Description

## Folders Content

- `benchmark`: folder with Java and Python scripts used as benchmark for the code translation and evaluation
- `code`: folder with the code of the entire project
- `predictions`: folder contatining the translations generated by the different versions of the model
- `results`: folder containing the translation generated with the performance metrics of each model version and tests results

## Steps

The three main step of this project are:

- `NOSE`: algorithm utilized to select the list of the layers indexes that contain the self attention mechanism that less influence the model output based on transfer entropy ([algorithm file](code/NOSE.py));
- `Training`: once defined the list of layer indexes the model is been retrained 4 times diluting 1, 2, 5 and 10 attention mechanism from the respective layers (more info in [code/training](code/training/))
- `Evaluation`: after the training the model is used to make new translation, evaluating the results and the model characteristics using few metrics (more information in [code](code))
