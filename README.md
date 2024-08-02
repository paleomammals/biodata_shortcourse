# biodata_shortcourse

This repository contains the tutorial files for an introductory workshop in species distribution modeling and forecasting in R using data from GBIF and NeotomaDB. This course was taught in summer 2023 and 2024 by Val Syverson and Nat Brown, under the title "Data Science for Nature Conservation", at [UC Merced Bobcat Summer STEM Academy](https://calteach.ucmerced.edu/bobcat-summer-stem-academy). The development of this workshop was funded by [NSF Award #2149416](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2149416&HistoricalAwards=false).

## Downloading and using the course materials
To use these course files, clone the repo and follow along with the instructions in "day1_tutorial.html" and "day2_tutorial.html". These will call the other files in the main folder and in 'paleoclimate'. The empty folder 'temp' is also necessary.

The 'development' folder contains files that were used to create the other files, and should be of no concern to most users.

## Structure of the course
This lesson plan reflects how the course was taught as a three-day workshop in 2024.

### Day 1
Students should follow along with the instructions in "day1_tutorial.html".

- Parts 1-2 are a short introduction to the basics of R and RStudio, and requires no additional files or libraries.
- Part 3 calls species geographic occurrence data from the [GBIF](gbif.org) API and guides the student through the process of cleaning and mapping the data.
  - The tutorial shows the results when the species chosen in section 3 is _Morpho menelaus_, the blue morpho butterfly. Students should choose another species from the list in "Species List for Day 1.xlsx", or choose another species listed in GBIF. The tutorial will work best for species with between 1000 and 10,000 total occurrences globally.
  - The coordinate filters used for the data cleaning steps will also need to be customized for the particular species, based on the preliminary mapping results. _Morpho menelaus_ has a South American distribution, so the points in Europe were excluded on the basis that they were probably captive specimens, but this is certainly not true for every species.
- Part 4 calls modern bioclimatic data from the WorldClim API and maps them.

Students should save the R environment and generated data and image files locally, in order to avoid redoing everything on day 2. The specifics of how to do this will vary depending on specifics of your classroom computer setup, so **no instructions are given for this part** in the tutorials.

### Day 2
Students should load their data files from Day 1, and optionally their R environment file, and then follow along with the instructions in "day2_tutorial.html".

- Part 1 models species distributions using the Bioclim and GLM methods and compares the results, with the tutorial images again showing the result for _Morpho menelaus_. The students will use their same species data that they mapped on Day 1.
  - Note that several steps have been taken here to minimize memory problems, rather than for pedagogical reasons. If your student computers have more memory than ours, please modify or omit these steps.
    - The Maxent model which is most generally used is _not_ implemented here; this is because our student computers did not have enough memory to run it. The Maxent modeling algorithm is also implemented in the library 'dismo' that is already used here, and students with sufficiently powerful computers can be encouraged to experiment with its performance as well.
    -  At the end of this section, students are directed to save their results to an external file and unload them from the workspace in order to free up memory.
-  Part 2 uses the paleoclimate layers in the 'paleoclimate' folder, which are called and assembled into rasterstacks when you source 'assemble-paleoclimate.R'.
  -  Students should choose a place that is interesting to them for this step, find its lat/long coordinates, and examine the changes in its bioclim variables over time.
-  Part 3 combines the paleoclimate and future climate layers with species occurrence data from the corresponding time intervals in order to forecast future species distribution.
  -  For this section, students should choose a new species from the list in "Species List Day 2.xlsx", which is also printed by the command 'names(neotoma_lonlat)'. These species were chosen for their good fossil records in [NeotomaDB](neotomadb.org). Most of the Day 1 species have little to no fossil record and will not produce good forecast results.
  -  The 'pred()' steps are slow. Students can use this time to move ahead into the Day 3 instructions and start drafting their presentations. 

### Day 3
There is no tutorial for Day 3. Instead, students can download the file "student presentation template.pptx" and use it to write up their presentation. Instructors are encouraged to customize this part of the lesson before students get to it. 
- Student evaluations indicated that it was helpful in contextualizing the purpose of the data science exercises in the first two days, but researching and preparing it required a full day of work with substantial instructor support.
- Research suggestions are given in the grey slides at the beginning; instructors should customize these to your own institutional resources.
- The suggested content is given in the white slides; students should use these to guide their own short presentations of their results. 

# Contact
For questions, please file issues on this github page or contact the lead author: Val Syverson (vsyverson@gmail.com)