# mlj18-metaopt
Code and experimental data for the paper:
A. Cropper and S.H. Muggleton. Learning efficient logic programs. Machine learning journal. In press.
http://andrewcropper.com/pubs/mlj18-metaopt.pdf

For each experiment:

- data are in the folder 'data'
- learned programs are in the folder 'programs'
- results of the tests are in the folder 'results'

1. To reproduce the figures, run 'python results.py'
2. To rerun the testing step, run 'bash test.sh' and then run steps 1.
3. To rerun the learning step, run 'bash learn.sh' then run steps 2 and 3.
4. To generate new data, run 'bash gen-data.sh', then run steps 1, 2, and 3.
