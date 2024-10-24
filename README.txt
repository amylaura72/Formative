-----environment-------
This code was run on a Windows 11 computer using a Linux subsystem

The envorinment environment incluses the versions of R and tidyverse used as well as any other R packages. 


----- Data summary -----
1. body measures data
   contained within 1 file
   comma separated 
   line count - 9951 (data on 9950 people)
   column heading are on top line - no extra info at top or bottom of file
   number of columns - 28 (all rows have this many columns 
2. Accel data
   contained in 7455 files
   tab separated
   31396 and 39812 both have 10082 lines, but some of them seem to have less
   Top row sees to contains ID and second row contains headers in most
   number of columns - 8 (from inspecting top and bottom of 38693 and 32943
      there are some lines with only 3 columns instead
      these lines are all have 3 columns which read "NA	NA	NA"
      these lines are either in 31268 or 34974
   headers occur 7455 times, so likely once per file
3. Demographics data
   Contained within 1 file
   line count - 10384
   one participant per row
   Includes demographic data about patients: including gender, age and
   ethnicity (which will be the ones used)
