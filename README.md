# CLEAR_inspect
Inspection tool for HST CLEAR program

--Update: Dec 6, 2017:  updated file structure.   Now expects files to
be in:

./Files/Spectra/COMBINED/2D/FITS/   # all the combined 2D files

./Files/Spectra/COMBINED/2D/PNG/   # all the combined 2D files

./Files/Spectra/COMBINED/1D/FITS/   # all teh combined 1D files

./Files/Spectra/all/      #  all the 1D and 2D files at individual PAs

--Update: Jan 27, 2017:  Command "comm" or "c" will toggle on and off contamination subtraction for the combination and the individual PAs

This GitHub directory contains the IDL inspection tool (inspect_clear.pro), as well as a "Files" directory, which includes:
- pro: this contains procedures needed by the tool, and needs to be placed in your IDL path
- filters: this contains HST filter curves, which are used by the tool
- Samples: this contains IDL structures which contain information on the high-z galaxies inspected by the tool

To run the inspection tool:
- Download the latest version from GitHub
- Download the latest reduction of the CLEAR spectra from the
archive.stsci.edu site
-- https://archive.stsci.edu/pub/clear_team/
- The files will be put in directories like
  - ./COMBINED/2D/PNG
  - ./COMBINED/2D/FITS
  - ./COMBINED/1D/FITS
  - ./all/
- and those are where you need to point the inspect_clear.pro code
  above.  
  - The default location for these is at Files/Spectra/ , though you can place
them anywhere, and set the flag "specpath" when you run the inspection tool
- Go to the top directory (where inspect_clear.pro) is, and run IDL
- Run the tool by typing: inspect_clear,fieldname
  - Where fieldname is the field you want to inspect, typed as a
  string.
  - For example:  inspect_clear,'GS1'
	- Optional keywords are:
        - specpath=fullpathtospectra
        - zsample=z, where z is the integer redshift you would like to inspect (if you type 4 or 5, you will inspect the
        z=4 and 5 sources together, if you type 6, 7 or 8, you will
        inspect the z=6-8 sources together).
- The code automatically saves the results as a structure "result"
  - result.inspect is an integer, which is -1 if it hasn't been inspected, is set to 1 for good, and 0 for bad
  - result.notes is a string where you can store some short notes for each object

# - Everything below this line is old.... ignore for now?

Google Site data repository
#  - We decided to put these in folders based on the month they were reduced
#    - Right now, mar2016 is the current reduction for GS1, GS2, GS3 and GS5
- Download the latest reduction of the CLEAR spectra from the STScI repository:
     - https://archive.stsci.edu/pub/clear_team/
- Make a local Spectra directory, and inside that, unzip and untar each of the ~few dozen data directories (do not combine those for the same field, just leave them separate)
  
