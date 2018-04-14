# mlj18-metaopt
Code and experimental data for the paper:

A. Cropper and S.H. Muggleton. Learning efficient logic programs. Machine learning journal. In press.

http://andrewcropper.com/pubs/mlj18-metaopt.pdf

For each experiment:

- data are in the folder 'data'
- learned programs are in the folder 'programs'
- results of the tests are in the folder 'results'

1. To reproduce the figures, run 'python results.py'
2. To rerun the testing step, run 'bash test.sh'
3. To rerun the learning step, run 'bash learn.sh'
4. To generate new data, run 'bash gen-data.sh'

Through combinations of the above you can reproduce the experimental results with either the same data or new data. 
