## How to use this program

First, get the datasets from datashare.vic.gov.au, extract them, and put them in the ../local/datashare/data directory. Make sure that in the data directory, the structure is as follows:

```
../local/datashare/data/<dirname>/<shapefilename>.shp
```

With the format above, the program will assume that the shapefilename is the name of the table, and the dirname is the schema name. If you want to change the format above, you can do so by editing the gen-load-bat.py file.

The program will load shp files and dbf files to the database. The program will also create the schemas and tables for you.

Then, run gen-load-bat.py to generate the batch files for loading the shapefiles to the database.

After that, run the load-to-postgres.bat file to load the shapefiles to the database.

During the loading process, the program will log the progress to the ../local/logs directory. You can check the loading progress by running `check-progress.bat <logfilepath>` to see the progress of the loading process. 

manual.md contains the manual for doing various tasks related to the program.