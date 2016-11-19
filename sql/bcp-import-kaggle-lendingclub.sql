#!/bin/bash	

BCP kaggle-public.dbo.loan IN C:/Users/mikem/Dropbox/loan.csv -S kaggle-public.database.windows.net; -U mm@kaggle-public.database.windows.net -c
